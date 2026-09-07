import 'dart:io';

import 'package:flutter/material.dart';

import 'package:data_pack/data_pack.dart';

import '../denpa_men_status.dart';
import '../icon/denpa_men_icon_builder.dart';

class BirthGuideIndividualSlide extends StatelessWidget {
  const BirthGuideIndividualSlide({
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(instruction, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          DenpaMenStatus.fromDenpaMen(
            denpaMen,
            totalAttributeCount: totalAttributeCount,
            showIcon: true,
            iconBuilder: staticDenpaMenIconBuilder(iconFile),
          ),
        ],
      ),
    );
  }
}
