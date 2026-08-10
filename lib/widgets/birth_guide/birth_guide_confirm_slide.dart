import 'package:flutter/material.dart';

import '../../domain/denpa_men/denpa_men.dart';
import 'birth_guide_individual_slide.dart';

class BirthGuideConfirmSlide extends StatelessWidget {
  const BirthGuideConfirmSlide({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
    required this.instruction,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return BirthGuideIndividualSlide(
      denpaMen: denpaMen,
      totalAttributeCount: totalAttributeCount,
      instruction: instruction,
    );
  }
}
