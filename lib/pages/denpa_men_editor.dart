import 'package:data_pack/data_pack.dart';
import 'package:denpamemo_widgets/denpamemo_widgets.dart'
    hide BuildContextTranslationsExtension;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_icon_providers.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/denpa_men_session_providers.dart';
import '../providers/qr_code_providers.dart';
import '../routing/app_router.dart';
import '../widgets/icon/editable_denpa_men_icon_swiper.dart';
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
  late DenpaMen _denpaMen =
      widget.initial?.denpaMen ?? _createDefaultDenpaMen(widget.masterData);

  @override
  void initState() {
    super.initState();
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

  static DenpaMen _createDefaultDenpaMen(MasterData masterData) {
    return createDenpaMen(
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
    );
  }

  void _applyEdit(DenpaMen draft) {
    setState(() {
      _denpaMen = createDenpaMen(
        id: draft.id,
        name: draft.name,
        bodyColors: draft.bodyColors,
        bodyColorShades: draft.bodyColorShades,
        isSpColor: draft.isSpColor,
        headShape: draft.headShape,
        physique: draft.physique,
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
        parentIds: draft.parentIds,
        catchOrder: draft.catchOrder,
        qrCodeId: draft.qrCodeId,
        memo: draft.memo,
        monsterExp: draft.monsterExp,
      );
    });
  }

  void _save() {
    ref
        .read(denpaMenRepositoryProvider)
        .save(_denpaMen, id: widget.initial?.id ?? 0);
    context.pop();
  }

  DenpaMen _withCatchOrder(DenpaMen denpaMen, DenpaMenSession session) {
    if (denpaMen.parentIds.isNotEmpty) {
      return denpaMen;
    }
    return denpaMen.copyWith(
      catchOrder:
          session.existingDenpaMenCount + session.completedDenpaMens.length,
    );
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
      _denpaMen = _withSessionQrCode(_createDefaultDenpaMen(widget.masterData));
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
          : FloatingActionButton.extended(
              onPressed: _save,
              label: Text(t.common.save),
            ),
      body: AddDenpaMen(
        denpaMen: _denpaMen,
        masterData: widget.masterData,
        qrCodeCandidates: qrCodeCandidates,
        onChanged: _applyEdit,
        qrCodeEditable: !widget.sessionMode,
        icon: EditableDenpaMenIconSwiper(denpaMenId: _denpaMen.id, size: 56),
        iconFile: ref.watch(denpaMenIconProvider(_denpaMen.id)).value,
        parentCandidates:
            ref.watch(denpaMenListProvider(widget.masterData)).value ?? [],
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
      ),
    );
  }
}
