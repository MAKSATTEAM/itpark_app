// To parse this JSON data, do
//
//     final profilePageModel = profilePageModelFromJson(jsonString);

import 'dart:ui';

import 'dart:convert';

ProfilePageModel profilePageModelFromJson(String str) =>
    ProfilePageModel.fromJson(json.decode(str));

class ProfilePageModel {
  ProfilePageModel({
    required this.id,
    required this.eventId,
    required this.timeMinuteInterval,
    this.firstNameRus,
    this.lastNameRus,
    this.patronymic,
    this.firstNameEng,
    this.lastNameEng,
    this.genderId,
    this.titleId,
    this.rusRegionId,
    this.comment,
    this.languageId,
    this.residenceId,
    this.photo,
    this.webSite,
    this.email,
    this.phoneNumber,
    this.passportNumber,
    this.citizenshipId,
    this.birthday,
    this.issuedBy,
    this.issuedDate,
    this.validUntilDate,
    this.birthPlace,
    this.topic,
    this.resume,
    this.visa,
    this.needHotel,
    this.participantArrivalDeparture,
    this.hotel,
    this.room,
    this.covid19Form,
    this.contractOfPayment,
    this.cityId,
    this.city,
    this.branchId,
    this.branchName,
    this.roadId,
    this.roadName,
    this.competenceId,
    this.scenarioId,
  });

  int id;
  int eventId;
  int timeMinuteInterval;
  String? firstNameRus;
  String? lastNameRus;
  String? patronymic;
  String? firstNameEng;
  String? lastNameEng;
  int? genderId;
  int? titleId;
  int? rusRegionId;
  String? comment;
  int? languageId;
  int? residenceId;
  String? photo;
  String? webSite;
  String? email;
  String? phoneNumber;
  String? passportNumber;
  int? citizenshipId;
  DateTime? birthday;
  String? issuedBy;
  DateTime? issuedDate;
  DateTime? validUntilDate;
  String? birthPlace;
  String? topic;
  String? resume;
  bool? visa;
  bool? needHotel;
  ParticipantArrivalDeparture? participantArrivalDeparture;
  String? hotel;
  String? room;
  Covid19Form? covid19Form;
  String? contractOfPayment;
  int? cityId;
  String? city;
  int? branchId;
  String? branchName;
  int? roadId;
  String? roadName;
  int? competenceId;
  int? scenarioId;

  factory ProfilePageModel.fromJson(Map<String, dynamic> json) =>
      ProfilePageModel(
        id: json["id"],
        eventId: json["eventId"],
        timeMinuteInterval: json["timeMinuteInterval"],
        firstNameRus: json["firstNameRus"],
        lastNameRus: json["lastNameRus"],
        patronymic: json["patronymic"],
        firstNameEng: json["firstNameEng"],
        lastNameEng: json["lastNameEng"],
        genderId: json["genderId"],
        titleId: json["titleId"],
        rusRegionId: json["rusRegionId"],
        comment: json["comment"],
        languageId: json["languageId"],
        residenceId: json["residenceId"],
        photo: json["photo"],
        webSite: json["webSite"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        passportNumber: json["passportNumber"],
        citizenshipId: json["citizenshipId"],
        birthday: json["birthday"] != null ? DateTime.parse(json["birthday"]) : null,
        issuedBy: json["issuedBy"],
        issuedDate: json["issuedDate"] != null ? DateTime.parse(json["issuedDate"]) : null,
        validUntilDate: json["validUntilDate"] != null ? DateTime.parse(json["validUntilDate"]) : null,
        birthPlace: json["birthPlace"],
        topic: json["topic"],
        resume: json["resume"],
        visa: json["visa"],
        needHotel: json["needHotel"],
        participantArrivalDeparture: json["participantArrivalDeparture"] != null
            ? ParticipantArrivalDeparture.fromJson(json["participantArrivalDeparture"])
            : null,
        hotel: json["hotel"],
        room: json["room"],
        covid19Form: json["covid19Form"] != null
            ? Covid19Form.fromJson(json["covid19Form"])
            : null,
        contractOfPayment: json["contractOfPayment"],
        cityId: json["cityId"],
        city: json["city"],
        branchId: json["branchId"],
        branchName: json["branchName"],
        roadId: json["roadId"],
        roadName: json["roadName"],
        competenceId: json["competenceId"],
        scenarioId: json["scenarioId"],
      );
}
class ParticipantArrivalDeparture {
  ParticipantArrivalDeparture({
    this.arrivalTransportId,
    this.arrivalStation,
    this.arrivalFlightInfo,
    this.arrivalDateTime,
    this.departureTransportId,
    this.departureStation,
    this.departureFlightInfo,
    this.departureDateTime,
    this.isBaggageLost,
  });

  int? arrivalTransportId;
  String? arrivalStation;
  String? arrivalFlightInfo;
  DateTime? arrivalDateTime;
  int? departureTransportId;
  String? departureStation;
  String? departureFlightInfo;
  DateTime? departureDateTime;
  bool? isBaggageLost;

