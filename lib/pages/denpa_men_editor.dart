import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../domain/denpa_men/denpa_men_factory.dart';
import '../domain/denpa_men/denpa_men_record.dart';
import '../domain/master_data/master_data.dart';
import '../domain/qr_code/qr_code_factory.dart';
import '../i18n/gen/strings.g.dart';
import '../providers/denpa_men_providers.dart';
import '../providers/denpa_men_session_providers.dart';
import '../providers/qr_code_providers.dart';
import '../routing/app_router.dart';
import '../widgets/add_denpa_men.dart';
import '../widgets/label/outlined_title.dart';
import '../widgets/scaffold/app_scaffold.dart';

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

  static DenpaMen _createDefaultDenpaMen(MasterData masterData) {
    return createDenpaMen(
      name: '',
      bodyColors: [masterData.bodyColorResistanceRules.first.colorId],
      isSpColor: false,
      headShape: masterData.headShapes.first,
      physique: masterData.physiques.first,
      personality: masterData.personalities.first,
      pattern: masterData.patterns.first,
      anntena: masterData.anntenas.first,
      masterData: masterData,
      maxHappiness: 0,
      level: 1,
      maxLevel: 1,
      corrections: const [],
    );
  }

  void _applyEdit(DenpaMen draft) {
    setState(() {
      _denpaMen = createDenpaMen(
        name: draft.name,
        bodyColors: draft.bodyColors,
        isSpColor: draft.isSpColor,
        headShape: draft.headShape,
        physique: draft.physique,
        personality: draft.personality,
        pattern: draft.pattern,
        anntena: draft.anntena,
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
        memo: draft.memo,
      );
    });
  }

  void _save() {
    ref
        .read(denpaMenRepositoryProvider)
        .save(_denpaMen, id: widget.initial?.id ?? 0);
    context.pop();
  }

  void _next() {
    ref.read(denpaMenSessionProvider.notifier).addDraft(_denpaMen);
    setState(() {
      _denpaMen = _createDefaultDenpaMen(widget.masterData);
    });
  }

  void _complete() {
    final session = ref.read(denpaMenSessionProvider);
    if (session == null) {
      return;
    }
    final denpaMens = [...session.completedDenpaMens, _denpaMen];
    final qrCode = createQrCode(session.cuid);
    ref
        .read(qrCodeRepositoryProvider)
        .saveWithDenpaMens(qrCode, denpaMens, widget.masterData);
    ref.read(denpaMenSessionProvider.notifier).clear();
    ref.invalidate(denpaMenListProvider(widget.masterData));
    const HomeRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AppScaffold(
      title: OutlinedTitleText(
        text: widget.initial == null
            ? t.page.addDenpaMen
            : t.page.editDenpaMen,
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
              icon: const Icon(Icons.check),
              label: Text(t.common.save),
            ),
      body: AddDenpaMen(
        denpaMen: _denpaMen,
        masterData: widget.masterData,
        onChanged: _applyEdit,
      ),
    );
  }
}
