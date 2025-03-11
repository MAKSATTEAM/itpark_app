import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/utils/constants.dart';

class MainEventCategoryWidget extends StatelessWidget {
  int idgo;
  Widget icon;
  String text;
  MainEventCategoryWidget(
      {super.key, required this.idgo, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        context.read<BottomNavigationControllerSelect>().select(1);
        context.read<TabShVerhController>().select2(idgo);
      }),
      child: Container(
          decoration: kDecorationBox,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 11, bottom: 5, left: 25, right: 25),
            child: Column(
              children: [
                icon,
                SizedBox(height: 4),
                Text(text,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14))
              ],
            ),
          )),
    );
  }
}
