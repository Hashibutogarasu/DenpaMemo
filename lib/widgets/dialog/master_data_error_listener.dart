import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_client/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart' show OperationException;
import 'package:step_dialog/step_dialog.dart'
    hide Translations, BuildContextTranslationsExtension;

import '../../domain/master_data/master_data_load_error.dart';
import '../../errors/app_error.dart';
import '../../i18n/gen/strings.g.dart';

/// Shows [ErrorDialog] once per `masterDataProvider` failure, shared by
/// every page that watches it (`home.dart`, `search.dart`,
/// `search_results.dart`), so the retry wiring for
/// [MasterDataConnectionError] lives in exactly one place instead of
/// being copied into each page's `build`.
void listenForMasterDataErrors(WidgetRef ref, BuildContext context) {
  ref.listen(masterDataProvider, (previous, next) {
    _showAppError(
      context,
      previous,
      next,
      () => ref.refresh(masterDataProvider.future),
    );
  });
}

/// Same as [listenForMasterDataErrors], but for `monsterListProvider`
/// (`monster_selection.dart`), which throws the same
/// [OperationException]s from `GraphqlMonsterRepository`.
void listenForMonsterListErrors(WidgetRef ref, BuildContext context) {
  ref.listen(monsterListProvider, (previous, next) {
    _showAppError(
      context,
      previous,
      next,
      () => ref.refresh(monsterListProvider.future),
    );
  });
}

void _showAppError<T>(
  BuildContext context,
  AsyncValue<T>? previous,
  AsyncValue<T> next,
  Future<void> Function() retry,
) {
  final error = next.error;
  if (error == null || previous?.error == error) {
    return;
  }
  final appError = switch (error) {
    OperationException() => switch (MasterDataLoadError.fromOperationException(
      error,
    )) {
      MasterDataConnectionError() => MasterDataConnectionError(onRetry: retry),
      final other => other,
    },
    AppError() => error,
    _ => MasterDataServerError('$error'),
  };
  final t = context.t;
  ErrorDialog.show(
    context,
    title: appError.title(t),
    description: appError.description(t),
    retriable: appError.retriable,
    onRetry: appError.retriable ? appError.retry : null,
  );
}
