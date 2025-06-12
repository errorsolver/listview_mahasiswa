import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  CustomInputText({
    super.key,
    this.thisWidthSize = 300,
    this.thisLabelText = 'Label Placeholder',
    this.thisHintText = 'Hint Placeholder',
    this.isReadOnly = true,
    this.hideNIM = false,
    required this.thisController,
  });

  final double thisWidthSize;
  final String thisLabelText;
  final String thisHintText;
  final bool isReadOnly;
  bool hideNIM;
  final TextEditingController thisController;

  @override
  Widget build(BuildContext context) {
    if (isReadOnly == true && hideNIM == true) {
      hideNIM = true;
    }
    return SizedBox(
      width: thisWidthSize,
      child: TextField(
        decoration: InputDecoration(
          labelText: thisLabelText,
          border: OutlineInputBorder(),
          hintText: thisHintText,
        ),
        readOnly: isReadOnly,
        enabled: !hideNIM,
        controller: thisController,
      ),
    );
  }
}
