import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eventssytem/models/b2b_model.dart'; 

class B2bRepository {
  final String baseUrl = 'https://sprouts.maksat.pro/api';

  // Получение слотов встреч
  Future<List<MeetingSlot>> getTimeslots(String eventId, String participantId, String day) async {
  final url = '$baseUrl/b2b/events/$eventId/participants/$participantId/timeslots?day=$day';
  print('Отправка запроса на $url');
  final response = await http.get(Uri.parse(url));
  print('Код ответа: ${response.statusCode}');
  print('CЛОТЫЫ: ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => MeetingSlot.fromJson(json)).toList();
  } else {
    throw Exception('Ошибка при загрузке слотов: ${response.statusCode}');
  }
}
Future<List<Participant>> fetchParticipantsWithFilters({
  required String eventId,
  required String participantId,
  int pageNumber = 1,
  int itemsPerPage = 10,
  List<int>? competenceIds,
  String? commonFilter, // добавили параметр commonFilter
}) async {
  // Формируем параметры запроса
  final queryParameters = {
    'PageNumber': pageNumber.toString(),
    'ItemOnPage': itemsPerPage.toString(),
    if (competenceIds != null && competenceIds.isNotEmpty)
      'CompetenceIds': competenceIds.map((id) => id.toString()).toList(),
    if (commonFilter != null && commonFilter.isNotEmpty)
      'CommonFilter': commonFilter, // добавляем commonFilter в параметры
  };

  final uri = Uri.parse(
    '$baseUrl/b2b/events/$eventId/meetings/participant/$participantId',
  ).replace(queryParameters: queryParameters);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    // Разбираем JSON-ответ
    final jsonResponse = json.decode(response.body);

    // Проверяем, есть ли ключ "items" в ответе
    if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('items')) {
      List<dynamic> items = jsonResponse['items'];
      return items.map((json) => Participant.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected JSON format');
    }
  } else {
    print('Error response: ${response.body}');
    throw Exception('Failed to load participants: ${response.statusCode}');
  }
}


//предлогаю нвоое время
Future<void> suggestNewMeetingTime({
    required String eventId,
    required String participantId,
    required String meetingId,
    required String timeslotId,
    required DateTime newDateTimeStart,
    required DateTime newDateTimeEnd,
    required int meetingStatusId,
    required String meetingStatusName,
    required String participant,
    required String participantOrganization,
    required String meetingTheme,
    required bool isNeedTranslator,
    required bool isNeedPhotograph,
    required String languages,
    required bool isYouSender,
    required bool isYouTimeChanger,
  }) async {
    final url = Uri.parse(
      '$baseUrl/b2b/events/$eventId/participant/$participantId/meetings/$meetingId/timeslot/$timeslotId',
    );

    // Construct the request body
    final body = {
      "id": int.parse(meetingId),
      "meetingStatusId": meetingStatusId,
      "meetingStatusName": meetingStatusName,
      "participant": participant,
      "participantOrganization": participantOrganization,
      "dateTimeStart": newDateTimeStart.toIso8601String(),
      "dateTimeEnd": newDateTimeEnd.toIso8601String(),
      "table": null,  // Assuming this is left null unless specified
      "meetingTheme": meetingTheme,
      "isNeedTranlator": isNeedTranslator,
      "isNeedPhotograph": isNeedPhotograph,
      "languages": languages,
      "isYouSender": isYouSender,
      "isYouTimeChanger": isYouTimeChanger,
      "newDateTimeStart": newDateTimeStart.toIso8601String(),
      "newDateTimeEnd": newDateTimeEnd.toIso8601String(),
    };

    try {
      // Send the PUT request to update the meeting time
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        print("Meeting time change request was successful");
      } else {
        print("Failed to change meeting time: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception('Failed to change meeting time');
      }
    } catch (e) {
      print("Error during the request: $e");
      throw Exception('Error during the meeting time change request');
    }
  }

  


//отправляем данные на бэк о создании приглашения 
Future<void> createMeeting({
    required String eventId,
    required String participantId,
    required int invitedParticipantId,
    required int timeslotId,
    required int meetingThemeId,
    required bool needTranslator,
    required bool needPhotograph,
    required List<int> languageIds,
  }) async {
    final url = Uri.parse('$baseUrl/b2b/events/$eventId/participants/$participantId/meeting');

    final body = {
      'participantId': invitedParticipantId,
      'timeslotId': timeslotId,
      'meetingThemeId': meetingThemeId,
      'isNeedTranlator': needTranslator,
      'isNeedPhotograph': needPhotograph,
      'languageIds': languageIds,
    };

    print('Отправка POST запроса на $url');
    print('Заголовки: ${{
      'Content-Type': 'application/json',
    }}');
    print('Тело запроса: ${jsonEncode(body)}');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Meeting created successfully");
    } else {
      print("Failed to create meeting: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to create meeting');
    }
  }
