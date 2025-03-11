import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:http/http.dart' as http;
import 'package:eventssytem/cubit/auth/login_auth.dart';
import 'package:eventssytem/other/new_drops.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:path/path.dart';

class HotelsApi {
  Future<List<Hotel>> fetchHotels(String eventId) async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
      Uri.parse("${ConstantsClass.url}/api/v3/events/$eventId/hotels"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Hotel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching hotels');
    }
  }
}

class Hotel {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String description;
  final String imageUrl;
  final String website;

  Hotel({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
    required this.imageUrl,
    required this.website,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      website: json['website'] ?? '',
    );
  }
}

// class ProfilePageApi {
//   Future<ProfilePageModel> getProfilePage() async {
//     Map<String, String> headers = {"content-type": "application/json"};

//     if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
//       headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
//     }

//     print("accessToken ${AppAuth.accessToken}");

//     dynamic locale = await sharedPreferences.getString("locale");
//     String localeName = locale;

//     print(locale);

//     Map<String, String> body = {"langName": localeName.toUpperCase()};
//     body.addAll({"page": "1"});
//     body.addAll({"pageSize": "999999999"});

//     final response = await http.post(
//         Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/"),
//         headers: headers,
//         body: jsonEncode(body));

//     print("statusCode = ${response.statusCode}");

//     print("podborka = ${response.body}");

//     if (response.statusCode == 200) {
//       final dynamic cardJson = json.decode(response.body);
//       print(cardJson);
//       return ProfilePageModel.fromJson(cardJson);
//     } else {
//       throw Exception('Error fetching');
//     }
//   }
// }

// class ClaimPageApi {
//   Future<ClaimPageModel> getClaimPage(String id) async {
//     Map<String, String> headers = {"content-type": "application/json"};

//     if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
//       headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
//     }

//     dynamic locale = await sharedPreferences.getString("locale");
//     String localeName = locale;
//     Map<String, String> body = {"langName": localeName.toUpperCase()};

//     body.addAll({"id": id});

//     final response = await http.post(
//         Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/Values"),
//         headers: headers,
//         body: jsonEncode(body));

//     print("podborka = ${response.body}");

//     if (response.statusCode == 200) {
//       final dynamic cardJson = json.decode(response.body);
//       return ClaimPageModel.fromJson(cardJson);
//     } else {
//       throw Exception('Error fetching');
//     }
//   }
// }

// class DeleteClaimApi {
//   Future<String> delete(String id) async {
//     Map<String, String> headers = {"content-type": "application/json"};

//     if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
//       headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
//     }

//     Map<String, String> body = {"statementId": id};

//     final response = await http.post(
//         Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/Delete"),
//         headers: headers,
//         body: jsonEncode(body));

//     print("podborka = ${response.body}");

//     if (response.statusCode == 200) {
//       print("fffff");
//       var kk = jsonDecode(response.body);
//       print(kk["statusCode"]);
//       return kk["statusCode"];
//     } else {
//       throw Exception('error delete');
//     }
//   }
// }

// class UpdateClaimApi {
//   Future<String> update(
//       String statementId,
//       String templateId,
//       Map<String, Citizenship> selecteddrops,
//       Map<String, bool> selectedcheck,
//       Map<String, String> selectedradio,
//       Map<String, TextEditingController> textEditingControllers) async {
//     Map<String, String> headers = {"content-type": "application/json"};
//     if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
//       headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
//     }

//     dynamic locale = await sharedPreferences.getString("locale");
//     String localeName = locale;

//     Map<String, String> body = {"languageCode": localeName.toUpperCase()};
//     body.addAll({"statementId": statementId});
//     body.addAll({"templateId": templateId});
//     var response;

//     if (textEditingControllers != null) {
//       print("update");
//       for (var item in textEditingControllers.entries) {
//         body.addAll({"templateParameterCode": item.key});
//         body.addAll({"value": item.value.text});
//         response = await http.post(
//             Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/Edit"),
//             headers: headers,
//             body: jsonEncode(body));
//       }
//     }

//     if (selectedradio != null) {
//       print("update");
//       for (var item in selectedradio.entries) {
//         body.addAll({"templateParameterCode": item.key});
//         body.addAll({"value": item.value});
//         response = await http.post(
//             Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/Edit"),
//             headers: headers,
//             body: jsonEncode(body));
//       }
//     }

//     if (selectedcheck != null) {
//       print("update");
//       for (var item in selectedcheck.entries) {
//         body.addAll({"templateParameterCode": item.key});
//         body.addAll({"value": item.value.toString()});
//         response = await http.post(
//             Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/Edit"),
//             headers: headers,
//             body: jsonEncode(body));
//       }
//     }

