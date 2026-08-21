import '../i18n/gen/strings.g.dart';

/// Base type for every error the app surfaces via
/// [ErrorDialog](../widgets/dialog/error_dialog.dart). Each subtype maps
/// itself to display text via [title]/[description], taking the generated
/// [Translations] type (not [BuildContext]) so error classes stay plain
/// domain objects with no widget-tree dependency.
abstract class AppError implements Exception {
  const AppError();

  String title(Translations t);
  String description(Translations t);
}
