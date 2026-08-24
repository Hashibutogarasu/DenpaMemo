import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/app_error.dart';
import '../../domain/master_data/master_data_load_error.dart';
import '../../providers/master_data_providers.dart';
import 'error_dialog.dart';

/// Shows [ErrorDialog] once per `masterDataProvider` failure, shared by
/// every page that watches it (`home.dart`, `search.dart`,
/// `search_results.dart`), so the retry wiring for
/// [MasterDataConnectionError] lives in exactly one place instead of
/// being copied into each page's `build`.
void listenForMasterDataErrors(WidgetRef ref, BuildContext context) {
  ref.listen(masterDataProvider, (previous, next) {
    final error = next.error;
    if (error == null || previous?.error == error) {
      return;
    }
    final appError = switch (error) {
      MasterDataConnectionError() => MasterDataConnectionError(
        onRetry: () => ref.refresh(masterDataProvider.future),
      ),
      AppError() => error,
      _ => MasterDataServerError('$error'),
    };
    ErrorDialog.show(context, error: appError);
  });
}
