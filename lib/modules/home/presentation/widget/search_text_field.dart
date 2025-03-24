import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final Brightness? keyboardAppearance;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final ScrollPhysics? scrollPhysics;
  final TextAlignVertical? textAlignVertical;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final Color? hintColor;
  final Color? iconColor;
  final Color? textColor;
  const SearchTextField({
    super.key,
    required this.controller,
    this.onSaved,
    this.fontWeight,
    this.initialValue,
    this.contentPadding,
    this.keyboardAppearance,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.scrollPhysics,
    this.textAlignVertical,
    this.onTap,
    this.onEditingComplete,
    this.inputFormatters,
    this.fillColor,
    this.hintColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    const double baseFontSize = 16;

    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      textInputAction: TextInputAction.go,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(22.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(22.0),
        ),

        fillColor: fillColor ??
            Colors.deepPurple.shade100,
        filled: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        hintText: "Search",
        hintStyle:const TextStyle(
          fontSize: baseFontSize * 0.8,
          fontWeight: FontWeight.normal,
          color:Colors.grey
        ),
        prefixIcon: Icon(
          Icons.search,
          color: iconColor ?? Colors.grey, 
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: onSaved,
      style:   TextStyle(
        fontSize: baseFontSize,
        color: textColor,
      ),
      keyboardType: TextInputType.text,
      keyboardAppearance: keyboardAppearance,
      focusNode: focusNode,
      enableInteractiveSelection: enableInteractiveSelection,
      scrollPhysics: scrollPhysics,
      textAlignVertical: textAlignVertical,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
    );
  }
}
