import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/other/new_drops.dart';
import 'package:eventssytem/other/other.dart';

class DropdownInputInput extends StatefulWidget {
  String text;
  List<dynamic> list;
  String selectedId;
  String privatekey;
  bool enabled = false;

  DropdownInputInput(
      {super.key, required this.text,
      required this.list,
      required this.privatekey,
      required this.selectedId,
      this.enabled = false});

  @override
  _DropdownInputInputState createState() => _DropdownInputInputState();
}

class _DropdownInputInputState extends State<DropdownInputInput> {
  @override
  Widget build(BuildContext context) {
    UniversalModel? selectedvalue;
    for (var item in widget.list) {
      if (item.id.toString() == widget.selectedId) {
        selectedvalue = item;
        break;
      }
    }

    return DropdownButtonFormField<UniversalModel>(
      iconEnabledColor: widget.enabled ? Color(0xFFBDBDBD) : Colors.black,
      decoration: InputDecoration(
        iconColor: widget.enabled ? Color(0xFFBDBDBD) : Colors.black,
        labelText: widget.text,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: selectedvalue != null ? Colors.white : Color(0xFFF6F6F6),
        labelStyle: TextStyle(
            color: selectedvalue != null
                ? widget.enabled
                    ? Color(0xFFBDBDBD)
                    : Color(0xFF008870)
                : Color(0xFFBDBDBD)),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1.0,
                color: selectedvalue != null
                    ? widget.enabled
                        ? Color(0xFFBDBDBD)
                        : Color(0xFF008870)
                    : Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF008870), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      items: widget.list.map((from) {
        return DropdownMenuItem<UniversalModel>(
          value: from,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 32 - 64,
            child: AutoSizeText(
              ConstantsClass.locale == "en" ? from.nameEng! : from.nameRus!,
              style: TextStyle(
                  color: widget.enabled ? Color(0xFFBDBDBD) : Colors.black),
            ),
          ),
        );
      }).toList(),
      onChanged: (data) {
        setState(() {
          selectedvalue = data;
          SelectedItemsEditProfile.strings[widget.privatekey] =
              data!.id.toString();
        });
      },
      value: selectedvalue,
    );
  }
}
