import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/auth/login_cubit.dart';
import 'package:eventssytem/cubit/auth/login_state.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/auth_widget.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool trans = true;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: kIconColor),
          elevation: 0,
          centerTitle: true,
          title: Text("${AppLocalizations.of(context)?.settings}",
              style: kAppBarTextStyle),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)?.pushnotifications}",
                        style: kContentTextStyle,
                      ),
                      Switch(
                          activeColor: kButtonColor,
                          value: trans,
                          onChanged: (bool value) {
                            print("ffff");
                          })
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)?.nllanguage}",
                        style: kContentTextStyle.copyWith(
                            color: Color(0xFF000000)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.read<LangCubit>().setLocale(Locale("ru"));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Русский",
                          style: kContentTextStyle.copyWith(
                              color: AppLocalizations.of(context)?.localeName ==
                                      "ru"
                                  ? Color(0xFF000000)
                                  : Color(0xFF828282)),
                        ),
                        Visibility(
                            visible:
                                AppLocalizations.of(context)?.localeName == "ru"
                                    ? true
                                    : false,
                            child:
                                SvgPicture.asset("assets/icons/langcheck.svg"))
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                  Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      context.read<LangCubit>().setLocale(Locale("en"));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "English",
                          style: kContentTextStyle.copyWith(
                              color: AppLocalizations.of(context)?.localeName ==
                                      "en"
                                  ? Color(0xFF000000)
                                  : Color(0xFF828282)),
                        ),
                        Visibility(
                            visible:
                                AppLocalizations.of(context)?.localeName == "en"
                                    ? true
                                    : false,
                            child:
                                SvgPicture.asset("assets/icons/langcheck.svg"))
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                  Divider(
                    height: 5,
                    color: Colors.black,
                  ),
                  SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      context.read<LangCubit>().setLocale(Locale("zh"));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "中文",
                          style: kContentTextStyle.copyWith(
                              color: AppLocalizations.of(context)?.localeName ==
                                      "zh"
                                  ? Color(0xFF000000)
                                  : Color(0xFF828282)),
                        ),
                        Visibility(
                            visible:
                                AppLocalizations.of(context)?.localeName == "zh"
                                    ? true
                                    : false,
                            child:
                                SvgPicture.asset("assets/icons/langcheck.svg"))
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () => _launchUrl("https://sprouts.maksat.pro/manual_rus.pdf"),
                          child: Text(
                            "Инструкция на русском",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchUrl("https://sprouts.maksat.pro/manual_eng.pdf"),
                          child: Text(
                            "Instruction in English",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchUrl("https://sprouts.maksat.pro/manual_chi.pdf"),
                          child: Text(
                            "中文说明",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                    if (state is LoginedState) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color(0xFFB03A35),
                            ),
                            onPressed: () {
                              context.read<AuthCubit>().logOut();
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                "${AppLocalizations.of(context)?.logout}",
                                style: TextStyle(fontSize: 16),
                              ),
                            )),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthWidget(),
                        ],
                      );
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
