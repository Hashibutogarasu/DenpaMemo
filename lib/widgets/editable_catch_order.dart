import 'package:flutter/material.dart';

import '../domain/denpa_men/denpa_men.dart';
import '../i18n/gen/strings.g.dart';
import 'field/inline_nullable_number_field.dart';

/// Field for editing [DenpaMen.catchOrder], shown below the QR code field
/// only once a QR code is set.
class EditableCatchOrder extends StatelessWidget {
  const EditableCatchOrder({
    super.key,
    required this.denpaMen,
    required this.onChanged,
  });

  final DenpaMen denpaMen;
  final ValueChanged<DenpaMen> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            t.editableStatus.catchOrder,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          InlineNullableNumberField(
            value: denpaMen.catchOrder,
            onChanged: (value) =>
                onChanged(denpaMen.copyWith(catchOrder: value)),
          ),
        ],
      ),
    );
  }
}