//     if (selecteddrops != null) {
//       print("update");
//       for (var item in selecteddrops.entries) {
//         body.addAll({"templateParameterCode": item.key});
//         body.addAll({"value": item.value.id!});

//         print("${item.key}");
//         print("${item.value.id!}");

//         response = await http.post(
//             Uri.parse("https://service-ks.maksatlabs.ru/api/Statements/Edit"),
//             headers: headers,
//             body: jsonEncode(body));
//         print("body ${body}");
//         print("response.body ${response.body}");
//       }
//     }

//     if (response.statusCode == 200) {
//       return "ok";
//     } else {
//       throw Exception('error update');
//     }
//   }
// }

class EventProgramCubitApi {
  Future<List<EventProgramModel>> getConfig(
      {required List<int> eventTypeIds,
      required List<int> eventDateIds,
      List<int>? sphereIds,
      List<int>? eventFormat,
      bool vse = false}) async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    late Map<String, List<int>> body;

    if (vse == false) {
      body = {
        "eventTypeIds": eventTypeIds,
        "eventDateIds": eventDateIds,
      };

      if (sphereIds != null && sphereIds.isNotEmpty) {
        body.addAll({'sphereIds': sphereIds});
      }

      if (eventFormat != null && eventFormat.isNotEmpty) {
        body.addAll({'eventFormat': eventFormat});
      }
    } else {
      body = {};
    }

    print(jsonEncode(body));
    print("eventTypeIds = ${eventTypeIds[0]}");
    final response = await http.get(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program?Date=11-${eventDateIds[0]}-2024&PersonalProgramTypeId=${eventTypeIds[0]}&PageNumber=1&ItemOnPage=999999'),
        headers: headers,
        //body: jsonEncode(body)
        );

    print("response = ${response.body}");

    if (response.statusCode == 200) {
      
      final dynamic cardJsonb = json.decode(response.body);
      final List<dynamic> cardJson = cardJsonb['items'];
      print(cardJson);
      return cardJson.map((json) => EventProgramModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

class EventCulturProgramCubitApi {
  Future<List<EventCulturModel>> getConfig2() async {
    print("${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program");
    final response = await http.get(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    print("==response2 == ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> cardJson = json.decode(response.body);
      print(cardJson);
      return cardJson.map((json) => EventCulturModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

class SpeakersApi {
  Future<List<SpeakersModel>> getConfig3() async {
    final response = await http.get(
        Uri.parse('${ConstantsClass.url}/api/dictionary/speakers'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    print("==response2 == ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> cardJson = json.decode(response.body);
      print(cardJson);
      return cardJson.map((json) => SpeakersModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

class VotingApi {
  Future<String> setVoting(String voteId, String answerId) async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.post(
        Uri.parse(
            "${ConstantsClass.url}/api/events/${AppAuth.eventId}/votes/$voteId/participants/${AppAuth.participantId}/answers/$answerId"),
        headers: headers);

    print("response = ${response.statusCode}");
    print("response = ${response.body}");

    if (response.statusCode == 200) {
      return "ok";
    } else {
      throw Exception('Error voting set');
    }
  }

  Future<List<VotingPageModel>> getVoting() async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }
    Map<String, String> body = {"eventId": AppAuth.eventId ?? "8"};

    final response = await http.get(
      Uri.parse(
          "${ConstantsClass.url}/api/events/${AppAuth.eventId}/votes/active"),
      headers: headers,
    );

    print("podborka = ${response.statusCode}");
    print("podborka = ${response.body}");

    if (response.statusCode == 200) {
      final dynamic cardJson = json.decode(response.body);

      return votingPageModelFromJson(response.body);
    } else {
      throw Exception('Error voting get');
    }
  }
}

class ProfilePageApi {
  Future<ProfileOldModel> getProfilePage() async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
        Uri.parse(
            "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}"),
        headers: headers);

    print("podborka = ${response.body}");
    

    if (response.statusCode == 200) {
      return ProfileOldModel.fromRawJson(response.body);
    } else {
      throw Exception('Error getProfilePage');
    }
  }

  Future<List<dynamic>> getCountries() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/countries"),
        headers: headers);

    if (response.statusCode == 200) {
      //   dynamic cardJson = jsonDecode(response.body);
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getCountries');
    }
  }

  Future<List<dynamic>> getTitles() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/titles"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getTitles');
    }
  }

  Future<List<dynamic>> getSpheres() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/spheres"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getSpheres');
    }
  }

  Future<List<dynamic>> getMedia() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/mass-media-spheres"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getMedia');
    }
  }

  Future<List<dynamic>> getRusRegions() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/rusRegions"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getRusRegions');
    }
  }

  Future<List<dynamic>> getEventFormats() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/eventFormat"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getEventFormats');
    }
  }

  Future<List<dynamic>> getCompanies() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/companies"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => B2BCompanyModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getCompanies');
    }
  }
}

