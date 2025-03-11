import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/sliding_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Background().background),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/authinfopage');
                    },
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          "assets/icons/mapwhat.svg",
                          color: kPrimaryColor,
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: SvgPicture.asset(
                      "assets/images/logoen.svg",
                    ),
                  ),
                ],
              ),
              SlidingAuth()
            ],
          ),
        ),
      ),
    );
  }
}
