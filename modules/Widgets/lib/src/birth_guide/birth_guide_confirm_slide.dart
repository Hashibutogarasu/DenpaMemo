import 'dart:io';

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import 'birth_guide_individual_slide.dart';

class BirthGuideConfirmSlide extends StatelessWidget {
  const BirthGuideConfirmSlide({
    super.key,
    required this.denpaMen,
    required this.totalAttributeCount,
    required this.instruction,
    this.iconFile,
  });

  final DenpaMen denpaMen;
  final int totalAttributeCount;
  final String instruction;
  final File? iconFile;

  @override
  Widget build(BuildContext context) {
    return BirthGuideIndividualSlide(
      denpaMen: denpaMen,
      totalAttributeCount: totalAttributeCount,
      instruction: instruction,
      iconFile: iconFile,
    );
  }
}
