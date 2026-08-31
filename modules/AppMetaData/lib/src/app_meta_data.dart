/// Marks a `@freezed` class (with `author`/`license` fields) whose values
/// should be populated with a generated `const` instance in a
/// `<file>.g.dart` part next to the annotated file, sourced from that
/// file's own package's `pubspec.yaml` `app_metadata` section (see
/// `AppMetadataGenerator`).
class AppMetaData {
  const AppMetaData();
}
