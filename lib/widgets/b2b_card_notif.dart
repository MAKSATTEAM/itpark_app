import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';

class B2bCard extends StatelessWidget {
  const B2bCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 5),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          border: Border.all(color: kPrimaryColor),
          boxShadow: [
            BoxShadow(
              color: kShadowColor.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10, // changes position of shadow
            ),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Выберите делегата для отправки ему \nсообщения",
              style: kFilterTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset('assets/images/send.png'),
          )
        ]),
      ),
    );
  }
}