  factory ParticipantArrivalDeparture.fromJson(Map<String, dynamic> json) =>
      ParticipantArrivalDeparture(
        arrivalTransportId: json["arrivalTransportId"],
        arrivalStation: json["arrivalStation"],
        arrivalFlightInfo: json["arrivalFlightInfo"],
        arrivalDateTime: json["arrivalDateTime"] != null
            ? DateTime.parse(json["arrivalDateTime"])
            : null,
        departureTransportId: json["departureTransportId"],
        departureStation: json["departureStation"],
        departureFlightInfo: json["departureFlightInfo"],
        departureDateTime: json["departureDateTime"] != null
            ? DateTime.parse(json["departureDateTime"])
            : null,
        isBaggageLost: json["isBaggageLost"],
      );
}

class Item {
  Item({
    required this.id,
    required this.informationAboutPerson,
    required this.fullNameEn,
    required this.organizationEn,
    required this.jobTitle,
    required this.eventTitle,
    required this.templateName,
    required this.packageName,
    required this.applicationStatus,
    required this.date, // Новое поле для даты
  });

  final String id;
  final String informationAboutPerson;
  final String fullNameEn;
  final String organizationEn;
  final String jobTitle;
  final String eventTitle;
  final String templateName;
  final String packageName;
  final ApplicationStatus applicationStatus;
  final DateTime date; // Новое поле

  // Метод преобразования JSON-данных в объект Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"] ?? "",
      informationAboutPerson: json["informationAboutPerson"] ?? "No Information",
      fullNameEn: json["fullNameEN"] ?? "Unknown",
      organizationEn: json["organizationEN"] ?? "Unknown Organization",
      jobTitle: json["jobTitle"] ?? "Unknown Job",
      eventTitle: json["eventTitle"] ?? "Unknown Event",
      templateName: json["templateName"] ?? "Default Template",
      packageName: json["packageName"] ?? "Standard Package",
      applicationStatus: ApplicationStatus.fromJson(json["applicationStatus"]),
      date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(), // Парсинг даты
    );
  }
}


class ApplicationStatus {
  ApplicationStatus({
    required this.value,
    required this.code,
  });

  String? value;
  String? code;

  factory ApplicationStatus.fromJson(Map<String, dynamic> json) =>
      ApplicationStatus(
        value: json["value"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "code": code,
      };
}

///////////////////////////////////////////////CC

ClaimPageModel claimPageModelFromJson(String str) =>
    ClaimPageModel.fromJson(json.decode(str));

// String claimPageModelToJson(ClaimPageModel data) => json.encode(data.toJson());

class ClaimPageModel {
  ClaimPageModel({
    this.id,
    this.templateId,
    this.groups,
    this.fields,
    this.values,
  });

  String? id;
  String? templateId;
  List<Group>? groups;
  List<Field>? fields;
  Map<dynamic, dynamic>? values;

  factory ClaimPageModel.fromJson(Map<String, dynamic> json) {
    return ClaimPageModel(
        id: json["id"],
        templateId: json["TemplateId"],
        groups: json["groups"] == null
            ? null
            : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        fields: json["fields"] == null
            ? null
            : List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        values: json["values"]);
  }
}

class Field {
  Field({
    this.type,
    this.items,
    this.display,
    this.code,
    this.disabled,
  });

  String? type;
  List<Citizenship?>? items;
  String? display;
  String? code;
  bool? disabled;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        type: json["Type"],
        items: json["Items"] == null
            ? null
            : List<Citizenship>.from(
                json["Items"].map((x) => Citizenship.fromJson(x))),
        display: json["display"],
        code: json["Code"],
        disabled: json["Disabled"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "Items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x?.toJson())),
        "display": display,
        "Code": code,
        "Disabled": disabled,
      };
}

class Citizenship {
  Citizenship({
    this.id,
    this.display,
  });

  String? id;
  String? display;

  factory Citizenship.fromJson(Map<String, dynamic> json) => Citizenship(
        id: json["id"],
        display: json["display"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "display": display,
      };
}

class Group {
  Group({
    this.display,
    this.fields,
  });

  String? display;
  List<String>? fields;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        display: json["display"],
        fields: json["fields"] == null
            ? null
            : List<String>.from(json["fields"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "display": display,
        "fields":
            fields == null ? null : List<dynamic>.from(fields!.map((x) => x)),
      };
}
// To parse this JSON data, do
//
//     final eventProgramModel = eventProgramModelFromJson(jsonString);

List<EventProgramModel> eventProgramModelFromJson(String str) =>
    List<EventProgramModel>.from(
        json.decode(str).map((x) => EventProgramModel.fromJson(x)));

class EventProgramModel {
  EventProgramModel({
    this.id,
    this.subscribe,
    this.eventId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.dateTimeStart,
    this.dateTimeFinish,
    this.placeRus,
    this.placeEng,
    this.placeAra,
    this.isVip,
    this.descriptionRus,
    this.descriptionEng,
    this.descriptionAra,
    this.registered,
    this.statusId,
    this.streamUrl,
    this.speakers,
  });

  int? id;
  dynamic subscribe;
  int? eventId;
  String? nameRus;
  String? nameEng;
  String? nameAra;
  DateTime? dateTimeStart;
  DateTime? dateTimeFinish;
  String? placeRus;
  String? placeEng;
  String? placeAra;
  bool? isVip;
  String? descriptionRus;
  String? descriptionEng;
  String? descriptionAra;
  bool? registered;
  dynamic statusId;
  dynamic streamUrl;
  List<SpeakerModel>? speakers;

