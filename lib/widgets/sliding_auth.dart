import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/auth/login_cubit.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/auth/login_state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/flushbar_notif.dart';
import 'package:eventssytem/widgets/text_input_auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

final PanelController panelController2 = PanelController();
final PageController pageController = PageController();

class SlidingAuth extends StatefulWidget {
  const SlidingAuth({super.key});

  @override
  State<SlidingAuth> createState() => _SlidingAuthState();
}

class _SlidingAuthState extends State<SlidingAuth> {
  final logincont = TextEditingController();
  final passcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      color: Color(0xff005AA0),
      maxHeight: MediaQuery.of(context).size.height * 0.5,
      minHeight: MediaQuery.of(context).size.height * 0.5,
      controller: panelController2,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      panelSnapping: false,
      panel: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              // Страница авторизации
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${AppLocalizations.of(context)?.login2}",
                            style: kTextStyleWhiteZ)
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          children: [
                            TextInputAuth(
                                text: "${AppLocalizations.of(context)?.username}",
                                textFieldControler: logincont),
                            const SizedBox(height: 16),
                            TextInputAuth(
                                text: "${AppLocalizations.of(context)?.password}",
                                textFieldControler: passcont),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (logincont.text.isEmpty) {
                                      FlusBatNotif().show(
                                          "${AppLocalizations.of(context)?.loginisrequired}",
                                          context);
                                    } else if (passcont.text.isEmpty) {
                                      FlusBatNotif().show(
                                          "${AppLocalizations.of(context)?.passisrequired}",
                                          context);
                                    } else {
                                      context.read<AuthCubit>().signIn(
                                          logincont.text, passcont.text);

                                      context
                                          .read<AuthCubit>()
                                          .stream
                                          .listen((state2) {
                                        if (state2 is LoginedUPDState) {
                                          context
                                              .read<ProfilePageCubit>()
                                              .fetchProfilePage();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        }
                                        if (state2 is LoginedState) {
                                          panelController2.close();
                                        }

                                        if (state2 is ErrorState) {
                                          FlusBatNotif()
                                              .show(state2.message, context);
                                        }
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Text(
                                      "${AppLocalizations.of(context)?.login2}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 254, 255, 255)),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.bounceInOut);
                          },
                          child: Text(
                              "${AppLocalizations.of(context)?.forgotpassword}",
                              style: kTextStyleWhiteZ.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Страница восстановления пароля
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${AppLocalizations.of(context)?.resetpassword}",
                            style: kTextStyleWhiteZ)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      children: [
                        Text(
                          "${AppLocalizations.of(context)?.contact_support}",
                          style: kTextStyleWhiteZ.copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.bounceInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  "${AppLocalizations.of(context)?.back}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 254, 255, 255)),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
