import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:car_reception_flutter/common/config/app_colors.dart';

typedef OnChangeCountryCode = void Function(CountryCode countryCode);
typedef OnFieldSubmitted = void Function(String text);

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? validationMsg,
      hintText,
      labelText,
      helperText,
      prefixText,
      suffixText;
  final Widget? prefix, suffix;
  final int? maxLength;
  final bool? isPassword, countryCodeEnabled, isEnabled;
  final bool? isSimpleField;
  final BorderRadius? borderRadius;
  final TextInputType? textInputType;
  final OnChangeCountryCode? onChangeCountryCode;
  final TextInputAction? textInputAction;
  final OnFieldSubmitted? onFieldSubmitted;
  final FocusNode? focusNode;

  TextInput(
      {this.validationMsg,
      required this.controller,
      this.helperText,
      this.suffixText,
      this.prefixText,
      this.prefix,
      this.labelText,
      this.hintText,
      this.suffix,
      this.textInputType,
      this.isPassword,
      this.maxLength,
      this.countryCodeEnabled,
      this.borderRadius,
      this.isSimpleField,
      this.onChangeCountryCode,
      this.textInputAction,
      this.onFieldSubmitted,
      this.focusNode,
      this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: isPassword != null && isPassword == true ? 1 : 4,
      onFieldSubmitted: (value) =>
          onFieldSubmitted != null ? onFieldSubmitted!(value) : null,
      focusNode: focusNode,
      readOnly: isEnabled ?? false,
      style: TextStyle(
        fontSize: 17,
        color: AppColors.black,
        fontWeight: FontWeight.normal,
      ),
      controller: controller,
      validator: (String? value) {
        if (value == null) return null;
        return value.isEmpty ? validationMsg : null;
      },
      maxLength: maxLength,
      obscureText: isPassword ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: textInputAction,
      decoration: isSimpleField == true
          // For Under border input field
          ? InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.borderColor),
              ),
              hintStyle: TextStyle(
                fontSize: 17,
                color: AppColors.lightGrey,
                fontWeight: FontWeight.normal,
              ),
              labelStyle: TextStyle(
                fontSize: 17,
                color: AppColors.lightGrey,
                fontWeight: FontWeight.normal,
                height: 0,
              ),
              hintText: hintText,
              helperText: helperText,
              labelText: labelText,
              prefixIcon: prefix,
              suffixIcon: suffix,
              prefixText: prefixText,
              suffixText: suffixText,
              counterText: "",
              prefix: countryCodeEnabled == true
                  ? CountryCodePicker(
                      onChanged: (countryCode) {
                        onChangeCountryCode!(countryCode);
                      },
                      initialSelection: 'IN',
                      showCountryOnly: true,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    )
                  : null,
            )
          // For Outlined border input field
          : InputDecoration(
              fillColor: AppColors.textFieldBackgroundColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5.0),
                borderSide: BorderSide(width: 1, color: AppColors.borderColor),
              ),
              border: OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  width: 1,
                ),
              ),
              hintStyle: TextStyle(
                fontSize: 17,
                color: AppColors.lightGrey,
                fontWeight: FontWeight.normal,
              ),
              labelStyle: TextStyle(
                fontSize: 17,
                color: AppColors.lightGrey,
                fontWeight: FontWeight.normal,
              ),
              hintText: hintText,
              helperText: helperText,
              labelText: labelText,
              prefixIcon: prefix,
              suffixIcon: suffix,
              prefixText: prefixText,
              suffixText: suffixText,
              counterText: "",
              prefix: countryCodeEnabled == true
                  ? CountryCodePicker(
                      onChanged: (countryCode) {
                        onChangeCountryCode!(countryCode);
                      },
                      initialSelection: 'IN',
                      showCountryOnly: true,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    )
                  : null,
            ),
    );
  }
}