  factory EventProgramModel.fromJson(Map<String, dynamic> json) {
    print(json["nameRus"]);
    print(json["firstNameRus"]);
    return EventProgramModel(
      id: json["id"],
      subscribe: json["subscribe"],
      eventId: json["eventId"],
      nameRus: json["nameRus"],
      nameEng: json["nameEng"],
      nameAra: json["nameAra"],
      dateTimeStart: DateTime.parse(json["dateTimeStart"]),
      dateTimeFinish: DateTime.parse(json["dateTimeFinish"]),
      placeRus: json["placeRus"],
      placeEng: json["placeEng"],
      placeAra: json["placeAra"],
      isVip: json["isVip"],
      descriptionRus: json["descriptionRus"],
      descriptionEng: json["descriptionEng"],
      descriptionAra: json["descriptionAra"],
      registered: json["registered"],
      statusId: json["statusId"],
      streamUrl: json["streamUrl"],
      speakers: json["speakers"] == null
          ? null
          : List<SpeakerModel>.from(
              json["speakers"].map((x) => SpeakerModel.fromJson(x))),
    );
  }
}

class SpeakerModel {
  SpeakerModel({
    this.id,
    this.firstNameRus,
    this.lastNameRus,
    this.patronymicRus,
    this.firstNameEng,
    this.lastNameEng,
    this.firstNameAra,
    this.lastNameAra,
    this.patronymicAra,
    this.companyRus,
    this.companyEng,
    this.companyAra,
    this.positionRus,
    this.positionEng,
    this.positionAra,
    this.photo,
  });

  int? id;
  String? firstNameRus;
  String? lastNameRus;
  String? patronymicRus;
  String? firstNameEng;
  String? lastNameEng;
  String? firstNameAra;
  String? lastNameAra;
  String? patronymicAra;
  String? companyRus;
  String? companyEng;
  String? companyAra;
  String? positionRus;
  String? positionEng;
  String? positionAra;
  String? photo;

