import 'package:flutter/material.dart';

import '../icon/attribute.dart';
import 'attribute.dart';
import 'signed_number.dart';

/// Displays a single attribute resistance entry: a circular icon with the
/// attribute name and its signed value inside [AttributeLabel]'s filled
/// pill, the pill's rounded left edge sharing the icon's exact circle so
/// the two curves overlap seamlessly. The pill stretches to fill whatever
/// width its parent gives it, so entries packed into equal-width columns
/// leave no gap around content narrower than the column.
class AttributeResistanceEntry extends StatelessWidget {
  const AttributeResistanceEntry({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final int value;

  static const double height = 20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: AttributeLabel(
              child: Row(
                children: [
                  const SizedBox(width: height),
                  Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SignedNumberText(value: value),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(left: 0, top: 0, child: AttributeIcon()),
        ],
      ),
    );
  }
}
