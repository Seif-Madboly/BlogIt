// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController? controller;
//   final TextInputType? type;
//   final String? labelText;
//   final String? initialValue;
//   final String? hintText;
//   final bool obscureText;
//   final FormFieldValidator<String>? validator;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldSetter<String>? onChanged;
//   final FormFieldSetter<String>? onSubmitted;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final TextInputAction? textInputAction;
//   final FontWeight? fontWeight;
//   final int? maxline;
//   final TextStyle? textStyle;
//   final EdgeInsetsGeometry? contentPadding; // Add this parameter for custom padding

//   const CustomTextField(
//       {super.key,
//       this.prefixIcon,
//       required this.controller,
//       this.labelText,
//       this.hintText,
//       this.obscureText = false,
//       required this.validator,
//       this.onSaved,
//       this.suffixIcon,
//       this.type,
//       this.textInputAction,
//       this.fontWeight,
//       this.maxline,
//       this.textStyle,
//       this.onSubmitted,
//       this.onChanged,
//           this.contentPadding, // Initialize the content padding

//       this.initialValue});

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final double baseFontSize = screenSize.width * 0.05;
//     return TextFormField(
//       initialValue: initialValue,
//       onChanged: onChanged,
//       maxLines: maxline,
//       controller: controller,
//       textInputAction: textInputAction?? TextInputAction.done,

//       decoration: InputDecoration(
//           enabledBorder:   OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           borderRadius: const BorderRadius.all(Radius.circular(15.0))
//           ),
//           focusedBorder:OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           borderRadius: const BorderRadius.all(Radius.circular(15.0))
//           ),
//           fillColor: Colors.deepPurple.shade100,
//           filled: true,
//           contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Set custom padding
//           labelText: labelText,
//           labelStyle: TextStyle(
//               fontSize: baseFontSize * 0.7,
//               fontWeight: fontWeight,
//               color:  Colors.black87),
//           hintText: hintText,
//           hintStyle: textStyle ??
//               TextStyle(
//                   fontSize: baseFontSize * 0.8,
//                   fontWeight: FontWeight.normal,
//                   color: Colors.black87),
//           suffixIcon: suffixIcon),
//       obscureText: obscureText,
//       validator: validator,
//       onFieldSubmitted: onSubmitted,
//       onSaved: onSaved,
//       style: TextStyle(fontSize: baseFontSize, color: Colors.black),
//       keyboardType: type,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String? initialValue;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputAction? textInputAction;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final Brightness? keyboardAppearance;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsets? scrollPadding;
  final TextAlignVertical? textAlignVertical;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final Color fillColor;
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    required this.validator,
    this.onSaved,
    this.type,
    required this.textInputAction,
    this.fontWeight,
    this.initialValue,
    this.contentPadding,
    this.keyboardAppearance,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.scrollPhysics,
    this.scrollPadding,
    this.textAlignVertical,
    this.onTap,
    this.onEditingComplete,
    this.inputFormatters, required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseFontSize = screenSize.width * 0.05;
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12.0),
        ),
        fillColor: fillColor,
        filled: true,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: baseFontSize * 0.8,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode
          .onUserInteraction, // Validate only when the user interacts

      onSaved: onSaved,
      style: TextStyle(fontSize: baseFontSize, color: Colors.black),
      keyboardType: type,
      keyboardAppearance: keyboardAppearance,
      focusNode: focusNode,
      enableInteractiveSelection: enableInteractiveSelection,
      scrollPhysics: scrollPhysics,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      textAlignVertical: textAlignVertical,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
    );
  }
}
