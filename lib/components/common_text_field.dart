import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';
import 'package:kovaii_fine_coat/utils/sizes.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final int? maxLine;
  final double? fieldWidth;
  final RegExp? regExp;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fieldColor;
  final String? icon;
  final VoidCallback? onSuffixTap; // ✅ Separate suffix tap handler
  final bool isObscure;
  final bool readOnly;

  final String? Function(String?)? validator;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.labelText,
    required this.controller,
    this.maxLine,
    this.fieldWidth,
    this.regExp,
    this.inputFormatters,
    this.fieldColor,
    this.icon,
    this.onSuffixTap, 
    this.isObscure = false,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final clrTheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Column(
            children: [
              Text(
                labelText!,
                style:  TextStyle(color: Palettes.textColor, fontSize: 14),
              ),
              gap8,
            ],
          ),
        TextFormField(
          readOnly: readOnly, // ❌ don’t force readOnly, user can type
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide:  BorderSide(color: Palettes.borderColor),
            ),
            fillColor: Palettes.whiteColor,
            filled: true,
            hintText: hintText,
            hintStyle:  TextStyle(
              color: Palettes.greyTextColor,
              fontSize: 14,
            ),
            constraints: BoxConstraints(
              minHeight: 50,
              maxWidth: fieldWidth ?? double.maxFinite,
            ),
            suffixIcon: icon != null
                ? GestureDetector(
                    onTap: onSuffixTap, // ✅ only triggers when icon tapped
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        icon!,
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          clrTheme.primaryFixed,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          obscureText: isObscure,
          maxLines: maxLine ?? 1,
          controller: controller,
          inputFormatters: inputFormatters,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter required $labelText";
                } else if (regExp != null && !regExp!.hasMatch(value)) {
                  return "Please enter a valid $labelText";
                }
                return null;
              },
        ),
      ],
    );
  }
}
