/// Marks a class as the trigger to generate `appMetadataAuthor`/
/// `appMetadataLicense` constants into a `<file>.g.dart` part next to the
/// annotated file. The annotation itself carries no data — it only decides
/// *where* the constants get generated; the values are read from the
/// annotated file's own package's `pubspec.yaml` `app_metadata` section
/// (see `AppMetadataGenerator`).
class AppMetaData {
  const AppMetaData();
}
