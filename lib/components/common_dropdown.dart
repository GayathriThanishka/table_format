import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kovaii_fine_coat/theme/palettes.dart';
import 'package:kovaii_fine_coat/utils/sizes.dart';



class CommonDropdown extends StatelessWidget {
  final dynamic selectedValue;
  final List<String> items;
  final Function(dynamic)? handleOnChange;
  final String? hint;
  final String? labelText;
  final double? fieldWidth;
  final Color? fieldColor;

  const CommonDropdown({
    super.key,
    this.labelText,
    this.selectedValue,
    required this.items,
    required this.handleOnChange,
    this.hint,
    this.fieldWidth,
    this.fieldColor,
  });

  @override
  Widget build(BuildContext context) {
    final clrTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Column(
            children: [Text(labelText!, style: textTheme.bodyLarge), gap8],
          ),
        DropdownSearch<String>(
          selectedItem: selectedValue,
          items: (filter, loadProps) => items,
          onChanged: handleOnChange,
          validator: (value) {
            if (value == null) {
              return "Please select a $hint";
            }
            return null;
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              suffixIconColor: clrTheme.primaryFixed,border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)),borderSide: BorderSide(color: Palettes.borderColor)),
              fillColor: Palettes.whiteColor,
              filled: true,
              constraints: BoxConstraints(
                minHeight: 50,
                maxWidth: fieldWidth ?? double.maxFinite,
              ),
              hintText: hint,
                    hintStyle: TextStyle(
      color: Palettes.greyTextColor, 
      fontSize: 14, 
    ),

              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: false,
            fit: FlexFit.loose,

            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: "Search",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: clrTheme.tertiaryContainer,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
