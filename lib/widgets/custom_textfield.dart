import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class CustomTextFields extends StatelessWidget {
  const CustomTextFields({
    super.key,
    this.textFieldName = '',
    this.hintText = '',
    this.trailingIcon,
    this.leadingIcon,
    this.filled = false,
    this.inputBorder,
    this.validator,
    this.textInputType = TextInputType.text,
    this.onChange,
    required this.textFieldController,
  });

  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final String textFieldName;
  final String hintText;
  final TextInputType textInputType;
  // final AppTextStyle appTextStyle = AppTextStyle();
  final bool filled;
  final TextEditingController textFieldController;
  final Function(String)? onChange;

  ///validation
  final String? Function(String?)? validator;

  final InputBorder? inputBorder;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (textFieldName != '')
          Column(
            children: [
              Text(
                textFieldName.tr,
                // style: appTextStyle.montserrat14W600,
              ),
              const SizedBox(height: 6)
            ],
          ),
        TextFormField(
          validator: validator,
          keyboardType: textInputType,
          controller: textFieldController,
          decoration: InputDecoration(
            border: inputBorder,
            filled: filled,
            fillColor: AppColors.lightGrey,
            hintText: hintText,
            suffixIcon: trailingIcon,
            prefixIcon: leadingIcon,
          ),
          onChanged: onChange,
        )
      ],
    );
  }
}