class FeedBackApi {
  Future<String> send(String title, String message, dynamic file) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    FormData? formData;
    Response response;

    try {
      String fileName = basename(file.path);
      formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      response = await Dio().post(
          "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/feedback?title=$title&message=$message",
          data: formData,
          options: Options(headers: headers));

      return "OK";
    } catch (e) {
      return "BAD";
    }
  }
}

class NewsApi {
  Future<List<NewsModel>> getNews() async {
    Map<String, String> headers = {"content-type": "application/json"};
    String lang = ConstantsClass.locale == "en" ? "2" : "1";

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/news?lang=$lang"),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> cardJson = json.decode(response.body);

      return cardJson.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

class UpdateClaimApi {
  Future<String> check(String firstNameEng, String lastNameEng) async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    try {
      Map<String, dynamic> body1 = {"firstNameEng": firstNameEng};
      body1.addAll({"lastNameEng": lastNameEng});

      dynamic response = await http.put(
          Uri.parse(
              "${ConstantsClass.url}/api/v2/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/personal-data"),
          headers: headers,
          body: jsonEncode(body1));

      if (jsonDecode(response.body)["En"] ==
          "PRF-1-2. Your personal and passport data has been approved") {
        return "true";
      } else {
        return "false";
      }
    } catch (e) {
      throw Exception('Error send UpdateClaimApi');
    }
  }

  Future<String> update(
      String firstNameRus,
      String lastNameRus,
      String patronymic,
      String firstNameEng,
      String lastNameEng,
      String comment,
      String organizationRus,
      organizationEng,
      positionRus,
      positionEng,
      postAddress,
      phoneNumber,
      email,
      webSite,
      birthday,
      passportNumber,
      issuedBy,
      issuedDate,
      validUntilDate,
      birthPlace,
      visa,
      arrivalStation,
      arrivalDateTime,
      arrivalFlightInfo,
      departureStation,
      departureDateTime,
      departureFlightInfo) async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    String checking = await check(firstNameEng, lastNameEng);

    try {
      if (checking == "false") {
        Map<String, dynamic> body1 = {
          "titleId": SelectedItemsEditProfile.strings["appeal"] ?? 0
        };
        body1.addAll({"firstNameRus": firstNameRus});
        body1.addAll({"lastNameRus": lastNameRus});
        body1.addAll({"patronymic": patronymic});
        body1.addAll({"firstNameEng": firstNameEng});
        body1.addAll({"lastNameEng": lastNameEng});
        body1.addAll({
          "photo": {"isNew": false}
        });
        body1.addAll(
            {"genderId": SelectedItemsEditProfile.strings["genderId"] ?? 0});

        body1.addAll({
          "residenceId": SelectedItemsEditProfile.strings["residenceId"] ?? 0
        });

        if (SelectedItemsEditProfile.strings["rusRegionId"] == null) {
          body1.addAll({
            "rusRegionId": SelectedItemsEditProfile.strings["rusRegionId"] ?? 0
          });
        }

        body1.addAll({"comment": comment});

        dynamic resp1 = await http.put(
            Uri.parse(
                "${ConstantsClass.url}/api/v2/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/personal-data"),
            headers: headers,
            body: jsonEncode(body1));

        print("resp1 = ${resp1.body}");
      }

      Map<String, dynamic> body2 = {"organizationRus": organizationRus};
      body2.addAll({"organizationEng": organizationEng});
      body2.addAll({"positionRus": positionRus});
      body2.addAll({"positionEng": positionEng});
      body2.addAll(
          {"sphereId": SelectedItemsEditProfile.strings["sphereId"] ?? 0});
      body2.addAll({
        "countryCompanyHeadId":
            SelectedItemsEditProfile.strings["countryCompanyHeadId"] ?? 0
      });
      body2.addAll({"postAddress": postAddress});

      dynamic resp2 = await http.put(
          Uri.parse(
              "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/company"),
          headers: headers,
          body: jsonEncode(body2));

      Map<String, dynamic> body3 = {"phoneNumber": phoneNumber};
      body3.addAll({"email": email});
      body3.addAll({"webSite": webSite});
      dynamic resp3 = await http.put(
          Uri.parse(
              "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/contact"),
          headers: headers,
          body: jsonEncode(body3));

      if (checking == "false") {
        Map<String, dynamic> body4 = {
          "citizenshipId":
              SelectedItemsEditProfile.strings["citizenshipId"] ?? 0
        };
        body4.addAll({"birthday": birthday});
        body4.addAll({"passportNumber": passportNumber});
        body4.addAll({"issuedBy": issuedBy});
        body4.addAll({"issuedDate": issuedDate});
        body4.addAll({"validUntilDate": validUntilDate});
        body4.addAll({"birthPlace": birthPlace});
        dynamic resp4 = await http.put(
            Uri.parse(
                "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/passport"),
            headers: headers,
            body: jsonEncode(body4));

        print("resp4 = ${resp4.body}");
      }

      Map<String, dynamic> body5 = {"visa": visa};

      dynamic resp5 = await http.put(
          Uri.parse(
              "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/visa"),
          headers: headers,
          body: jsonEncode(body5));

      Map<String, dynamic> body6 = {"arrivalStation": arrivalStation};
      body6.addAll({"arrivalDateTime": arrivalDateTime});
      body6.addAll({"arrivalFlightInfo": arrivalFlightInfo});
      body6.addAll({"departureStation": departureStation});
      body6.addAll({"departureDateTime": departureDateTime});
      body6.addAll({"departureFlightInfo": departureFlightInfo});

      dynamic resp6 = await http.put(
          Uri.parse(
              "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}/arrival-departure"),
          headers: headers,
          body: jsonEncode(body6));

      print("resp2 = ${resp2.body}");
      print("resp3 = ${resp3.body}");

      print("resp5 = ${resp5.body}");
      print("resp6 = ${resp6.body}");

      return "OK";
    } catch (e) {
      throw Exception('Error send UpdateClaimApi');
    }
  }
}

