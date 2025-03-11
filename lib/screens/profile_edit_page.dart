import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/new_drops.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/dropdown_input_edit.dart';
import 'package:eventssytem/widgets/flushbar_notif.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/text_input.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  bool? visa;
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    context.read<ClaimUpdateCubit>().stream.listen((state) {
      if (state is ClaimUpdateClaimState) {
        context.read<ProfilePageCubit>().fetchProfilePage();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);

        //  Navigator.pushNamed(context, '/main');
        // Navigator.popAndPushNamed(context, '/main');

        FlusBatNotif().show("${AppLocalizations.of(context)?.saved}", context);
      }
      if (state is ClaimNoEditState) {
        setState(() {
          enabled = state.edited;
        });
      }
    });

    // TextEditingController textEditingControllernameenabledr =
    //     TextEditingController();
    // TextEditingController textEditingControllernameenablede =
    //     TextEditingController();
    // TextEditingController textEditingControllerbenabled =
    //     TextEditingController();
    // TextEditingController textEditingControllerpassportenabled =
    //     TextEditingController();

    TextEditingController firstNameRus = TextEditingController();
    TextEditingController lastNameRus = TextEditingController();
    TextEditingController patronymic = TextEditingController();
    TextEditingController firstNameEng = TextEditingController();
    TextEditingController lastNameEng = TextEditingController();
    TextEditingController comment = TextEditingController();
    TextEditingController birthday =
        MaskedTextController(mask: '0000-00-00 00:00');
    TextEditingController passportNumber = TextEditingController();

    TextEditingController issuedBy = TextEditingController();
    TextEditingController issuedDate =
        MaskedTextController(mask: '0000-00-00 00:00');
    TextEditingController validUntilDate =
        MaskedTextController(mask: '0000-00-00 00:00');
    TextEditingController birthPlace = TextEditingController();

    TextEditingController companynameRus = TextEditingController();
    TextEditingController companynameEng = TextEditingController();
    TextEditingController companypositionRus = TextEditingController();
    TextEditingController companypositionEng = TextEditingController();
    TextEditingController postAddress = TextEditingController();

    TextEditingController phoneNumber = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController webSite = TextEditingController();

    TextEditingController arrivalStation = TextEditingController();
    TextEditingController arrivalFlightInfo = TextEditingController();
    TextEditingController arrivalDateTime =
        MaskedTextController(mask: '0000-00-00 00:00');

    TextEditingController departureStation = TextEditingController();
    TextEditingController departureFlightInfo = TextEditingController();
    var departureDateTime = MaskedTextController(mask: '0000-00-00 00:00');

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
            title: Text("${AppLocalizations.of(context)?.profile}",
                style: kAppBarTextStyle),
            actions: [NotificationIcon()],
          ),
          body: BlocBuilder<ProfilePageCubit, ProfilePageState>(
              builder: (context, state) {
            print("state= $state");
            if (state is ProfilePageLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfilePageLoadedState) {
              // textEditingControllernameenabledr.text =
              //     "${state.loadedProfilePage.firstNameRus} ${state.loadedProfilePage.lastNameRus}";
              // textEditingControllernameenablede.text =
              //     "${state.loadedProfilePage.firstNameEng} ${state.loadedProfilePage.lastNameEng}";

              // textEditingControllerbenabled.text =
              //     state.loadedProfilePage.birthday.toString();

              firstNameRus.text =
                  state.loadedProfilePage.firstNameRus.toString();
              lastNameRus.text = state.loadedProfilePage.lastNameRus.toString();
              patronymic.text = state.loadedProfilePage.patronymic.toString();
              firstNameEng.text =
                  state.loadedProfilePage.firstNameEng.toString();
              lastNameEng.text = state.loadedProfilePage.lastNameEng.toString();

              comment.text = state.loadedProfilePage.comment.toString();
              birthday.text = state.loadedProfilePage.birthday.toString();
              passportNumber.text =
                  state.loadedProfilePage.passportNumber.toString();

              issuedBy.text = state.loadedProfilePage.issuedBy.toString();
              issuedDate.text =
                  state.loadedProfilePage.issuedDate.toString() == "null"
                      ? ""
                      : state.loadedProfilePage.issuedDate.toString();
              validUntilDate.text =
                  state.loadedProfilePage.validUntilDate.toString() == "null"
                      ? ""
                      : state.loadedProfilePage.validUntilDate.toString();
              birthPlace.text = state.loadedProfilePage.birthPlace.toString();

              companynameRus.text =
                  state.loadedProfilePage.company.nameRus.toString();
              companynameEng.text =
                  state.loadedProfilePage.company.nameEng.toString();
              companypositionRus.text =
                  state.loadedProfilePage.company.positionRus.toString();
              companypositionEng.text =
                  state.loadedProfilePage.company.positionEng.toString();
              postAddress.text =
                  state.loadedProfilePage.company.postAddress.toString();

              phoneNumber.text = state.loadedProfilePage.phoneNumber.toString();
              email.text = state.loadedProfilePage.email;
              webSite.text = state.loadedProfilePage.webSite.toString();

              arrivalStation.text = state
                  .loadedProfilePage.participantArrivalDeparture.arrivalStation
                  .toString();
              arrivalFlightInfo.text = state.loadedProfilePage
                  .participantArrivalDeparture.arrivalFlightInfo
                  .toString();
              arrivalDateTime.text = state.loadedProfilePage
                          .participantArrivalDeparture.arrivalDateTime
                          .toString() ==
                      "null"
                  ? ""
                  : state.loadedProfilePage.participantArrivalDeparture
                      .arrivalDateTime
                      .toString();

              departureStation.text = state.loadedProfilePage
                  .participantArrivalDeparture.departureStation
                  .toString();
              departureFlightInfo.text = state.loadedProfilePage
                  .participantArrivalDeparture.departureFlightInfo
                  .toString();
              departureDateTime.text = state.loadedProfilePage
                          .participantArrivalDeparture.departureDateTime
                          .toString() ==
                      "null"
                  ? ""
                  : state.loadedProfilePage.participantArrivalDeparture
                      .departureDateTime
                      .toString();

              SelectedItemsEditProfile.strings
                  .addAll({"appeal": "${state.loadedProfilePage.titleId}"});
              SelectedItemsEditProfile.strings
                  .addAll({"genderId": "${state.loadedProfilePage.genderId}"});
              SelectedItemsEditProfile.strings.addAll(
                  {"residenceId": "${state.loadedProfilePage.residenceId}"});
              SelectedItemsEditProfile.strings.addAll(
                  {"rusRegionId": "${state.loadedProfilePage.rusRegionId}"});
              SelectedItemsEditProfile.strings.addAll({
                "citizenshipId": "${state.loadedProfilePage.citizenshipId}"
              });
              SelectedItemsEditProfile.strings.addAll({
                "countryCompanyHeadId":
                    "${state.loadedProfilePage.company.countryCompanyHeadId}"
              });
              SelectedItemsEditProfile.strings.addAll(
                  {"sphereId": "${state.loadedProfilePage.company.sphereId}"});

              visa ??= state.loadedProfilePage.visa;

              context
                  .read<ClaimUpdateCubit>()
                  .check(firstNameEng.text, lastNameEng.text);

              return SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 6),
                  const Center(
                    child: Text("Events System",
                        style: TextStyle(
                            color: Color(0xFF3B8992),
                            fontWeight: FontWeight.w700,
                            fontSize: MediumTextSize)),
                  ),
                  const SizedBox(height: 16),

                  enabled == true
                      ? Column(children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 32,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(9)),
                                border: Border.all(
                                  color: Color(0xFF3B8992),
                                  width: 1.5,
                                )),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: AutoSizeText(
                                      "${AppLocalizations.of(context)?.safeedit}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      "assets/icons/locked.svg"),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 16)
                        ])
                      : Container(),

                  razvertka(
                      "${AppLocalizations.of(context)?.personalinformation}",
                      [
                        AbsorbPointer(
                          absorbing: enabled,
                          child: DropdownInputInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.appeal}",
                              list: state.loadedTitles,
                              privatekey: "appeal",
                              selectedId:
                                  state.loadedProfilePage.titleId.toString()),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.nr}",
                              textFieldControler: firstNameRus),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.sr}",
                              textFieldControler: lastNameRus),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.patronymic}",
                              textFieldControler: patronymic),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.ne}",
                              textFieldControler: firstNameEng),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.se}",
                              textFieldControler: lastNameEng),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: DropdownInputInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.pol}",
                              list: [
                                UniversalModel(
                                    id: 1,
                                    nameRus: "Мужской",
                                    nameEng: "Male",
                                    nameAra: ""),
                                UniversalModel(
                                    id: 2,
                                    nameRus: "Женский",
                                    nameEng: "Female",
                                    nameAra: ""),
                              ],
                              privatekey: "genderId",
                              selectedId:
                                  state.loadedProfilePage.genderId.toString()),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: DropdownInputInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.countryofresidence}",
                              list: state.loadedCountry,
                              privatekey: "residenceId",
                              selectedId: state.loadedProfilePage.residenceId
                                  .toString()),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: DropdownInputInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.countryofresidence}",
                              list: state.loadrusRegions,
                              privatekey: "rusRegionId",
                              selectedId: state.loadedProfilePage.rusRegionId
                                  .toString()),
                        ),
                        const SizedBox(height: 20),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: DropdownInputInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.citizenship}",
                              list: state.loadedCountry,
                              privatekey: "citizenshipId",
                              selectedId: state.loadedProfilePage.citizenshipId
                                  .toString()),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              icon2: Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(
                                  "assets/icons/calendar.svg",
                                  color: Colors.black,
                                ),
                              ),
                              text:
                                  "${AppLocalizations.of(context)?.dateofbirth}",
                              textFieldControler: birthday),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.passportnumber}",
                              textFieldControler: passportNumber),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.issuingauthority}",
                              textFieldControler: issuedBy),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.dateofissue}",
                              textFieldControler: issuedDate),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.dateofexpiry}",
                              textFieldControler: validUntilDate),
                        ),
                        const SizedBox(height: 16),
                        AbsorbPointer(
                          absorbing: enabled,
                          child: TextInput(
                              enabled: enabled,
                              text:
                                  "${AppLocalizations.of(context)?.placeofbirth}",
                              textFieldControler: birthPlace),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                                value: visa,
                                onChanged: (val) {
                                  print(val);
                                  visa = val;
                                  setState(() {});
                                }),
                            SizedBox(width: 10),
                            Text(
                                "${AppLocalizations.of(context)?.ineedvisasupport}")
                          ],
                        )
                      ],
                      context),
                  const SizedBox(height: 16),
                  razvertka(
                      "${AppLocalizations.of(context)?.organization}",
                      [
                        const SizedBox(height: 16),
                        TextInput(
                            text:
                                "${AppLocalizations.of(context)?.organization}",
                            textFieldControler: companynameRus),
                        const SizedBox(height: 16),
                        TextInput(
                            text:
                                "${AppLocalizations.of(context)?.organizationeng}",
                            textFieldControler: companynameEng),
                        const SizedBox(height: 16),
                        TextInput(
                            text: "${AppLocalizations.of(context)?.jobtitle}",
                            textFieldControler: companypositionRus),
                        const SizedBox(height: 16),
                        TextInput(
                            text:
                                "${AppLocalizations.of(context)?.jobtitleeng}",
                            textFieldControler: companypositionEng),
                        const SizedBox(height: 16),
                        DropdownInputInput(
                            text: "${AppLocalizations.of(context)?.sphere}",
                            list: state.loadedProfilePage.category.id == 8
                                ? state.loadedmedia
                                : state.loadedProfilePage.category.id == 24
                                    ? state.loadedmedia
                                    : state.loadedSpheres,
                            privatekey: "sphereId",
                            selectedId: state.loadedProfilePage.company.sphereId
                                .toString()),
                        const SizedBox(height: 16),
                        DropdownInputInput(
                            text:
                                "${AppLocalizations.of(context)?.headofficecountry}",
                            list: state.loadedCountry,
                            privatekey: "countryCompanyHeadId",
                            selectedId: state
                                .loadedProfilePage.company.countryCompanyHeadId
                                .toString()),
                        const SizedBox(height: 16),
                        TextInput(
                            text:
                                "${AppLocalizations.of(context)?.organizationaddress}",
                            textFieldControler: postAddress),
                      ],
                      context),
                  const SizedBox(height: 16),
                  razvertka(
                      "${AppLocalizations.of(context)?.contactinformation}",
                      [
                        const SizedBox(height: 16),
                        TextInput(
                            text: "${AppLocalizations.of(context)?.phone}",
                            textFieldControler: phoneNumber),
                        const SizedBox(height: 16),
                        TextInput(
                            text: "${AppLocalizations.of(context)?.email}",
                            textFieldControler: email),
                        const SizedBox(height: 16),
                        TextInput(
                            text: "${AppLocalizations.of(context)?.website}",
                            textFieldControler: webSite),
                      ],
                      context),
                  const SizedBox(height: 16),
                  razvertka(
                      "${AppLocalizations.of(context)?.arrival}",
                      [
                        TextInput(
                            text: "${AppLocalizations.of(context)?.place}",
                            textFieldControler: arrivalStation),
                        const SizedBox(height: 16),
                        TextInput(
                            text:
                                "${AppLocalizations.of(context)?.flightnumber}",
                            textFieldControler: arrivalFlightInfo),
                        const SizedBox(height: 16),
                        TextInput(
                            icon2: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SvgPicture.asset(
                                "assets/icons/calendar.svg",
                                color: Colors.black,
                              ),
                            ),
                            text:
                                "${AppLocalizations.of(context)?.dateandtime}",
                            textFieldControler: arrivalDateTime),
                      ],
                      context),
                  const SizedBox(height: 16),
                  razvertka(
                      "${AppLocalizations.of(context)?.departure}",
                      [
                        TextInput(
                            text: "${AppLocalizations.of(context)?.place}",
                            textFieldControler: departureStation),
                        const SizedBox(height: 16),
                        TextInput(
                            text:
                                "${AppLocalizations.of(context)?.flightnumber}",
                            textFieldControler: departureFlightInfo),
                        const SizedBox(height: 16),
                        TextInput(
                            icon2: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SvgPicture.asset(
                                "assets/icons/calendar.svg",
                                color: Colors.black,
                              ),
                            ),
                            text:
                                "${AppLocalizations.of(context)?.dateandtime}",
                            textFieldControler: departureDateTime),
                      ],
                      context),
                  const SizedBox(height: 16),
                  razvertka(
                      "${AppLocalizations.of(context)?.comment}",
                      [
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 160,
                          child: AbsorbPointer(
                            absorbing: enabled,
                            child: TextInput(
                              enabled: enabled,
                              text: "${AppLocalizations.of(context)?.comment}",
                              textFieldControler: comment,
                              multline: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      context),
                  const SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<ClaimUpdateCubit>().updateclaim(
                                  firstNameRus.text,
                                  lastNameRus.text,
                                  patronymic.text,
                                  firstNameEng.text,
                                  lastNameEng.text,
                                  comment.text,
                                  companynameRus.text,
                                  companynameEng.text,
                                  companypositionRus.text,
                                  companypositionEng.text,
                                  postAddress.text,
                                  phoneNumber.text,
                                  email.text,
                                  webSite.text,
                                  birthday.text,
                                  passportNumber.text,
                                  issuedBy.text,
                                  issuedDate.text,
                                  validUntilDate.text,
                                  birthPlace.text,
                                  visa == true ? "true" : "false",
                                  arrivalStation.text,
                                  arrivalDateTime.text,
                                  arrivalFlightInfo.text,
                                  departureStation.text,
                                  departureDateTime.text,
                                  departureFlightInfo.text);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: BlocBuilder<ClaimUpdateCubit,
                                    ClaimUpdatetate>(builder: (context, state) {
                                  if (state is ClaimLoadedClaimState) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ));
                                  }

                                  return Text(
                                    "${AppLocalizations.of(context)?.savechanges}",
                                    style: TextStyle(fontSize: 16),
                                  );
                                }))),
                      )),
                  const SizedBox(height: 16),

                  //                       Center(
                  //                         child: CircularProfileAvatar(
                  //                           '',
                  //                           borderColor: kBacColor,
                  //                           child: state.loadedProfilePage.photo == null
                  //                               ? ColorFiltered(
                  //                                   colorFilter: ColorFilter.mode(
                  //                                       Colors.white.withOpacity(0.4),
                  //                                       BlendMode.color),
                  //                                   child: SvgPicture.asset(
                  //                                     "assets/icons/noimg.svg",
                  //                                     fit: BoxFit.cover,
                  //                                     alignment: Alignment.center,
                  //                                     color: kPrimaryColor,
                  //                                   ),
                  //                                 )
                  //                               : ColorFiltered(
                  //                                   colorFilter: ColorFilter.mode(
                  //                                       Colors.white.withOpacity(0.4),
                  //                                       BlendMode.color),
                  //                                   child: Image.network(
                  //                                     "${ConstantsClass.url}${state.loadedProfilePage.photo}",
                  //                                     fit: BoxFit.cover,
                  //                                     alignment: Alignment.center,
                  //                                   ),
                  //                                 ),
                  //                           radius: 65,
                  //                         ),
                  //                       ),
                  //                       SizedBox(height: 16),
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: DropdownInput(
                  //                               enabled: true,
                  //                               text:
                  //                                   "${AppLocalizations.of(context)?.participationpackage}",
                  //                               list: [
                  //                                 ConstantsClass.locale == "en"
                  //                                     ? state.loadedProfilePage.category.nameEng
                  //                                     : state.loadedProfilePage.category.nameRus
                  //                               ],
                  //                               selectedvalue: ConstantsClass.locale == "en"
                  //                                   ? state.loadedProfilePage.category.nameEng
                  //                                   : state.loadedProfilePage.category.nameRus)),

                  //                       SizedBox(height: 16),
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: DropdownInput(
                  //                               enabled: true,
                  //                               text: "${AppLocalizations.of(context)?.pol}",
                  //                               list: [
                  //                                 ConstantsClass.locale == "en"
                  //                                     ? state.loadedProfilePage.genderId == 1
                  //                                         ? "Male"
                  //                                         : "Female"
                  //                                     : state.loadedProfilePage.category
                  //                                                 .nameRus ==
                  //                                             1
                  //                                         ? "Мужской"
                  //                                         : "Женский"
                  //                               ],
                  //                               selectedvalue: ConstantsClass.locale == "en"
                  //                                   ? state.loadedProfilePage.genderId == 1
                  //                                       ? "Male"
                  //                                       : "Female"
                  //                                   : state.loadedProfilePage.category.nameRus ==
                  //                                           1
                  //                                       ? "Мужской"
                  //                                       : "Женский")),
                  //                       SizedBox(height: 16),

                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: DropdownInput(
                  //                               enabled: true,
                  //                               text: "${AppLocalizations.of(context)?.appeal}",
                  //                               list: [
                  //                                 ConstantsClass.locale == "en"
                  //                                     ? state
                  //                                         .loadedTitles[
                  //                                             state.loadedProfilePage.titleId - 1]
                  //                                         .nameEng
                  //                                     : state
                  //                                         .loadedTitles[
                  //                                             state.loadedProfilePage.titleId - 1]
                  //                                         .nameRus
                  //                               ],
                  //                               selectedvalue: ConstantsClass.locale == "en"
                  //                                   ? state
                  //                                       .loadedTitles[
                  //                                           state.loadedProfilePage.titleId - 1]
                  //                                       .nameEng
                  //                                   : state
                  //                                       .loadedTitles[
                  //                                           state.loadedProfilePage.titleId - 1]
                  //                                       .nameRus)),
                  //                       SizedBox(height: 16),

                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: TextInput(
                  //                               text: "${AppLocalizations.of(context)?.fullname}",
                  //                               textFieldControler:
                  //                                   textEditingControllernameenabledr,
                  //                               enabled: true)),
                  //                       SizedBox(height: 16),
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: TextInput(
                  //                               text:
                  //                                   "${AppLocalizations.of(context)?.fullnameeng}",
                  //                               textFieldControler:
                  //                                   textEditingControllernameenablede,
                  //                               enabled: true)),
                  //                       SizedBox(height: 16),
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: TextInput(
                  //                               text:
                  //                                   "${AppLocalizations.of(context)?.dateofbirth}",
                  //                               textFieldControler: textEditingControllerbenabled,
                  //                               enabled: true)),
                  //                       SizedBox(height: 16),
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: TextInput(
                  //                               text:
                  //                                   "${AppLocalizations.of(context)?.passportnumber}",
                  //                               textFieldControler:
                  //                                   textEditingControllerpassportenabled,
                  //                               enabled: true)),
                  //                       SizedBox(height: 16),
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: DropdownInput(
                  //                               enabled: true,
                  //                               text: "text",
                  //                               list: ["one", "two"],
                  //                               selectedvalue: "one")),
                  //                       SizedBox(height: 16),
                  // //!Низ
                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: DropdownInput(
                  //                               enabled: true,
                  //                               text: "text",
                  //                               list: ["one", "two"],
                  //                               selectedvalue: "one")),

                  //                       AbsorbPointer(
                  //                           absorbing: true,
                  //                           child: TextInput(
                  //                               text:
                  //                                   "${AppLocalizations.of(context)?.participationpackage}",
                  //                               textFieldControler:
                  //                                   textEditingControllernameenablede,
                  //                               enabled: true)),
                ],
              ));
            }

            return Center(
                child: Text("${AppLocalizations.of(context)?.error}"));
          })),
    );
  }
}

Widget razvertka(String text, List<Widget> widgets, BuildContext context) {
  return ExpansionTile(
      collapsedBackgroundColor: Color(0xFFE2EAEB),
      backgroundColor: Color(0xFFE2EAEB),
      title: Text(text),
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            color: kBacColor,
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets))
      ]);
}
