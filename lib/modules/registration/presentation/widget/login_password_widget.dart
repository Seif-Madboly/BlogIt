import 'dart:developer';

import 'package:flutter/material.dart';

class LoginPasswordWidget extends StatefulWidget {
  const LoginPasswordWidget(
      {super.key,
      required this.controller,
      this.validator,
      this.fontWeight,
      this.textStyle,
      this.textInputAction,
      this.onSaved,
      this.contentPadding,
      this.focusNode,
      this.scrollPhysics,
      this.scrollPadding,
      required this.fillColor});
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final Color fillColor;
  final FormFieldValidator<String>? validator;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsets? scrollPadding;

  @override
  State<LoginPasswordWidget> createState() => _LoginPasswordWidgetState();
}

class _LoginPasswordWidgetState extends State<LoginPasswordWidget> {
  bool isPasswordHidden = true;

  void _changePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseFontSize = screenSize.width * 0.05;
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isPasswordHidden,
      onFieldSubmitted: (value) {
        log(value);
      },
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
        fillColor: widget.fillColor,
        filled: true,
        suffixIcon: IconButton(
          onPressed: _changePasswordVisibility,
          icon: Icon(
            isPasswordHidden
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
        ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        hintText: "Password",
        hintStyle: TextStyle(
          fontSize: baseFontSize * 0.8,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
      ),
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
      style: TextStyle(fontSize: baseFontSize, color: Colors.black),
    );
  }
}