Future<List<TimeslotModel>> getTimeslotsForInvitation(
    String eventId, String myParticipantId, String invitedParticipantId, String day) async {
    final url = '$baseUrl/b2b/events/$eventId/timeslots/participant/$myParticipantId/$invitedParticipantId?day=$day';
    final response = await http.get(Uri.parse(url));
    print('Код ответа: ${response.statusCode}');
    print('Ответ на слоты: ${response.body}');
    print(myParticipantId);
    print(invitedParticipantId);
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TimeslotModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load timeslots');
    }
  }
  //список участников для б2б
  Future<List<Participant>> fetchParticipants(String eventId, String participantId) async {
    final url = '$baseUrl/b2b/events/$eventId/meetings/participant/$participantId';
    
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body)['items'];
      return items.map((json) => Participant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load participants');
    }
  }
  Future<void> submitFeedback({
  required String eventId,
  required String participantId,
  required String meetingId,
  required bool isHappen,
  required bool isUseful,
  required String conclusion,
  required String feedback,
}) async {
  final url = Uri.parse('$baseUrl/b2b/events/$eventId/participants/$participantId/meeting/feedback');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "meetingId": int.parse(meetingId),
      "isHappen": isHappen,
      "isUseful": isUseful,
      "conclusion": conclusion,
      "feedback": feedback,
      
    }),
    
  );
  print('Sending feedback data: ${jsonEncode({
  "meetingId": int.parse(meetingId),
  "isHappen": isHappen,
  "isUseful": isUseful,
  "conclusion": conclusion,
  "feedback": feedback,
})}');

  if (response.statusCode != 200) {
    throw Exception('Failed to submit feedback');
  }
}
  
  //получение данных для подробной встречи 
  Future<DetailMeeting> fetchMeetingDetails(String eventId, String participantId, String meetingId) async {
  final url = '$baseUrl/b2b/events/$eventId/participants/$participantId/meeting/$meetingId';
  print('Запрос данных встречи по URL: $url');

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('Успешно получены данные: ${response.body}');
    return DetailMeeting.fromJson(jsonDecode(response.body));
  } else {
    print('Ошибка при загрузке данных встречи: ${response.statusCode}, Ответ: ${response.body}');
    throw Exception('Ошибка при загрузке данных встречи: ${response.statusCode}');
  }
}


  // Получение приглашений
  Future<List<Invitation>> getInvitations(String eventId, String participantId) async {
    final url = '$baseUrl/b2b/events/$eventId/participants/$participantId/meetings';
    final response = await http.get(Uri.parse(url));
    print('Отправка запроса на $url');
    print('Код ответа: ${response.statusCode}');
    print('Ответ сервера: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Invitation.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при загрузке приглашений: ${response.statusCode}');
    }
  }

  // Получение данных конкретной встречи
  Future<Meeting> getMeeting(String eventId, String participantId, String meetingId) async {
    final url = '$baseUrl/b2b/events/$eventId/participants/$participantId/meeting/$meetingId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Meeting.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка при загрузке встречи: ${response.statusCode}');
    }
  }

  

  // Обновление статуса встречи (принятие/отклонение)
  Future<void> updateMeetingStatus({
  required String eventId,
  required String participantId,
  required String meetingId,
  required int statusId,
}) async {
  final url = '$baseUrl/b2b/events/$eventId/participant/$participantId/meetings/$meetingId/status/$statusId';
  
  final response = await http.put(Uri.parse(url));
    print('Отправка запроса на $url');
    print('Код ответа: ${response.statusCode}');
    print('Ответ сервера: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('Ошибка при обновлении статуса встречи: ${response.statusCode}');
  }
}


  // Получение доступных столов для слота
  Future<List<TableModel>> getTables(String eventId, String timeslotId) async {
    final url = '$baseUrl/b2b/events/$eventId/timeslots/$timeslotId/tables';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TableModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при загрузке столов: ${response.statusCode}');
    }
  }

  // Получение тем для встречи
  Future<List<ThemeModel>> getMeetingThemes() async {
    final url = '$baseUrl/dictionary/meetingThemes';
    final response = await http.get(Uri.parse(url));
    print('dfgbdfkjvosnfviudfiuvdsocoudsfsfsfsfsfsf');
    print('Ответ сервера: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ThemeModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при загрузке тем: ${response.statusCode}');
    }
  }



  Future<List<LanguageModel>> getLanguages() async {
    final url = '$baseUrl/dictionary/languages';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => LanguageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load languages');
    }
  }

  // Получение статусов для встречи
  Future<List<StatusModel>> getMeetingStatuses() async {
    final url = '$baseUrl/meetingStatuses';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => StatusModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при загрузке статусов: ${response.statusCode}');
    }
  }

  // Обновление доступности участника
  Future<void> updateParticipantAvailability(String eventId, String participantId, bool available) async {
    final url = '$baseUrl/b2b/events/$eventId/participants/$participantId/meeting/available';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'available': available}), // отправляем только состояние доступности
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при обновлении доступности участника: ${response.statusCode}');
    }
  }

  // Подтверждение аккредитации
  Future<void> confirmAccreditation(String eventId, String participantId) async {
    final url = '$baseUrl/acr/events/$eventId/participants/$participantId/selfchange';
    final response = await http.put(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Ошибка при подтверждении аккредитации: ${response.statusCode}');
    }
  }

  // Сохранение результата опроса о встрече
  Future<void> saveMeetingFeedback(
    String eventId,
    String participantId,
    Map<String, dynamic> feedbackData,
  ) async {
    final url = '$baseUrl/b2b/events/$eventId/participants/$participantId/meeting/feedback';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(feedbackData), // отправляем только данные обратной связи
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при сохранении отзыва о встрече: ${response.statusCode}');
    }
  }
}
