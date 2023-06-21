import 'package:flutter/material.dart';
import 'package:cusipco/themedata.dart';

class TextAreaBox extends StatefulWidget {
  const TextAreaBox(
      {Key? key,
        required this.hinttext,
        required this.controllers,
        this.validator,
        this.radius = 30,
        this.minLine = 1,
        this.ontap,
        this.isReadOnly = false,
        this.isCenter = false,
        this.isNumber = false})
      : super(key: key);
  final String hinttext;

  final TextEditingController controllers;
  final String? Function(String?)? validator;

  final bool isReadOnly;
  final bool isCenter;
  final bool isNumber;
  final double radius;
  final int minLine;
  final Function? ontap;

  @override
  State<TextAreaBox> createState() => _TextAreaBoxState();
}

class _TextAreaBoxState extends State<TextAreaBox> {
  double padding = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isReadOnly
            ? ThemeClass.greyDarkColor.withOpacity(0.1)
            : ThemeClass.whiteDarkColor,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: TextFormField(
          minLines: widget.minLine,
          onTap: () {
            if (widget.ontap != null) {
              widget.ontap!();
            }
          }, keyboardType: TextInputType.multiline,
          maxLines: 10,
          readOnly: widget.isReadOnly,
          controller: widget.controllers,
          autovalidateMode: AutovalidateMode.disabled,
          validator: (value) {
            if (widget.validator!(value) != null) {
              setState(() {
                padding = 10;
              });
            } else {
              setState(() {
                padding = 0;
              });
            }
            return widget.validator!(value);
          },
          textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: ThemeClass.greyDarkColor,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.3,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),

            hintText: widget.hinttext,
            hintStyle: TextStyle(
              color: ThemeClass.greyDarkColor,
              fontSize: 14,
            ),

            // errorStyle: TextStyle(fontSize: 9, height: 0.3),
            prefixStyle: TextStyle(color: ThemeClass.greyDarkColor),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: widget.isReadOnly
                    ? Colors.transparent
                    : ThemeClass.greyDarkColor,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
