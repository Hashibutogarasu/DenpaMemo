import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// A [PathProviderPlatform] that resolves every path query to [path],
/// avoiding the plugin's platform channel entirely. Widget tests exercising
/// code that reads `path_provider` (directly or via `DenpaMenIconStorage`)
/// should install this via `PathProviderPlatform.instance = ...` before
/// pumping, since the channel is unmocked in the `flutter test` host.
class FakePathProviderPlatform extends PathProviderPlatform {
  FakePathProviderPlatform(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;

  @override
  Future<String?> getTemporaryPath() async => path;
}