  factory SpeakerModel.fromJson(Map<String, dynamic> json) => SpeakerModel(
        id: json["id"],
        firstNameRus: json["firstNameRus"],
        lastNameRus: json["lastNameRus"],
        patronymicRus: json["patronymicRus"],
        firstNameEng: json["firstNameEng"],
        lastNameEng: json["lastNameEng"],
        firstNameAra: json["firstNameAra"],
        lastNameAra: json["lastNameAra"],
        patronymicAra: json["patronymicAra"],
        companyRus: json["companyRus"],
        companyEng: json["companyEng"],
        companyAra: json["companyAra"],
        positionRus: json["positionRus"],
        positionEng: json["positionEng"],
        positionAra: json["positionAra"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstNameRus": firstNameRus,
        "lastNameRus": lastNameRus,
        "patronymicRus": patronymicRus,
        "firstNameEng": firstNameEng,
        "lastNameEng": lastNameEng,
        "firstNameAra": firstNameAra,
        "lastNameAra": lastNameAra,
        "patronymicAra": patronymicAra,
        "companyRus": companyRus,
        "companyEng": companyEng,
        "companyAra": companyAra,
        "positionRus": positionRus,
        "positionEng": positionEng,
        "positionAra": positionAra,
        "photo": photo,
      };
}

//-------------------Model Event Culture
// To parse this JSON data, do
//
//     final eventCulturModel = eventCulturModelFromJson(jsonString);

List<EventCulturModel> eventCulturModelFromJson(String str) =>
    List<EventCulturModel>.from(
        json.decode(str).map((x) => EventCulturModel.fromJson(x)));

String eventCulturModelToJson(List<EventCulturModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventCulturModel {
  EventCulturModel({
    this.id,
    this.eventId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.isVip,
    this.dateTimeStart,
    this.dateTimeFinish,
    this.placeRus,
    this.placeEng,
    this.placeAra,
    this.descriptionRus,
    this.descriptionEng,
    this.descriptionAra,
    this.registered,
    this.statusId,
    this.isProdExc,
  });

  int? id;
  int? eventId;
  String? nameRus;
  String? nameEng;
  String? nameAra;
  bool? isVip;
  DateTime? dateTimeStart;
  DateTime? dateTimeFinish;
  String? placeRus;
  String? placeEng;
  String? placeAra;
  String? descriptionRus;
  String? descriptionEng;
  String? descriptionAra;
  bool? registered;
  dynamic statusId;
  dynamic isProdExc;

  factory EventCulturModel.fromJson(Map<String, dynamic> json) =>
      EventCulturModel(
        id: json["id"],
        eventId: json["eventId"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        nameAra: json["nameAra"],
        isVip: json["isVip"],
        dateTimeStart: DateTime.parse(json["dateTimeStart"]),
        dateTimeFinish: DateTime.parse(json["dateTimeFinish"]),
        placeRus: json["placeRus"],
        placeEng: json["placeEng"],
        placeAra: json["placeAra"],
        descriptionRus: json["descriptionRus"],
        descriptionEng: json["descriptionEng"],
        descriptionAra: json["descriptionAra"],
        registered: json["registered"],
        statusId: json["statusId"],
        isProdExc: json["isProdExc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventId": eventId,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "nameAra": nameAra,
        "isVip": isVip,
        "dateTimeStart": dateTimeStart!.toIso8601String(),
        "dateTimeFinish": dateTimeFinish!.toIso8601String(),
        "placeRus": placeRus,
        "placeEng": placeEng,
        "placeAra": placeAra,
        "descriptionRus": descriptionRus,
        "descriptionEng": descriptionEng,
        "descriptionAra": descriptionAra,
        "registered": registered,
        "statusId": statusId,
        "isProdExc": isProdExc,
      };
}

//--------------Model for Speakers

class SpeakersModel {
  int? id;
  String? firstNameRus;
  String? lastNameRus;
  String? patronymicRus;
  String? firstNameEng;
  String? lastNameEng;
  String? firstNameAra;
  String? lastNameAra;
  String? patronymicAra;
  String? companyRus;
  String? companyEng;
  String? companyAra;
  String? positionRus;
  String? positionEng;
  String? positionAra;
  String? photo;
  List<EventProgram>? eventProgram;

  SpeakersModel({
    this.id,
    this.firstNameRus,
    this.lastNameRus,
    this.patronymicRus,
    this.firstNameEng,
    this.lastNameEng,
    this.firstNameAra,
    this.lastNameAra,
    this.patronymicAra,
    this.companyRus,
    this.companyEng,
    this.companyAra,
    this.positionRus,
    this.positionEng,
    this.positionAra,
    this.photo,
    this.eventProgram,
  });

  SpeakersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstNameRus = json['firstNameRus'];
    lastNameRus = json['lastNameRus'];
    patronymicRus = json['patronymicRus'];
    firstNameEng = json['firstNameEng'];
    lastNameEng = json['lastNameEng'];
    firstNameAra = json['firstNameAra'];
    lastNameAra = json['lastNameAra'];
    patronymicAra = json['patronymicAra'];
    companyRus = json['companyRus'];
    companyEng = json['companyEng'];
    companyAra = json['companyAra'];
    positionRus = json['positionRus'];
    positionEng = json['positionEng'];
    positionAra = json['positionAra'];
    photo = json['photo'];
    eventProgram = json["eventProgram"] == null
        ? null
        : List<EventProgram>.from(
            json["eventProgram"].map((x) => EventProgram.fromJson(x)));
  }
}

class EventProgram {
  EventProgram({
    this.id,
    this.eventId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.dateTimeStart,
    this.dateTimeFinish,
    this.placeRus,
    this.placeEng,
    this.placeAra,
    this.isVip,
    this.descriptionRus,
    this.descriptionEng,
    this.descriptionAra,
    this.registered,
    this.statusId,
    this.streamUrl,
  });

  dynamic id;
  dynamic eventId;
  dynamic nameRus;
  dynamic nameEng;
  dynamic nameAra;
  dynamic dateTimeStart;
  dynamic dateTimeFinish;
  dynamic placeRus;
  dynamic placeEng;
  dynamic placeAra;
  dynamic isVip;
  dynamic descriptionRus;
  dynamic descriptionEng;
  dynamic descriptionAra;
  dynamic registered;
  dynamic statusId;
  dynamic streamUrl;

  factory EventProgram.fromJson(Map<String, dynamic> json) {
    print("dd1=${json["id"]}");
    print("dd2=${json["eventId"]}");
    print("dd3=${json["nameRus"]}");
    print("dd4=${json["nameEng"]}");
    print("dd5=${json["nameAra"]}");
    print("dd6=${json["dateTimeStart"]}");
    print("dd7=${json["dateTimeFinish"]}");
    print("dd8=${json["placeRus"]}");
    print("dd9=${json["placeEng"]}");
    print("dd10=${json["placeAra"]}");
    print("dd11=${json["isVip"]}");
    print("dd12=${json["descriptionRus"]}");
    print("dd13=${json["descriptionEng"]}");
    print("dd14=${json["descriptionAra"]}");
    print("dd15=${json["registered"]}");
    print("dd16=${json["statusId"]}");
    print("dd17=${json["streamUrl"]}");

    return EventProgram(
      id: json["id"],
      eventId: json["eventId"],
      nameRus: json["nameRus"],
      nameEng: json["nameEng"],
      nameAra: json["nameAra"],
      dateTimeStart: json["dateTimeStart"] == null
          ? null
          : DateTime.parse(json["dateTimeStart"]),
      dateTimeFinish: json["dateTimeFinish"] == null
          ? null
          : DateTime.parse(json["dateTimeFinish"]),
      placeRus: json["placeRus"],
      placeEng: json["placeEng"],
      placeAra: json["placeAra"],
      isVip: json["isVip"],
      descriptionRus:
          json["descriptionRus"],
      descriptionEng:
          json["descriptionEng"],
      descriptionAra:
          json["descriptionAra"],
      registered: json["registered"],
      statusId: json["statusId"],
      streamUrl: json["streamUrl"],
    );
  }
}

//* Модель голосования

List<VotingPageModel> votingPageModelFromJson(String str) =>
    List<VotingPageModel>.from(
        json.decode(str).map((x) => VotingPageModel.fromJson(x)));

String votingPageModelToJson(List<VotingPageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VotingPageModel {
  VotingPageModel({
    this.id,
    this.eventId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.isActive,
    this.timeInterval,
    this.choosedAnswerId,
    this.voteAnswers,
  });

  int? id;
  int? eventId;
  String? nameRus;
  String? nameEng;
  String? nameAra;
  bool? isActive;
  int? timeInterval;
  int? choosedAnswerId;
  List<VoteAnswer?>? voteAnswers;

  factory VotingPageModel.fromJson(Map<String, dynamic> json) {
    return VotingPageModel(
        id: json["id"],
        eventId: json["eventId"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        nameAra: json["nameAra"],
        isActive: json["isActive"],
        timeInterval:
            json["timeInterval"],
        choosedAnswerId:
            json["choosedAnswerId"],
        voteAnswers: json["voteAnswers"] == null
            ? null
            : List<VoteAnswer>.from(
                json["voteAnswers"].map((x) => VoteAnswer.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventId": eventId,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "nameAra": nameAra,
        "isActive": isActive,
        "timeInterval": timeInterval,
        "choosedAnswerId": choosedAnswerId,
        "voteAnswers": voteAnswers == null
            ? null
            : List<dynamic>.from(voteAnswers!.map((x) => x?.toJson())),
      };
}

class VoteAnswer {
  VoteAnswer({
    this.id,
    this.voteId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
  });

  int? id;
  int? voteId;
  String? nameRus;
  String? nameEng;
  String? nameAra;

  factory VoteAnswer.fromJson(Map<String, dynamic> json) => VoteAnswer(
        id: json["id"],
        voteId: json["voteId"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        nameAra: json["nameAra"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "voteId": voteId,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "nameAra": nameAra,
      };
}

//Профиль

class ProfileOldModel {
  ProfileOldModel(
      {this.id,
      this.eventId,
      this.timeMinuteInterval,
      this.firstNameRus,
      this.lastNameRus,
      this.patronymic,
      this.firstNameEng,
      this.lastNameEng,
      this.genderId,
      this.titleId,
      this.rusRegionId,
      this.comment,
      this.languageId,
      this.residenceId,
      this.photo,
      this.webSite,
      this.email,
      this.phoneNumber,
      this.passportNumber,
      this.citizenshipId,
      this.birthday,
      this.issuedBy,
      this.issuedDate,
      this.validUntilDate,
      this.birthPlace,
      this.topic,
      this.resume,
      this.visa,
      this.needHotel,
      this.participantArrivalDeparture,
      this.hotel,
      this.room,
      this.covid19Form,
      this.contractOfPayment,
      this.company,
      this.category,
      this.checkInDateTime,
      this.checkOutDateTime,
      this.paymentInfo,
      this.russianRegion,
      this.programs});

  dynamic id;
  dynamic eventId;
  dynamic timeMinuteInterval;
  dynamic firstNameRus;
  dynamic lastNameRus;
  dynamic patronymic;
  dynamic firstNameEng;
  dynamic lastNameEng;
  dynamic genderId;
  dynamic titleId;
  dynamic rusRegionId;
  dynamic comment;
  dynamic languageId;
  dynamic residenceId;
  dynamic photo;
  dynamic webSite;
  dynamic email;
  dynamic phoneNumber;
  dynamic passportNumber;

  dynamic citizenshipId;
  dynamic birthday;
  dynamic issuedBy;
  dynamic issuedDate;
  dynamic validUntilDate;
  dynamic birthPlace;
  dynamic topic;
  dynamic resume;
  dynamic visa;
  dynamic needHotel;
  dynamic participantArrivalDeparture;
  dynamic hotel;
  dynamic room;
  dynamic covid19Form;
  dynamic contractOfPayment;
  dynamic company;
  dynamic category;
  dynamic checkInDateTime;
  dynamic checkOutDateTime;
  dynamic paymentInfo;
  dynamic russianRegion;
  dynamic programs;

  factory ProfileOldModel.fromRawJson(String str) =>
      ProfileOldModel.fromJson(json.decode(str));

  factory ProfileOldModel.fromJson(Map<String, dynamic> json) {
    return ProfileOldModel(
      id: json["id"],
      eventId: json["eventId"],
      timeMinuteInterval: json["timeMinuteInterval"],
      firstNameRus: json["firstNameRus"],
      lastNameRus: json["lastNameRus"],
      patronymic: json["patronymic"],
      firstNameEng: json["firstNameEng"],
      lastNameEng: json["lastNameEng"],
      genderId: json["genderId"],
      titleId: json["titleId"],
      rusRegionId: json["rusRegionId"],
      comment: json["comment"],
      languageId: json["languageId"],
      residenceId: json["residenceId"],
      photo: json["photo"],
      webSite: json["webSite"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      passportNumber:
          json["passportNumber"],
      citizenshipId:
          json["citizenshipId"],
      birthday:
          json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
      issuedBy: json["issuedBy"],
      issuedDate: json["issuedDate"],
      validUntilDate: json["validUntilDate"],
      birthPlace: json["birthPlace"],
      topic: json["topic"],
      resume: json["resume"],
      visa: json["visa"],
      needHotel: json["needHotel"],
      participantArrivalDeparture: json["participantArrivalDeparture"] == null
          ? null
          : ParticipantArrivalDeparture.fromJson(
              json["participantArrivalDeparture"]),
      hotel: json["hotel"],
      room: json["room"],
      covid19Form: json["covid19Form"] == null
          ? null
          : Covid19Form.fromJson(json["covid19Form"]),
      contractOfPayment: json["contractOfPayment"],
      company:
          json["company"] == null ? null : Company.fromJson(json["company"]),
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      checkInDateTime: json["checkInDateTime"],
      checkOutDateTime: json["checkOutDateTime"],
      paymentInfo: json["paymentInfo"],
      russianRegion: json["russianRegion"],
      programs: json["programs"] == null
          ? null
          : List<dynamic>.from(json["programs"].map((x) {
              if (x != null) {
                print("x=$x");
                return EventProgram.fromJson(x);
              }
            })),
    );
  }
}

class Category {
  Category({
    this.id,
    this.templateCategoryId,
    this.eventId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.descriptionRus,
    this.descriptionEng,
    this.descriptionAra,
    this.code,
    this.color,
    this.priceRouble,
    this.priceDollar,
    this.isPress,
  });

  dynamic id;
  dynamic templateCategoryId;
  dynamic eventId;
  dynamic nameRus;
  dynamic nameEng;
  dynamic nameAra;
  dynamic descriptionRus;
  dynamic descriptionEng;
  dynamic descriptionAra;
  dynamic code;
  dynamic color;
  dynamic priceRouble;
  dynamic priceDollar;
  dynamic isPress;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        templateCategoryId:
            json["templateCategoryId"],
        eventId: json["eventId"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        nameAra: json["nameAra"],
        descriptionRus: json["descriptionRus"],
        descriptionEng: json["descriptionEng"],
        descriptionAra: json["descriptionAra"],
        code: json["code"],
        color: json["color"],
        priceRouble: json["priceRouble"],
        priceDollar: json["priceDollar"],
        isPress: json["isPress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "templateCategoryId": templateCategoryId,
        "eventId": eventId,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "nameAra": nameAra,
        "descriptionRus": descriptionRus,
        "descriptionEng": descriptionEng,
        "descriptionAra": descriptionAra,
        "code": code,
        "color": color,
        "priceRouble": priceRouble,
        "priceDollar": priceDollar,
        "isPress": isPress,
      };
}

class Company {
  Company({
    this.id,
    this.nameRus,
    this.nameEng,
    this.positionRus,
    this.positionEng,
    this.countryCompanyHeadId,
    this.postAddress,
    this.sphere,
    this.sphereId,
  });

  dynamic id;
  dynamic nameRus;
  dynamic nameEng;
  dynamic positionRus;
  dynamic positionEng;
  dynamic countryCompanyHeadId;
  dynamic postAddress;
  dynamic sphere;
  dynamic sphereId;

  factory Company.fromRawJson(String str) => Company.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        positionRus: json["positionRus"],
        positionEng: json["positionEng"],
        countryCompanyHeadId: json["countryCompanyHeadId"],
        postAddress: json["postAddress"],
        sphere: json["sphere"] == null ? null : Sphere.fromJson(json["sphere"]),
        sphereId: json["sphereId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "positionRus": positionRus,
        "positionEng": positionEng,
        "countryCompanyHeadId":
            countryCompanyHeadId,
        "postAddress": postAddress,
        "sphere": sphere?.toJson(),
        "sphereId": sphereId,
      };
}

class Sphere {
  Sphere({
    this.id,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.isMassMedia,
  });

  dynamic id;
  dynamic nameRus;
  dynamic nameEng;
  dynamic nameAra;
  dynamic isMassMedia;

  factory Sphere.fromRawJson(String str) => Sphere.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sphere.fromJson(Map<String, dynamic> json) => Sphere(
        id: json["id"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        nameAra: json["nameAra"],
        isMassMedia: json["isMassMedia"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "nameAra": nameAra,
        "isMassMedia": isMassMedia,
      };
}

class Covid19Form {
  Covid19Form({
    required this.id,
    this.documentType,
    this.documentUrl,
    this.documentPath,
    this.hasSickOfCovid19,
    this.hasAntibodiesToCovid19,
    this.isVaccinated,
    this.isArriveFormAbroad,
    this.kazanStreet,
    this.kazanHomeNumber,
    this.kazanHousing,
    this.kazanFlatNumber,
    this.hotelName,
    this.hasMeasles,
    this.dateOfVaccination,
    this.dateOfReVaccination,
    this.isOverillOrResultsWithSerologicalStudy,
    this.isVaccinated2020Or2021,
    this.mobileNumber,
  });

  int id;
  int? documentType;
  String? documentUrl;
  String? documentPath;
  bool? hasSickOfCovid19;
  bool? hasAntibodiesToCovid19;
  bool? isVaccinated;
  bool? isArriveFormAbroad;
  String? kazanStreet;
  String? kazanHomeNumber;
  String? kazanHousing;
  String? kazanFlatNumber;
  String? hotelName;
  bool? hasMeasles;
  DateTime? dateOfVaccination;
  DateTime? dateOfReVaccination;
  bool? isOverillOrResultsWithSerologicalStudy;
  bool? isVaccinated2020Or2021;
  String? mobileNumber;

  factory Covid19Form.fromJson(Map<String, dynamic> json) => Covid19Form(
    id: json["id"],
    documentType: json["documentType"],
    documentUrl: json["documentUrl"],
    documentPath: json["documentPath"],
    hasSickOfCovid19: json["hasSickOfCovid19"],
    hasAntibodiesToCovid19: json["hasAntibodiesToCovid19"],
    isVaccinated: json["isVaccinated"],
    isArriveFormAbroad: json["isArriveFormAbroad"],
    kazanStreet: json["kazanStreet"],
    kazanHomeNumber: json["kazanHomeNumber"],
    kazanHousing: json["kazanHousing"],
    kazanFlatNumber: json["kazanFlatNumber"],
    hotelName: json["hotelName"],
    hasMeasles: json["hasMeasles"],
    dateOfVaccination: json["dateOfVaccination"] != null ? DateTime.parse(json["dateOfVaccination"]) : null,
    dateOfReVaccination: json["dateOfReVaccination"] != null ? DateTime.parse(json["dateOfReVaccination"]) : null,
    isOverillOrResultsWithSerologicalStudy: json["isOverillOrResultsWithSerologicalStudy"],
    isVaccinated2020Or2021: json["isVaccinated2020Or2021"],
    mobileNumber: json["mobileNumber"],
  );
}

//!Модель - Универсальная

class UniversalModel {
  UniversalModel({
    this.id,
    this.nameRus,
    this.nameEng,
    this.nameAra,
  });

  int? id;
  String? nameRus;
  String? nameEng;
  String? nameAra;

  factory UniversalModel.fromJson(Map<String, dynamic> json) {
    return UniversalModel(
      id: json["id"] ?? 0,
      nameRus: json["nameRus"] ?? "null",
      nameEng: json["nameEng"] ?? "null",
      nameAra: json["nameAra"] ?? "null",
    );
  }
}

//!Модель - COMPANY B2B

class B2BCompanyModel {
  B2BCompanyModel({
    this.name,
  });

  String? name;

  factory B2BCompanyModel.fromJson(Map<String, dynamic> json) {
    return B2BCompanyModel(
      name: json["name"] ?? "null",
    );
  }
}

class NewsModel {
  NewsModel({
    this.date,
    this.title,
    this.link,
  });

  String? date;
  String? title;
  String? link;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        date: json["date"],
        title: json["title"],
        link: json["link"],
      );
}

//! Модель чисто карты

class MapUniversalModel {
  MapUniversalModel({
    this.id,
    this.name,
    this.description,
    this.longitude,
    this.latitude,
    this.address,
    this.photo,
    this.website,
    this.phone,
    this.latlng,
    required this.colorDot,
  });

  int? id;
  String? name;
  String? description;
  double? longitude;
  double? latitude;
  String? address;
  dynamic photo;
  String? website;
  String? phone;
  Color colorDot;
  List<double>? latlng;

  factory MapUniversalModel.fromJson(Map<String, dynamic> json, Color color) =>
      MapUniversalModel(
        colorDot: color,
        id: json["id"],
        name: json["name"],
        description: json["description"],
        longitude:
            json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        address: json["address"],
        photo: json["photo"],
        website: json["website"],
        phone: json["phone"],
        latlng: json["latlng"] == null
            ? null
            : List<double>.from(json["latlng"].map((x) => x.toDouble())),
      );
}

class MaterialsModel {
  MaterialsModel({
    this.id,
    this.name,
    this.filePath,
  });

  int? id;
  String? name;
  String? filePath;
  factory MaterialsModel.fromJson(Map<String, dynamic> json) {
    print(json["id"]);
    print(json["name"]);
    print(json["filePath"]);

    return MaterialsModel(
      id: json["id"],
      name: json["name"],
      filePath: json["filePath"],
    );
  }
}

//! Модель листа b2b
// To parse this JSON data, do
//
//     final b2BListModel = b2BListModelFromJson(jsonString);

class B2BListModel {
  B2BListModel({
    this.items,
    this.allItemsCount,
    this.pageNumber,
    this.itemOnPage,
  });

  List<Itemb2b>? items;
  int? allItemsCount;
  int? pageNumber;
  int? itemOnPage;

  factory B2BListModel.fromRawJson(String str) =>
      B2BListModel.fromJson(json.decode(str));

  factory B2BListModel.fromJson(Map<String, dynamic> json) {
    return B2BListModel(
      items: json["items"] == null
          ? null
          : List<Itemb2b>.from(json["items"].map((x) => Itemb2b.fromJson(x))),
      allItemsCount:
          json["allItemsCount"],
      pageNumber: json["pageNumber"],
      itemOnPage: json["itemOnPage"],
    );
  }
}

class Itemb2b {
  Itemb2b({
    this.id,
    this.firstNameRus,
    this.lastNameRus,
    this.patronymic,
    this.firstNameEng,
    this.lastNameEng,
    this.organizationRus,
    this.organizationEng,
    this.sphereId,
    this.sphereName,
    this.positionRus,
    this.positionEng,
    this.photo,
    this.sended,
    this.isSpeaker,
  });

  dynamic id;
  dynamic firstNameRus;
  dynamic lastNameRus;
  dynamic patronymic;
  dynamic firstNameEng;
  dynamic lastNameEng;
  dynamic organizationRus;
  dynamic organizationEng;
  dynamic sphereId;
  dynamic sphereName;
  dynamic positionRus;
  dynamic positionEng;
  dynamic photo;
  dynamic sended;
  dynamic isSpeaker;

  factory Itemb2b.fromRawJson(String str) => Itemb2b.fromJson(json.decode(str));

  factory Itemb2b.fromJson(Map<String, dynamic> json) {
    return Itemb2b(
      id: json["id"],
      firstNameRus: json["firstNameRus"],
      lastNameRus: json["lastNameRus"],
      patronymic: json["patronymic"],
      firstNameEng: json["firstNameEng"],
      lastNameEng: json["lastNameEng"],
      organizationRus:
          json["organizationRus"],
      organizationEng:
          json["organizationEng"],
      sphereId: json["sphereId"],
      sphereName: json["sphereName"],
      positionRus: json["positionRus"],
      positionEng: json["positionEng"],
      photo: json["photo"],
      sended: json["sended"],
      isSpeaker: json["isSpeaker"],
    );
  }
}

//! Модель partners

// To parse this JSON data, do
//
//     final partnersModel = partnersModelFromJson(jsonString);

class PartnersModel {
  PartnersModel({
    this.name,
    this.partners,
  });

  String? name;
  List<Partner>? partners;

  factory PartnersModel.fromRawJson(String str) =>
      PartnersModel.fromJson(json.decode(str));

  factory PartnersModel.fromJson(Map<String, dynamic> json) => PartnersModel(
        name: json["name"],
        partners: json["partners"] == null
            ? null
            : List<Partner>.from(
                json["partners"].map((x) => Partner.fromJson(x))),
      );
}

class Partner {
  Partner({
    this.imageFront,
    this.imageHover,
  });

  String? imageFront;
  String? imageHover;

  factory Partner.fromRawJson(String str) => Partner.fromJson(json.decode(str));

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
        imageFront: json["imageFront"],
        imageHover: json["imageHover"],
      );
}

//! Моделька транспорта

class TransportModel {
  TransportModel({
    this.id,
    this.eventId,
    this.name,
    this.eventCategoryId,
    this.category,
    this.facilityHotelShowPlaceFrom,
    this.facilityHotelShowPlaceTo,
    this.dateTimeArrival,
    this.dateTimeDeparture,
    this.diff,
  });

  dynamic id;
  dynamic eventId;
  dynamic name;
  dynamic eventCategoryId;
  dynamic category;
  dynamic facilityHotelShowPlaceFrom;
  dynamic facilityHotelShowPlaceTo;
  dynamic dateTimeArrival;
  dynamic dateTimeDeparture;
  dynamic diff;

  factory TransportModel.fromRawJson(String str) =>
      TransportModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransportModel.fromJson(Map<String, dynamic> json) => TransportModel(
        id: json["id"],
        eventId: json["eventId"],
        name: json["name"],
        eventCategoryId:
            json["eventCategoryId"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        facilityHotelShowPlaceFrom: json["facilityHotelShowPlaceFrom"] == null
            ? null
            : FacilityHotelShowPlace.fromJson(
                json["facilityHotelShowPlaceFrom"]),
        facilityHotelShowPlaceTo: json["facilityHotelShowPlaceTo"] == null
            ? null
            : FacilityHotelShowPlace.fromJson(json["facilityHotelShowPlaceTo"]),
        dateTimeArrival: json["dateTimeArrival"] == null
            ? null
            : DateTime.parse(json["dateTimeArrival"]),
        dateTimeDeparture: json["dateTimeDeparture"] == null
            ? null
            : DateTime.parse(json["dateTimeDeparture"]),
        diff: json["diff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventId": eventId,
        "name": name,
        "eventCategoryId": eventCategoryId,
        "category": category?.toJson(),
        "facilityHotelShowPlaceFrom": facilityHotelShowPlaceFrom?.toJson(),
        "facilityHotelShowPlaceTo": facilityHotelShowPlaceTo?.toJson(),
        "dateTimeArrival":
            dateTimeArrival?.toIso8601String(),
        "dateTimeDeparture": dateTimeDeparture?.toIso8601String(),
        "diff": diff,
      };
}

class Category2 {
  Category2({
    this.id,
    this.eventCategoryId,
    this.eventId,
    this.nameRus,
    this.nameEng,
    this.nameAra,
    this.descriptionRus,
    this.descriptionEng,
    this.descriptionAra,
    this.code,
    this.color,
    this.priceRouble,
    this.priceDollar,
    this.isPress,
  });

  dynamic id;
  dynamic eventCategoryId;
  dynamic eventId;
  dynamic nameRus;
  dynamic nameEng;
  dynamic nameAra;
  dynamic descriptionRus;
  dynamic descriptionEng;
  dynamic descriptionAra;
  dynamic code;
  dynamic color;
  dynamic priceRouble;
  dynamic priceDollar;
  dynamic isPress;

  factory Category2.fromRawJson(String str) =>
      Category2.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category2.fromJson(Map<String, dynamic> json) => Category2(
        id: json["id"],
        eventCategoryId:
            json["eventCategoryId"],
        eventId: json["eventId"],
        nameRus: json["nameRus"],
        nameEng: json["nameEng"],
        nameAra: json["nameAra"],
        descriptionRus: json["descriptionRus"],
        descriptionEng: json["descriptionEng"],
        descriptionAra: json["descriptionAra"],
        code: json["code"],
        color: json["color"],
        priceRouble: json["priceRouble"],
        priceDollar: json["priceDollar"],
        isPress: json["isPress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventCategoryId": eventCategoryId,
        "eventId": eventId,
        "nameRus": nameRus,
        "nameEng": nameEng,
        "nameAra": nameAra,
        "descriptionRus": descriptionRus,
        "descriptionEng": descriptionEng,
        "descriptionAra": descriptionAra,
        "code": code,
        "color": color,
        "priceRouble": priceRouble,
        "priceDollar": priceDollar,
        "isPress": isPress,
      };
}

class FacilityHotelShowPlace {
  FacilityHotelShowPlace({
    this.id,
    this.hotelId,
    this.facilityId,
    this.showPlaceId,
    this.name,
    this.description,
    this.longitude,
    this.latitude,
    this.photo,
    this.distanceToAirport,
    this.address,
  });

  dynamic id;
  dynamic hotelId;
  dynamic facilityId;
  dynamic showPlaceId;
  dynamic name;
  dynamic description;
  dynamic longitude;
  dynamic latitude;
  dynamic photo;
  dynamic distanceToAirport;
  dynamic address;

  factory FacilityHotelShowPlace.fromRawJson(String str) =>
      FacilityHotelShowPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FacilityHotelShowPlace.fromJson(Map<String, dynamic> json) =>
      FacilityHotelShowPlace(
        id: json["id"],
        hotelId: json["hotelId"],
        facilityId: json["facilityId"],
        showPlaceId: json["showPlaceId"],
        name: json["name"],
        description: json["description"],
        longitude:
            json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        photo: json["photo"],
        distanceToAirport: json["distanceToAirport"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hotelId": hotelId,
        "facilityId": facilityId,
        "showPlaceId": showPlaceId,
        "name": name,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "photo": photo,
        "distanceToAirport":
            distanceToAirport,
        "address": address,
      };
}
