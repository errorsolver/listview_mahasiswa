import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listview_mahasiswa/widget/custom_input_text.dart';

@immutable
class InputWrap extends StatelessWidget {
  TextEditingController? nimController;
  TextEditingController? nameController;
  TextEditingController? sexController;
  TextEditingController? enrollController;

  String? nimText;
  String? nameText;
  String? sexText;
  String? enrollText;
  bool? hideNIM = false;
  bool? hideAll = false;

  InputWrap({
    this.nimController,
    this.nameController,
    this.sexController,
    this.enrollController,
    this.hideNIM = false,
    super.key,
  });

  InputWrap.readOnly({
    this.nimText,
    this.nameText,
    this.sexText,
    this.enrollText,
    this.hideAll = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomInputText(
          thisLabelText: 'NIM',
          thisHintText: 'ex: 00001',
          thisController:
              nimController ?? TextEditingController(text: nimText ?? ''),
          isReadOnly: hideAll!,
          hideNIM: hideNIM!,
        ),
        SizedBox(height: 20),
        CustomInputText(
          thisLabelText: 'Nama',
          thisHintText: 'ex: Ronald',
          thisController:
              nameController ?? TextEditingController(text: nameText ?? ''),
          isReadOnly: hideAll!,
        ),
        SizedBox(height: 20),
        CustomInputText(
          thisLabelText: 'Sex',
          thisHintText: 'ex: 0: Laki-laki, 1: Perempuan',
          thisController:
              sexController ?? TextEditingController(text: sexText ?? ''),
          isReadOnly: hideAll!,
        ),
        SizedBox(height: 20),
        CustomInputText(
          thisLabelText: 'Enroll',
          thisHintText: 'ex: 2025',
          thisController:
              enrollController ?? TextEditingController(text: enrollText ?? ''),
          isReadOnly: hideAll!,
        ),
      ],
    );
  }
}
