import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/flushbar_notif.dart';
import 'package:eventssytem/widgets/notification_icon.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  int click = -1;
  @override
  Widget build(BuildContext context) {
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
            title: Text("${AppLocalizations.of(context)?.voting}",
                style: kAppBarTextStyle),
            actions: [NotificationIcon()],
          ),
          body:
              BlocBuilder<VotingCubit, VotingState>(builder: (context, state) {
            print(state);
            if (state is VotingLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is VotingEmptyState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/goodvoting.svg"),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Text(
                          "${AppLocalizations.of(context)?.thanksfortheanswersa}",
                          style: kVoitingGlavStyleblack),
                      Text(
                          "${AppLocalizations.of(context)?.thanksfortheanswersb}",
                          style: kVoitingGlavStyleblack),
                    ],
                  ),
                ],
              ));
            }
            if (state is VotingLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(state.title, style: kVoitingGlavStyleblack),
                    SizedBox(height: 2),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Column(children: [
                        SizedBox(height: 5),
                        Text(
                          state.number,
                          style: kVoitingOstStylegreenniz,
                        )
                      ]),
                      Column(children: [
                        Text(
                          "/${state.count}",
                          style: kVoitingOstStylegreenverh.copyWith(
                              color: Color(0xFF3B8992).withOpacity(0.5)),
                        ),
                        SizedBox(height: 5)
                      ]),
                    ]),
                    SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.answer.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      click = index;
                                    });
                                  },
                                  child: cartochka(
                                      state.answer[index], click != index));
                            }),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: click != -1
                                ? Color(0xFF3B8992)
                                : Color(0xFFBDBDBD),
                          ),
                          onPressed: () {
                            if (click != -1) {
                              context.read<VotingCubit>().setVoting(
                                  state.voteId, state.answerid[click]);

                              context
                                  .read<VotingCubit>()
                                  .stream
                                  .listen((state2) {
                                if (state2 is VotingMessageState) {
                                  FlusBatNotif().show(
                                      "${AppLocalizations.of(context)?.voteaccept}",
                                      context);
                                }
                              });

                              setState(() {
                                click = -1;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "${AppLocalizations.of(context)?.next}",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              );
            }

            return Center(
                child: Text("${AppLocalizations.of(context)?.error}"));
          })),
    );
  }

  Widget cartochka(String text, bool notActive) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        margin: EdgeInsets.only(top: 4, bottom: 4),
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: notActive ? Colors.white : Color(0xFF3B8992),
          borderRadius: const BorderRadius.all(Radius.circular(9)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5.7),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: notActive ? Color(0xFF828282) : Colors.white,
                      width: 1),
                  borderRadius: BorderRadius.circular(1000)),
              child: Container(
                height: 8.3,
                width: 8.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000)),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(text,
                  style: kVoitingOstStyleblack.copyWith(
                      color: notActive ? Color(0xFF000000) : Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
