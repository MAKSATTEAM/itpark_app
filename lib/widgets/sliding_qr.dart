import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/auth/login_auth.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final PanelController panelController = PanelController();
final PageController pageController = PageController();

class SlidingQr extends StatefulWidget {
  const SlidingQr({super.key});

  @override
  State<SlidingQr> createState() => _SlidingQrState();
}

class _SlidingQrState extends State<SlidingQr> {
  String? name;
  String? opisanie;
  String? adress;
  String? site;
  String? tel;
  Color? color;

  @override
  Widget build(BuildContext context) {
    context.read<SlidingQrCubit>().stream.listen((state) {
      if (state is SlidingQrOpenState) {
        panelController.open();
        context.read<QrCubit>().feth();
      } else if (state is SlidingQrClosedState) {
        panelController.close();
      }
    });

    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      minHeight: 0,
      controller: panelController,
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      panel: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        context.read<SlidingQrCubit>().hide();
                      },
                      icon: SvgPicture.asset("assets/icons/X.svg",
                          color: Color(0xFF828282))),
                ],
              ),
              SizedBox(height: 1),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: BlocBuilder<QrCubit, QrState>(
                        builder: (context, state) {
                      print(state);
                      if (state is QrLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is QrErrorState) {
                        return Center(
                            child:
                                Text("${AppLocalizations.of(context)?.error}"));
                      }
                      if (state is QrLoadedState) {
                        if (state.loadedv != "") {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.bounceInOut);
                          });
                        }

                        return PageView(
                          controller: pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          32,
                                      child: Text(
                                        "${AppLocalizations.of(context)?.yourpersonalqrcode}",
                                        textAlign: TextAlign.center,
                                        style: kSlidingQv1,
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(40),
                                    // child: QrImage(
                                    //   data: state.loadedp ?? "пусто",
                                    //   version: QrVersions.auto,
                                    //   size: 260.0,
                                    // ),
                                  )),
                                  Divider(
                                    height: 2,
                                    color: Color(0xFFBDBDBD),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)?.needhelp}",
                                          style: kSlidingQRg,
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/feedbackpage');
                                          },
                                          child: Text(
                                            "${AppLocalizations.of(context)?.contactus}",
                                            style: kSlidingQRgr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          32,
                                      child: Text(
                                        "${AppLocalizations.of(context)?.yourpersonalbadgeforadmissiontotheevent}",
                                        textAlign: TextAlign.center,
                                        style: kSlidingQRg,
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 30),
                                      BlocBuilder<ProfilePageCubit,
                                              ProfilePageState>(
                                          builder: (context, state) {
                                        if (state is ProfilePageLoadedState) {
                                          return Column(
                                            children: [
                                              Text(
                                                "${state.loadedProfilePage.lastNameEng} ${state.loadedProfilePage.firstNameEng}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Color(0xFF3B8992),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 24),
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                "${state.loadedProfilePage.company.nameEng}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          );
                                        }
                                        return Center(
                                            child: Text(
                                                "${AppLocalizations.of(context)?.error}"));
                                      }),
                                      SizedBox(height: 16),
                                      Text(
                                        "ID: ${AppAuth.participantId}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        // child: QrImage(
                                        //   data: state.loadedv ?? "пусто",
                                        //   version: QrVersions.auto,
                                        //   size: 200.0,
                                        // ),
                                      ),
                                    ],
                                  )),
                                  Divider(
                                    height: 2,
                                    color: Color(0xFFBDBDBD),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)?.lostyourbadge}",
                                          style: kSlidingQRg,
                                        ),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            pageController.animateToPage(0,
                                                duration:
                                                    Duration(milliseconds: 250),
                                                curve: Curves.bounceInOut);
                                          },
                                          child: Text(
                                            "${AppLocalizations.of(context)?.printanewone}",
                                            style: kSlidingQRgr,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                          child:
                              Text("${AppLocalizations.of(context)?.error}"));
                    }))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