class MapPageApi {
  Future<List<dynamic>> getfacilities() async {
    Map<String, String> headers = {"content-type": "text/plain"};

    final response = await http.get(
        Uri.parse(
            "${ConstantsClass.url}/api/v3/events/${AppAuth.eventId}/facilities"),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic rr = jsonDecode(response.body);

      return rr
          .map((json) => MapUniversalModel.fromJson(json, maplocationf))
          .toList();
    } else {
      throw Exception('Error getCountries');
    }
  }

  Future<List<dynamic>> gethotels() async {
    Map<String, String> headers = {"content-type": "text/plain"};

    final response = await http.get(
        Uri.parse(
            "${ConstantsClass.url}/api/v3/events/${AppAuth.eventId}/hotels"),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic rr = jsonDecode(response.body);

      return rr
          .map((json) => MapUniversalModel.fromJson(json, maplocationh))
          .toList();
    } else {
      throw Exception('Error getCountries');
    }
  }

  Future<List<dynamic>> getshowplaces() async {
    Map<String, String> headers = {"content-type": "text/plain"};

    final response = await http.get(
        Uri.parse(
            "${ConstantsClass.url}/api/v3/events/${AppAuth.eventId}/showplaces"),
        headers: headers);

    if (response.statusCode == 200) {
      dynamic rr = jsonDecode(response.body);

      return rr
          .map((json) => MapUniversalModel.fromJson(json, maplocations))
          .toList();
    } else {
      throw Exception('Error getCountries');
    }
  }
}

class MaterialsApi {
  Future<List<dynamic>> getMaterials() async {
    Map<String, String> headers = {"content-type": "text/plain"};

    final response = await http.get(
      Uri.parse(
          "${ConstantsClass.url}/api/v2/events/${AppAuth.eventId}/materials"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      dynamic cardJson = json.decode(response.body);

      return cardJson.map((json) {
        return MaterialsModel.fromJson(json);
      }).toList();
    } else {
      throw Exception('Error getMaterials');
    }
  }
}

class EventProgramByIdApi {
  Future<EventProgramModel> getone(String id) async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }
print('${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program/$id');
    final response = await http.get(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program/$id'),
        headers: headers);

    if (response.statusCode == 200) {
      final dynamic cardJson = json.decode(response.body);
          print(response.body);
      return EventProgramModel.fromJson(cardJson);
    } else {
      throw Exception('Error EventProgramByIdApi');
    }
  }
}

class EventProgramCategoryApi {
  Future<List<dynamic>> getCategory() async {
    Map<String, String> headers = {"content-type": "application/json"};

    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/eventTypes"),
        headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map((json) => UniversalModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getCategory');
    }
  }
}

