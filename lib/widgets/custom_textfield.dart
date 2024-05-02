import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTextFields extends StatelessWidget {
  CustomTextFields({
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
    this.maxLength,
    this.maxLine,
    required this.textFieldController,
  });

  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final String textFieldName;
  final String hintText;
  final TextInputType textInputType;
  final AppTextStyle appTextStyle = AppTextStyle();
  final bool filled;
  final int? maxLine;
  final int? maxLength;
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
                style: appTextStyle.montserrat14W600,
              ),
              const SizedBox(height: 6)
            ],
          ),
        TextFormField(
          maxLines: maxLine,
          maxLength: maxLength,
          validator: validator,
          keyboardType: textInputType,
          controller: textFieldController,
          decoration: InputDecoration(
            border: inputBorder,
            filled: filled,
            fillColor: AppColors.lightGrey,
            hintText: hintText.tr,
            suffixIcon: trailingIcon,
            prefixIcon: leadingIcon,
          ),
          onChanged: onChange,
        )
      ],
    );
  }
}
