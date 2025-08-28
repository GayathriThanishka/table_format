import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';

class CommonFilledButton extends StatelessWidget {
  final String buttonText;
  final Color? textColor;
  final Color? backgroundColor;
  final String? icon;
  final VoidCallback handleOnTap;
  final double? buttonWidth;

  const CommonFilledButton({
    super.key,
    required this.buttonText,
    this.textColor,
    this.backgroundColor,
    this.icon,
    required this.handleOnTap,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    final clrTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: handleOnTap,
      style: ElevatedButton.styleFrom(
        overlayColor: clrTheme.secondaryContainer,
        elevation: 0,
        shadowColor: Palettes.transparentColor,
        backgroundColor: backgroundColor ?? clrTheme.primary,
        fixedSize: Size(buttonWidth ?? double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Expanded(
      child: Center(
        child: Text(
          buttonText,
          style: textTheme.bodyLarge?.copyWith(
            color: textColor ?? clrTheme.secondaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    if (icon != null) ...[
      SvgPicture.asset(
        icon!,
        height: 20,
        width: 20,
        colorFilter: ColorFilter.mode(
          textColor ?? clrTheme.secondaryContainer,
          BlendMode.srcIn,
        ),
      ),
    ],
  ],
),

    );
  }
}
