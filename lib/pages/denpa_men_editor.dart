import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'package:api_client/api_client.dart';
import 'package:collection/collection.dart';
import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/i18n/gen/strings.g.dart'
    as wt
    hide BuildContextTranslationsExtension;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:denpa_memo/widgets.dart';
import '../data/server/physique_legend_grid_args.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_icon_providers.dart';
import '../providers/denpa_men_calculation_providers.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/denpa_men_session_providers.dart';
import '../providers/physiques_providers.dart';
import '../providers/qr_code_providers.dart';
import '../routing/app_router.dart';
import '../services/denpa_men_rust_calculator.dart';
import '../widgets/dialog/physique_search_debug_dialog.dart';
import '../widgets/icon/editable_denpa_men_icon_swiper.dart';
import '../widgets/icon/evasion_rate_sign_icon.dart';
import 'denpa_men_selection.dart';

/// Arguments passed as `$extra` by `AddDenpaMenRoute` (see
/// `routing/app_router.dart`), since [MasterData] and [DenpaMenRecord] carry
/// runtime objects that cannot be encoded into a URL.
class DenpaMenEditorArgs {
  const DenpaMenEditorArgs({
    required this.masterData,
    this.initial,
    this.sessionMode = false,
  });

  final MasterData masterData;
  final DenpaMenRecord? initial;
  final bool sessionMode;
}

/// Full-screen host for [AddDenpaMen]: creates a new [DenpaMen] when
/// [initial] is null, otherwise edits it in place. When [sessionMode] is
/// true, this is one step of a [DenpaMenSession] started from
/// [DenpaMenQrPage]: the floating action button offers "next" (confirm this
/// individual and start a new blank one) in addition to "complete" (persist
/// every individual confirmed in the session, plus the one being edited,
/// through [qrCodeRepositoryProvider]). Otherwise saving writes a single
/// [DenpaMen] through [denpaMenRepositoryProvider] and pops back to the
/// caller.
class DenpaMenEditor extends ConsumerStatefulWidget {
  const DenpaMenEditor({
    super.key,
    required this.masterData,
    this.initial,
    this.sessionMode = false,
  });

  final MasterData masterData;
  final DenpaMenRecord? initial;
  final bool sessionMode;

  @override
  ConsumerState<DenpaMenEditor> createState() => _DenpaMenEditorState();
}

class _DenpaMenEditorState extends ConsumerState<DenpaMenEditor> {
  late DenpaMen _denpaMen;

  @override
  void initState() {
    super.initState();
    _denpaMen =
        widget.initial?.denpaMen ??
        _createDefaultDenpaMen(
          widget.masterData,
          ref.read(denpaMenCalculationEngineProvider),
        );
    if (widget.initial == null && widget.sessionMode) {
      _denpaMen = _withSessionQrCode(_denpaMen);
    }
  }

  DenpaMen _withSessionQrCode(DenpaMen denpaMen) {
    final session = ref.read(denpaMenSessionProvider);
    if (session == null) {
      return denpaMen;
    }
    return denpaMen.copyWith(
      qrCodeId: session.existingQrCode?.id ?? session.cuid,
    );
  }

  DenpaMen _createDefaultDenpaMen(
    MasterData masterData,
    DenpaMenCalculationEngine calculationEngine,
  ) {
    final denpaMen = createDenpaMen(
      name: '',
      bodyColors: [masterData.bodyColorResistanceRules.first.colorId],
      isSpColor: false,
      headShape: masterData.headShapes.first,
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: masterData.anntenas.firstWhere((a) => a.id == 'none'),
      masterData: masterData,
      maxHappiness: 20,
      level: 1,
      maxLevel: 20,
      corrections: const [],
      resistances: (
        abnormalityResistances: const [],
        attributeResistance: const [],
      ),
    );
    return calculationEngine.recalculateResistances(denpaMen, masterData);
  }

  void _applyEdit(DenpaMen draft) {
    setState(() {
      final denpaMen = createDenpaMen(
        id: draft.id,
        name: draft.name,
        bodyColors: draft.bodyColors,
        bodyColorShades: draft.bodyColorShades,
        isSpColor: draft.isSpColor,
        headShape: draft.headShape,
        physique: draft.physique,
        physiqueColumnIndex: draft.physiqueColumnIndex,
        personality: draft.personality,
        pattern: draft.pattern,
        anntena: draft.anntena,
        antennaLevel: draft.antennaLevel,
        masterData: widget.masterData,
        happiness: draft.happiness,
        maxHappiness: draft.maxHappiness,
        level: draft.level,
        maxLevel: draft.maxLevel,
        currentExp: draft.currentExp,
        maxExp: draft.maxExp,
        hp: draft.hp,
        ap: draft.ap,
        attack: draft.attack,
        defense: draft.defense,
        speed: draft.speed,
        evasionRate: draft.evasionRate,
        corrections: draft.corrections,
        considerCorrections: draft.considerCorrections,
        additionalCorrection: draft.additionalCorrection,
        parentIds: draft.parentIds,
        catchOrder: draft.catchOrder,
        qrCodeId: draft.qrCodeId,
        memo: draft.memo,
        monsterExp: draft.monsterExp,
        resistances: (
          abnormalityResistances: const [],
          attributeResistance: const [],
        ),
      );
      _denpaMen = ref
          .read(denpaMenCalculationEngineProvider)
          .recalculateResistances(denpaMen, widget.masterData);
    });
  }

