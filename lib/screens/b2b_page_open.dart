import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/text_input.dart';


final textTextFieldControler = TextEditingController();

class B2bPageOpen extends StatefulWidget {
  String? photo;
  String? id;
  String? name;

  B2bPageOpen({super.key, required this.photo, required this.id, required this.name});

  @override
  State<B2bPageOpen> createState() => _B2bPageOpenState();
}

class _B2bPageOpenState extends State<B2bPageOpen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBacColor,
        iconTheme: IconThemeData(color: kIconColor),
        elevation: 0,
        centerTitle: true,
        title: Text("B2B", style: kAppBarTextStyle),
        actions: [NotificationIcon()],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  child: Column(
                children: [
                  SizedBox(height: 2),
                  CircularProfileAvatar(
                    '',
                    backgroundColor: Colors.transparent,
                    radius: 32,
                    child: widget.photo == null
                        ? SvgPicture.asset(
                            "assets/icons/noimg.svg",
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            color: kPrimaryColor,
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            imageUrl: "${ConstantsClass.url}${widget.photo}",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                SvgPicture.asset(
                              "assets/icons/noimg.svg",
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              color: kPrimaryColor,
                            ),
                          ),
                  ),
                  SizedBox(height: 7),
                  Text("${widget.name}", style: kContentTextStyle),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.9,
                    child: TextInput(
                        text: "${AppLocalizations.of(context)?.yourmessage}",
                        textFieldControler: textTextFieldControler,
                        multline: true),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textTextFieldControler.text != ""
                              ? Color(0xFF3B8992)
                              : Color(0xFFBDBDBD),
                        ),
                        onPressed: () {
                          if (textTextFieldControler.text != "") {
                            context.read<B2bsendCubit>().send(
                                  id: widget.id!,
                                  message: textTextFieldControler.text,
                                );

                            context.read<B2bsendCubit>().stream.listen((state) {
                              if (state is B2bsendSendState) {
                                tabController.animateTo(1);
                                textTextFieldControler.clear();
                              }
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "${AppLocalizations.of(context)?.send}",
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                  )
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/chat.svg"),
                      SizedBox(height: 16),
                      Text(
                          "${AppLocalizations.of(context)?.messagehasbeensent}",
                          style: kContentTextStyle.copyWith(
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                          "${AppLocalizations.of(context)?.gobackto} B2B",
                          style: kContentTextStyle.copyWith(
                              color: Color(0xFF005AA0))),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
