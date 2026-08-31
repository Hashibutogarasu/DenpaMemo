import 'dart:io';
import 'dart:typed_data';

import 'package:data_pack/data_pack.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  test('writeDmZip/readDmZip round-trips files, directories and the header', () async {
    final tempRoot = await Directory.systemTemp.createTemp('dm_zip_io_test');
    addTearDown(() async {
      if (await tempRoot.exists()) {
        await tempRoot.delete(recursive: true);
      }
    });

    final sourceDirectory = Directory(path.join(tempRoot.path, 'source'));
    await sourceDirectory.create(recursive: true);
    await File(
      path.join(sourceDirectory.path, 'entries.json'),
    ).writeAsString('{"a":1}');
    final iconDirectory = Directory(
      path.join(sourceDirectory.path, 'icons', 'denpamens', 'some-id'),
    );
    await iconDirectory.create(recursive: true);
    final iconBytes = Uint8List.fromList([1, 2, 3, 4]);
    await File(path.join(iconDirectory.path, 'icon.png')).writeAsBytes(iconBytes);

    final outputFile = File(path.join(tempRoot.path, 'output.dm'));
    await writeDmZip(
      sourceDirectory: sourceDirectory,
      outputFile: outputFile,
      headerComment: '{"dataVersion":"1.0.0"}',
    );
    expect(await outputFile.exists(), isTrue);

    final extractDirectory = Directory(path.join(tempRoot.path, 'extracted'));
    final readResult = await readDmZip(
      inputFile: outputFile,
      outputDirectory: extractDirectory,
    );

    expect(readResult.headerComment, '{"dataVersion":"1.0.0"}');
    expect(
      await File(path.join(extractDirectory.path, 'entries.json')).readAsString(),
      '{"a":1}',
    );
    expect(
      await File(
        path.join(extractDirectory.path, 'icons', 'denpamens', 'some-id', 'icon.png'),
      ).readAsBytes(),
      iconBytes,
    );
  });
}