  /// [candidate]'s display text: the server-translated [PhysiqueCategoryCandidate.text]
  /// when identification went through `modules/server`, otherwise this
  /// app's own local translation of [PhysiqueCategoryCandidate.textKey]
  /// (identification computed offline never sets `text`, since that
  /// translation lives server-side) — the raw key only as a last resort.
  String _physiqueCategoryLabel(PhysiqueCategoryCandidate candidate) =>
      candidate.text ?? wt.t.physique[candidate.textKey] ?? candidate.textKey;

  Future<PhysiqueIdentification?> _identifyPhysique(
    BuildContext context,
  ) async {
    final t = context.t;
    final result = await ProgressResultDialog.show<PhysiqueSearchResult>(
      context,
      loadingMessage: t.physiqueIdentification.identifying,
      successMessage: t.physiqueIdentification.identified,
      errorMessage: t.physiqueIdentification.error,
      task: () => ref
          .read(physiqueIdentificationServiceProvider)
          .search(
            hp: _denpaMen.hp,
            evasionRate: _denpaMen.evasionRate,
            antenna: _denpaMen.anntena.id,
            level: '${_denpaMen.level}',
          ),
      resultLabel: (result) => switch (result.matches.firstOrNull?.candidates) {
        null || [] => t.physiqueIdentification.notFound,
        [final only] => _physiqueCategoryLabel(only),
        _ => t.physiqueIdentification.multipleCandidates,
      },
      extraActions: (context, result) {
        final match = result.matches.firstOrNull;
        if (match == null) return const [];
        return [
          OutlinedButton.icon(
            icon: const Icon(Icons.grid_on),
            label: Text(t.physiqueIdentification.matchingLocationButton),
            onPressed: () {
              PhysiqueLegendGridRoute(
                $extra: PhysiqueLegendGridArgs(
                  level: match.level,
                  anntenaCategory: match.anntenaCategory,
                  matchColumnIndex: match.columnIndex,
                  matchLineOffset: match.lineOffset,
                  matchEvasionRate: _denpaMen.evasionRate,
                ),
              ).push(context);
            },
          ),
        ];
      },
    );
    if (result == null || !context.mounted) {
      return null;
    }
    if (kDebugMode && result.info != null) {
      await PhysiqueSearchDebugDialog.show(context, info: result.info!);
      if (!context.mounted) return null;
    }
    final matches = result.matches;
    final columnIndex = matches.firstOrNull?.columnIndex;
    final candidates = matches.firstOrNull?.candidates ?? const [];
    final chosenKey = switch (candidates) {
      [] => null,
      [final only] => only.textKey,
      _ => await CandidateSelectionDialog.show<PhysiqueCategoryCandidate>(
        context,
        title: t.physiqueIdentification.chooseCandidateTitle,
        candidates: candidates,
        label: _physiqueCategoryLabel,
        leading: (candidate) => EvasionRateSignIcon(sign: candidate.sign),
        subtitle: (candidate) =>
            candidate.evasionRateStart == candidate.evasionRateEnd
            ? t.physiqueIdentification.candidateEvasionRateExact(
                value: candidate.evasionRateStart,
              )
            : t.physiqueIdentification.candidateEvasionRateRange(
                start: candidate.evasionRateStart,
                end: candidate.evasionRateEnd,
              ),
        trailingActionIcon: Icons.grid_on,
        onTrailingAction: (candidate) {
          final match = matches.first;
          PhysiqueLegendGridRoute(
            $extra: PhysiqueLegendGridArgs(
              level: match.level,
              anntenaCategory: match.anntenaCategory,
              matchColumnIndex: match.columnIndex,
              matchLineOffset: match.lineOffset,
              matchEvasionRate: _denpaMen.evasionRate,
            ),
          ).push(context);
        },
      ).then((candidate) => candidate?.textKey),
    };
    final physique = chosenKey == null
        ? null
        : widget.masterData.physiques.firstWhereOrNull(
            (p) => p.id == chosenKey,
          );
    if (physique == null) {
      return null;
    }
    return (physique: physique, columnIndex: columnIndex);
  }