class EventProgramLiveApi {
  Future<List<EventProgramModel>> getLive() async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/event-program-live'),
        headers: headers);

    print("object====${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> cardJson = json.decode(response.body);
      return cardJson.map((json) => EventProgramModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

class PersonalscheduleApi {
  Future<List<EventProgramModel>> getPSH() async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    print("state==Вызвал!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

    final response = await http.get(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/participant/${AppAuth.participantId}/personal-program'),
        headers: headers);

    print("response.body=${response.body}");
    print("response.statusCode=${response.statusCode}");
    if (response.statusCode == 200) {
      final List<dynamic> cardJson = json.decode(response.body);
      return cardJson.map((json) => EventProgramModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }

  Future<dynamic> addPSH(String eventProgramId) async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.post(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program/$eventProgramId/participants/${AppAuth.participantId}'),
        headers: headers);

    if (response.statusCode == 200) {
      return "Ok";
    } else {
      throw Exception('Error addPSH');
    }
  }

  Future<dynamic> delPSH(String eventProgramId) async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.delete(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/personal-program/$eventProgramId/participants/${AppAuth.participantId}'),
        headers: headers);

    if (response.statusCode == 200) {
      return "Ok";
    } else {
      throw Exception('Error addPSH');
    }
  }
}

class B2bListApi {
  Future<B2BListModel> getList(
      {String? name = "",
      int? countryId,
      String? companyName = "",
      String? sphereName}) async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    Map<String, dynamic> body = {
      "sorting": {"field": "", "byDesc": true},
      "name": name,
      "positionName": "",
      "СountryId": countryId,
      "companyName": companyName,
      "sphereName": sphereName
    };

    print(jsonEncode(body));

    final response = await http.post(
        Uri.parse(
            '${ConstantsClass.url}/api/b2b/events/${AppAuth.eventId}/participants?PageNumber=1&ItemOnPage=50000'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      final b2BListModel = B2BListModel.fromRawJson(response.body);
      print("b2BListModel $b2BListModel");
      return b2BListModel;
    } else {
      throw Exception('Error getList');
    }
  }
}

class B2bSendApi {
  Future<String> send({required String id, required String message}) async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }
    Map<String, dynamic> body = {"message": message};
    final response = await http.post(
        Uri.parse(
            '${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/$id/b2b/send-message'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      return "OK";
    } else {
      return "BAD";
    }
  }
}

class PartnersApi {
  Future<List<dynamic>> getPartners() async {
    Map<String, String> headers = {"content-type": "application/json"};
    String lang = ConstantsClass.locale == "en" ? "2" : "1";
    final response = await http.get(
        Uri.parse("${ConstantsClass.url}/api/dictionary/partners?lang=$lang"),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      final dynamic partnersModel = json.decode(response.body);
      return partnersModel.map((json) => PartnersModel.fromJson(json)).toList();
    } else {
      throw Exception('Error getPartners');
    }
  }
}

class QrApi {
  Future<String> getqrprint() async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
        Uri.parse(
            '${ConstantsClass.url}/api/participant/${AppAuth.participantId}/qrcode'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["linkToParticipant"];
    } else {
      return "BAD";
    }
  }

  Future<String> getqrgo() async {
    Map<String, String> headers = {"content-type": "application/json"};
    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(Uri.parse('${ConstantsClass.url}/getAcmQr'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "BAD";
    }
  }
}

class TransportApi {
  Future<List<dynamic>> getTransport() async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
        Uri.parse(
            "${ConstantsClass.url}/api/shuttle/events/${AppAuth.eventId}/shuttles"),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      final dynamic transportModel = json.decode(response.body);
      return transportModel
          .map((json) => TransportModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getTransport');
    }
  }
}

class CheckDostupApi {
  Future<bool> checkPay() async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
        Uri.parse('${ConstantsClass.url}/api/acr-status-two'),
        headers: headers);

    if (response.statusCode == 200) {
      if (response.body == "2") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkCategotyId() async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.get(
        Uri.parse(
            "${ConstantsClass.url}/api/events/${AppAuth.eventId}/participants/${AppAuth.participantId}"),
        headers: headers);

    dynamic id = jsonDecode(response.body)["category"]["id"];

    if (response.statusCode == 200) {
      switch (id.toString()) {
        case "1":
          return true;
        case "2":
          return true;
        case "3":
          return true;
        case "11":
          return true;
        default:
          return false;
      }
    } else {
      return false;
    }
  }
}
