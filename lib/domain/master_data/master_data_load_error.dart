import 'package:graphql_flutter/graphql_flutter.dart';

import '../../errors/app_error.dart';
import '../../i18n/gen/strings.g.dart';

/// Base type for every way `masterDataProvider` can fail to load
/// [MasterData](master_data.dart) from the `modules/server` GraphQL API.
abstract class MasterDataLoadError extends AppError {
  const MasterDataLoadError({super.onRetry});

  /// Maps a failed GraphQL call to the appropriate [MasterDataLoadError]
  /// subtype: [MasterDataConnectionError] if the request never reached
  /// the server (a [OperationException.linkException] is set), otherwise
  /// [MasterDataServerError] for a server-returned GraphQL error.
  ///
  /// Deliberately not `const`: each call is a distinct failure occurrence
  /// (even though `MasterDataConnectionError` itself has no fields to
  /// tell them apart), and `listenForMasterDataErrors`
  /// (`widgets/dialog/master_data_error_listener.dart`) relies on that —
  /// a `const` instance would get canonicalized to the same object
  /// across every retry, making its `previous?.error == error` check
  /// mistake a brand-new failure for the one already shown.
  factory MasterDataLoadError.fromOperationException(
    OperationException exception,
  ) {
    if (exception.linkException != null) {
      return const MasterDataConnectionError();
    }
    return MasterDataServerError(
      exception.graphqlErrors.map((error) => error.message).join('\n'),
    );
  }
}

/// The GraphQL request never reached the server at all (connection
/// refused, timed out, DNS failure, etc.) — as opposed to
/// [MasterDataServerError], where the server responded but with a
/// GraphQL-level error.
///
/// [AppError.onRetry] is left unset by
/// [MasterDataLoadError.fromOperationException] (the data layer that
/// throws this has no way to re-trigger `masterDataProvider`); the UI
/// layer that catches it and shows `ErrorDialog` supplies one (e.g.
/// `() => ref.refresh(masterDataProvider.future)`) so the dialog's retry
/// button has something to call.
class MasterDataConnectionError extends MasterDataLoadError {
  const MasterDataConnectionError({super.onRetry});

  @override
  String title(Translations t) => t.masterData.connectionErrorTitle;

  @override
  String description(Translations t) => t.masterData.connectionErrorDescription;
}

/// The server was reachable but returned a GraphQL error response.
class MasterDataServerError extends MasterDataLoadError {
  const MasterDataServerError(this.message, {super.onRetry});

  final String message;

  @override
  String title(Translations t) => t.masterData.serverErrorTitle;

  @override
  String description(Translations t) =>
      t.masterData.serverErrorDescription(message: message);
}
