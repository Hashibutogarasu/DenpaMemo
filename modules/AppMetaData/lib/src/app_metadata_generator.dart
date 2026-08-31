import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'app_meta_data.dart';

Builder appMetadataBuilder(BuilderOptions options) {
  return SharedPartBuilder([AppMetadataGenerator()], 'app_metadata');
}

/// Emits a top-level `const` instance of the annotated class (which must
/// be a real `@freezed` class with `author`/`license` fields), populated
/// from this file's own package's `pubspec.yaml` `app_metadata` section.
/// The instance name is the class name with a lowercase first letter
/// (e.g. `AppMetadataConfig` -> `appMetadataConfig`).
class AppMetadataGenerator extends GeneratorForAnnotation<AppMetaData> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final pubspecId = AssetId(buildStep.inputId.package, 'pubspec.yaml');
    final pubspecContent = await buildStep.readAsString(pubspecId);
    final pubspec = loadYaml(pubspecContent) as YamlMap;
    final metadata = pubspec['app_metadata'] as YamlMap?;
    final author = metadata?['author'] as String? ?? '';
    final license = metadata?['license'] as String? ?? '';

    final className = element.name!;
    final instanceName = className[0].toLowerCase() + className.substring(1);
    return '''
const $instanceName = $className(
  author: '${_escape(author)}',
  license: '${_escape(license)}',
);
''';
  }
}

String _escape(String value) =>
    value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