  Future<void> _save() async {
    ref
        .read(denpaMenRepositoryProvider)
        .save(_withCatchOrder(_denpaMen), id: widget.initial?.id ?? 0);
    context.pop();
  }

  /// Assigns [DenpaMen.catchOrder] before persistence: a bred individual
  /// inherits the resolved order of its parents, while a directly caught one
  /// takes the next free capture sequence number unless it already has one.
  DenpaMen _withCatchOrder(DenpaMen denpaMen, [DenpaMenSession? session]) {
    if (denpaMen.parentIds.isNotEmpty) {
      return denpaMen.copyWith(
        catchOrder: denpaMen.resolveCatchOrder(_savedDenpaMenById()),
      );
    }
    if (denpaMen.catchOrder != null) {
      return denpaMen;
    }
    return denpaMen.copyWith(catchOrder: _nextCatchOrder(session));
  }

  Map<String, DenpaMen> _savedDenpaMenById() {
    final records = ref
        .read(denpaMenRepositoryProvider)
        .getAll(widget.masterData);
    return {for (final record in records) record.denpaMen.id: record.denpaMen};
  }

  int _nextCatchOrder(DenpaMenSession? session) {
    if (session != null) {
      return session.existingDenpaMenCount + session.completedDenpaMens.length;
    }
    return _savedDenpaMenById().values
        .where((denpaMen) => denpaMen.parentIds.isEmpty)
        .length;
  }

  void _next() {
    final session = ref.read(denpaMenSessionProvider);
    if (session == null) {
      return;
    }
    ref
        .read(denpaMenSessionProvider.notifier)
        .addDraft(_withCatchOrder(_denpaMen, session));
    setState(() {
      _denpaMen = _withSessionQrCode(
        _createDefaultDenpaMen(
          widget.masterData,
          ref.read(denpaMenCalculationEngineProvider),
        ),
      );
    });
  }

  Future<void> _complete() async {
    final session = ref.read(denpaMenSessionProvider);
    if (session == null) {
      return;
    }
    final denpaMens = [
      ...session.completedDenpaMens,
      _withCatchOrder(_denpaMen, session),
    ];
    final qrCode =
        session.existingQrCode ??
        createQrCode(session.cuid, id: session.cuid, name: session.name);
    ref
        .read(qrCodeRepositoryProvider)
        .saveWithDenpaMens(
          qrCode,
          denpaMens,
          widget.masterData,
          id: session.qrCodeEntityId,
        );
    ref.read(denpaMenSessionProvider.notifier).clear();
    ref.invalidate(denpaMenListProvider(widget.masterData));
    ref.invalidate(qrCodeListProvider);
    await ref.read(denpaMenListProvider(widget.masterData).future);
    if (mounted) {
      const HomeRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final session = ref.watch(denpaMenSessionProvider);
    final qrCodeCandidates = <QrCodeRecord>[
      ...ref.watch(qrCodeListProvider).value ?? [],
      if (widget.sessionMode &&
          session != null &&
          session.existingQrCode == null)
        QrCodeRecord(
          id: session.qrCodeEntityId,
          qrCode: createQrCode(
            session.cuid,
            id: session.cuid,
            name: session.name,
          ),
        ),
    ];

    return AppScaffold(
      title: OutlinedTitleText(
        text: widget.initial == null ? t.page.addDenpaMen : t.page.editDenpaMen,
      ),
      floatingActionButton: widget.sessionMode
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'denpaMenEditorNext',
                  onPressed: _next,
                  label: Text(t.common.next),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.extended(
                  heroTag: 'denpaMenEditorComplete',
                  onPressed: _complete,
                  label: Text(t.common.complete),
                ),
              ],
            )
          : SaveButton(save: _save),
      body: AddDenpaMen(
        data: DenpaMenEditorData(
          denpaMen: _denpaMen,
          masterData: widget.masterData,
          qrCodeCandidates: qrCodeCandidates,
          icon: EditableDenpaMenIconSwiper(denpaMenId: _denpaMen.id, size: 56),
          iconFile: ref.watch(denpaMenIconProvider(_denpaMen.id)).value,
          parentCandidates:
              ref.watch(denpaMenListProvider(widget.masterData)).value ?? [],
          qrCodeEditable: !widget.sessionMode,
        ),
        actions: DenpaMenEditorActions(
          onChanged: _applyEdit,
          onPickParents: (context) => DenpaMenSelectionRoute(
            $extra: DenpaMenSelectionArgs(
              excludeId: _denpaMen.id,
              initialSelectedIds: _denpaMen.parentIds,
              maxSelectable: 2,
            ),
          ).push<List<DenpaMenRecord>>(context),
          onPickMonsterExp: (context) => MonsterExpRoute(
            $extra: _denpaMen.monsterExp,
          ).push<MonsterExp>(context),
          onIdentifyPhysique: _identifyPhysique,
        ),
      ),
    );
  }
}
