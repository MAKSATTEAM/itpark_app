import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:file_picker/file_picker.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with SingleTickerProviderStateMixin {
  final temaTextFieldControler = TextEditingController();
  final textTextFieldControler = TextEditingController();

  PlatformFile? file;

  Future getFile() async {
    FilePickerResult? filel = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'gif'],
    );

    if (filel != null) {
      setState(() {
        file = filel.files.first;
        print(file!.name);
      });
    }
  }

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
          title: Text("${AppLocalizations.of(context)?.feedback}",
              style: kAppBarTextStyle),
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
                    TextFormField(
                        onChanged: (newValue) {
                          setState(() {});
                        },
                        //  readOnly: true,
                        controller: temaTextFieldControler,
                        decoration: kinputDecorationDesign.copyWith(
                            labelText:
                                "${AppLocalizations.of(context)?.subject}",
                            fillColor: temaTextFieldControler.text != ""
                                ? Colors.white
                                : Color(0xFFF6F6F6),
                            labelStyle: TextStyle(
                                color: temaTextFieldControler.text != ""
                                    ? Color(0xFF008870)
                                    : Color(0xFFBDBDBD)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: temaTextFieldControler.text != ""
                                        ? Color(0xFF008870)
                                        : Color(0xFFBDBDBD))))),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width < 500
                          ? MediaQuery.of(context).size.height / 1.7
                          : 300,
                      child: TextFormField(
                          expands: true,
                          maxLines: null,
                          onChanged: (newValue) {
                            setState(() {});
                          },
                          textAlignVertical: TextAlignVertical.top,
                          controller: textTextFieldControler,
                          decoration: kinputDecorationDesign.copyWith(
                              alignLabelWithHint: true,
                              labelText:
                                  "${AppLocalizations.of(context)?.yourcomment}",
                              fillColor: textTextFieldControler.text != ""
                                  ? Colors.white
                                  : Color(0xFFF6F6F6),
                              labelStyle: TextStyle(
                                color: textTextFieldControler.text != ""
                                    ? Color(0xFF008870)
                                    : Color(0xFFBDBDBD),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: textTextFieldControler.text != ""
                                          ? Color(0xFF008870)
                                          : Color(0xFFBDBDBD))))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          getFile();
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Image.asset(
                                      'assets/images/image_mess.png')),
                            ),
                            file == null
                                ? Text(
                                    "${AppLocalizations.of(context)?.fileaddd}",
                                    style: kFidback,
                                  )
                                : Text(
                                    file!.name,
                                    style: kFidbackgreen,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: textTextFieldControler.text != "" &&
                                    temaTextFieldControler.text != "" &&
                                    file != null
                                ? Color(0xFF3B8992)
                                : Color(0xFFBDBDBD),
                          ),
                          onPressed: () {
                            if (textTextFieldControler.text != "" &&
                                temaTextFieldControler.text != "" &&
                                file != null) {
                              context.read<FeedbackCubit>().send(
                                  temaTextFieldControler.text,
                                  textTextFieldControler.text,
                                  file);

                              context
                                  .read<FeedbackCubit>()
                                  .stream
                                  .listen((state) {
                                if (state is FeedbackSendState) {
                                  tabController.animateTo(1);
                                  temaTextFieldControler.clear();
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
                        Text("${AppLocalizations.of(context)?.thanks}",
                            style: kContentTextStyle.copyWith(
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 32, right: 32),
                          child: Text(
                            "${AppLocalizations.of(context)?.thanksforthefeedback}",
                            style: kContentTextStyle.copyWith(
                                color: Color(0xFF828282)),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/main', (Route<dynamic> route) => false);
                        },
                        child: Text(
                            "${AppLocalizations.of(context)?.gobacktomain}",
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
      ),
    );
  }
}
