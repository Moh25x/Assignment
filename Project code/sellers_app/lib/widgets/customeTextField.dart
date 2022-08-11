import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsece=true;
  bool? enabled=true;

  CustomTextFiled({
    this.controller,
    this.data,
    this.hintText,
    this.isObsece,
    this.enabled,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        textAlign: TextAlign.end,
        enabled: enabled,
        controller: controller,
        obscureText: isObsece!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: Icon(data,
          color: Colors.green,
          ),
          focusColor:Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
