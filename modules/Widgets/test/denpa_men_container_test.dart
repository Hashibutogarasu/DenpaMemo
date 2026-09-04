import 'dart:io';

import 'package:denpamemo_widgets/denpamemo_widgets.dart';
import 'package:denpamemo_widgets/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final iconFile = File('representative-icon.png');
  final faceFile = File('face.png');
  final wholeBodyFile = File('wholeBody.png');
  final unsortedCandidates = <DenpaMenZoomCandidate>[
    (priority: 2, file: faceFile, label: 'face'),
    (priority: 0, file: iconFile, label: 'icon'),
    (priority: 1, file: wholeBodyFile, label: 'wholeBody'),
  ];

  testWidgets(
    'normally shows only the single representative icon, not the zoom candidates',
    (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: DenpaMenContainer(
            denpaMen: DenpaMenData.denpaMen,
            iconFile: iconFile,
            zoomCandidates: unsortedCandidates,
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect((image.image as FileImage).file.path, iconFile.path);
    },
  );

  testWidgets('the zoom button is hidden when there are no zoom candidates', (
    tester,
  ) async {
    await tester.pumpWidget(
      TestApp(
        home: DenpaMenContainer(
          denpaMen: DenpaMenData.denpaMen,
          iconFile: iconFile,
        ),
      ),
    );

    expect(find.byIcon(Icons.zoom_in), findsNothing);
  });

  testWidgets(
    'tapping the zoom button opens candidates ordered by ascending priority, '
    'regardless of the order they were passed in',
    (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: DenpaMenContainer(
            denpaMen: DenpaMenData.denpaMen,
            iconFile: iconFile,
            zoomCandidates: unsortedCandidates,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.zoom_in));
      await tester.pumpAndSettle();

      expect(find.byType(MediaZoomDialog), findsOneWidget);
      final firstPageImage = tester.widget<Image>(find.byType(Image).last);
      expect(
        (firstPageImage.image as FileImage).file.path,
        iconFile.path,
        reason:
            'priority 0 (icon) must be shown first, even though it was '
            'passed second in the unsorted candidate list',
      );

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      final secondPageImage = tester.widget<Image>(find.byType(Image).last);
      expect(
        (secondPageImage.image as FileImage).file.path,
        wholeBodyFile.path,
        reason: 'priority 1 (wholeBody) must follow priority 0',
      );
    },
  );
}
