import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'app_meta_data.dart';

Builder appMetadataBuilder(BuilderOptions options) {
  return SharedPartBuilder([AppMetadataGenerator()], 'app_metadata');
}

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
    return '''
const String appMetadataAuthor = '${_escape(author)}';
const String appMetadataLicense = '${_escape(license)}';
''';
  }
}

String _escape(String value) =>
    value.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
