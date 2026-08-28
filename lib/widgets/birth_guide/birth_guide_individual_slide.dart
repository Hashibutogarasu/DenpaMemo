import 'package:data_pack/data_pack.dart';
import 'package:flutter/material.dart';

import '../denpa_men_status.dart';

class BirthGuideIndividualSlide extends StatelessWidget {
  const BirthGuideIndividualSlide({
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
          ),
        ],
      ),
    );
  }
}
