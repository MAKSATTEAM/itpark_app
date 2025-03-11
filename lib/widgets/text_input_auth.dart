import 'package:flutter/material.dart';

class TextInputAuth extends StatefulWidget {
  String text;
  TextEditingController textFieldControler;
  bool multline = false;
  bool enabled = false;
  Widget? icon;
  Widget? icon2;

  TextInputAuth(
      {super.key, required this.text,
      required this.textFieldControler,
      this.multline = false,
      this.enabled = false,
      this.icon,
      this.icon2});

  @override
  State<TextInputAuth> createState() => _TextInputAuthState();
}

class _TextInputAuthState extends State<TextInputAuth> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: Colors.white,
        //  enabled: widget.enabled ? false : true,
        expands: widget.multline ? true : false,
        maxLines: widget.multline ? null : 1,
        onChanged: (newValue) {
          setState(() {});
        },
        textAlignVertical: TextAlignVertical.top,
        controller: widget.textFieldControler,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: widget.icon == "" ? null : widget.icon,
            suffixIcon: widget.icon2 == "" ? null : widget.icon2,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            labelText: widget.text,
            fillColor: Color(0xff005AA0),
            labelStyle: TextStyle(
                color: widget.textFieldControler.text != ""
                    ? Colors.white
                    : Color(0xFFBDBDBD)),
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2.0,
                    color: widget.textFieldControler.text != ""
                        ? Colors.white
                        : Color(0xFFBDBDBD)),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(8)))));
  }
}
