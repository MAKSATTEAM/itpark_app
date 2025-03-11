import 'dart:convert';


// Модель слота встречи (Timeslot)
class MeetingSlot {
  final int _id;
  final int? _meetingId; // Добавляем поле для meetingId
  final DateTime _startTime;
  final DateTime _endTime;
  final String _table;
  final bool _isAvailable;
  final String? _participant; 
  final String? _participantOrganization; 

  MeetingSlot({
    required int id,
    int? meetingId, // Опциональный параметр для meetingId
    required DateTime startTime,
    required DateTime endTime,
    required String table,
    required bool isAvailable,
    String? participant,
    String? participantOrganization,
  })  : _id = id,
        _meetingId = meetingId, // Инициализируем meetingId
        _startTime = startTime,
        _endTime = endTime,
        _table = table,
        _isAvailable = isAvailable,
        _participant = participant,
        _participantOrganization = participantOrganization;

  int get id => _id;
  int? get meetingId => _meetingId; // Геттер для meetingId
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get table => _table;
  bool get isAvailable => _isAvailable;
  String? get participant => _participant;
  String? get participantOrganization => _participantOrganization;

  // Factory method для парсинга JSON
  factory MeetingSlot.fromJson(Map<String, dynamic> json) {
    return MeetingSlot(
      id: json['id'] ?? 0,
      meetingId: json['meetingId'], // Считываем meetingId из JSON
      startTime: DateTime.parse(json['dateTimeStart'] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(json['dateTimeEnd'] ?? DateTime.now().toIso8601String()),
      table: json['table'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
      participant: json['participant'] ?? '',
      participantOrganization: json['participantOrganization'] ?? '',
    );
  }

  // Метод для преобразования в JSON (опционально, если нужно)
  Map<String, dynamic> toJson() => {
        'id': _id,
        'meetingId': _meetingId, // Добавляем meetingId в JSON
        'dateTimeStart': _startTime.toIso8601String(),
        'dateTimeEnd': _endTime.toIso8601String(),
        'table': _table,
        'isAvailable': _isAvailable,
        'participant': _participant,
        'participantOrganization': _participantOrganization,
      };
}



// class MeetingSlot {
//   final String id;
//   final DateTime startTime;
//   final DateTime endTime;
//   final String location;
//   final int availableTables;
//   final int totalTables;

//   MeetingSlot({
//     required this.id,
//     required this.startTime,
//     required this.endTime,
//     required this.location,
//     required this.availableTables,
//     required this.totalTables,
//   });

//   factory MeetingSlot.fromJson(Map<String, dynamic> json) {
//     return MeetingSlot(
//       id: json['id'],
//       startTime: DateTime.parse(json['startTime']),
//       endTime: DateTime.parse(json['endTime']),
//       location: json['location'],
//       availableTables: json['availableTables'],
//       totalTables: json['totalTables'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'startTime': startTime.toIso8601String(),
//         'endTime': endTime.toIso8601String(),
//         'location': location,
//         'availableTables': availableTables,
//         'totalTables': totalTables,
//       };
// }
// Приглашения участников 
class Participant {
  final int id;
  final String firstNameRus;
  final String lastNameRus;
  final String? patronymic;
  final String firstNameEng;
  final String lastNameEng;
  final String organizationRus;
  final String organizationEng;
  final String? competenceName;
  final String? positionRus;  
  final String? positionEng;  
  final String? photo;        

  Participant({
    required this.id,
    required this.firstNameRus,
    required this.lastNameRus,
    this.patronymic,
    required this.firstNameEng,
    required this.lastNameEng,
    required this.organizationRus,
    required this.organizationEng,
    this.competenceName,
    this.positionRus,  
    this.positionEng,  
    this.photo,        
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      firstNameRus: json['firstNameRus'],
      lastNameRus: json['lastNameRus'],
      patronymic: json['patronymic'],
      firstNameEng: json['firstNameEng'],
      lastNameEng: json['lastNameEng'],
      organizationRus: json['organizationRus'],
      organizationEng: json['organizationEng'],
      competenceName: json['competenceName'],
      positionRus: json['positionRus'],  
      positionEng: json['positionEng'], 
      photo: json['photo'],              
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstNameRus': firstNameRus,
      'lastNameRus': lastNameRus,
      'patronymic': patronymic,
      'firstNameEng': firstNameEng,
      'lastNameEng': lastNameEng,
      'organizationRus': organizationRus,
      'organizationEng': organizationEng,
      'competenceName': competenceName,
      'positionRus': positionRus,
      'positionEng': positionEng,
      'photo': photo,
    };
  }
}


// Модель приглашения (Invitation)
class Invitation {
  final int _id;
  final int _meetingStatusId;
  final String _meetingStatusName;
  final String _participant;
  final String _participantOrganization;
  final DateTime _meetingTimeStart;
  final DateTime _meetingTimeEnd;
  final String _table;
  final String _meetingTheme;
  final bool _isNeedTranslator;
  final bool _isNeedPhotograph;
  final String _languages;
  final bool _isYouSender;
  final bool _isYouTimeChanger;
  final DateTime? _newDateTimeStart;
  final DateTime? _newDateTimeEnd;
  final bool _isFeedbackFilled;  // New field

  Invitation({
    required int id,
    required int meetingStatusId,
    required String meetingStatusName,
    required String participant,
    required String participantOrganization,
    required DateTime meetingTimeStart,
    required DateTime meetingTimeEnd,
    required String table,
    required String meetingTheme,
    required bool isNeedTranslator,
    required bool isNeedPhotograph,
    required String languages,
    required bool isYouSender,
    required bool isYouTimeChanger,
    DateTime? newDateTimeStart,
    DateTime? newDateTimeEnd,
    required bool isFeedbackFilled, // New parameter in constructor
  })  : _id = id,
        _meetingStatusId = meetingStatusId,
        _meetingStatusName = meetingStatusName,
        _participant = participant,
        _participantOrganization = participantOrganization,
        _meetingTimeStart = meetingTimeStart,
        _meetingTimeEnd = meetingTimeEnd,
        _table = table,
        _meetingTheme = meetingTheme,
        _isNeedTranslator = isNeedTranslator,
        _isNeedPhotograph = isNeedPhotograph,
        _languages = languages,
        _isYouSender = isYouSender,
        _isYouTimeChanger = isYouTimeChanger,
        _newDateTimeStart = newDateTimeStart,
        _newDateTimeEnd = newDateTimeEnd,
        _isFeedbackFilled = isFeedbackFilled; // Assign new field

  int get id => _id;
  int get meetingStatusId => _meetingStatusId;
  String get meetingStatusName => _meetingStatusName;
  String get participant => _participant;
  String get participantOrganization => _participantOrganization;
  DateTime get meetingTimeStart => _meetingTimeStart;
  DateTime get meetingTimeEnd => _meetingTimeEnd;
  String get table => _table;
  String get meetingTheme => _meetingTheme;
  bool get isNeedTranslator => _isNeedTranslator;
  bool get isNeedPhotograph => _isNeedPhotograph;
  String get languages => _languages;
  bool get isYouSender => _isYouSender;
  bool get isYouTimeChanger => _isYouTimeChanger;
  DateTime? get newDateTimeStart => _newDateTimeStart;
  DateTime? get newDateTimeEnd => _newDateTimeEnd;
  bool get isFeedbackFilled => _isFeedbackFilled; // New getter

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'] ?? 0,
      meetingStatusId: json['meetingStatusId'] ?? 0,
      meetingStatusName: json['meetingStatusName'] ?? 'Статус неизвестен',
      participant: json['participant'] ?? 'Имя неизвестно',
      participantOrganization: json['participantOrganization'] ?? 'Организация неизвестна',
      meetingTimeStart: DateTime.parse(json['dateTimeStart'] ?? DateTime.now().toIso8601String()),
      meetingTimeEnd: DateTime.parse(json['dateTimeEnd'] ?? DateTime.now().toIso8601String()),
      table: json['table'] ?? 'Не указано',
      meetingTheme: json['meetingTheme'] ?? 'Тема неизвестна',
      isNeedTranslator: json['isNeedTranlator'] ?? false,
      isNeedPhotograph: json['isNeedPhotograph'] ?? false,
      languages: json['languages'] ?? 'Не указано',
      isYouSender: json['isYouSender'] ?? false,
      isYouTimeChanger: json['isYouTimeChanger'] ?? false,
      newDateTimeStart: json['newDateTimeStart'] != null
          ? DateTime.parse(json['newDateTimeStart'])
          : null,
      newDateTimeEnd: json['newDateTimeEnd'] != null
          ? DateTime.parse(json['newDateTimeEnd'])
          : null,
      isFeedbackFilled: json['isFeedbackFilled'] ?? false, // Parse new field
    );
  }
}


class DetailMeeting {
  final int id;
  final int meetingStatusId;
  final String meetingStatusName;
  final String participant;
  final String participantOrganization;
  final DateTime dateTimeStart;
  final DateTime dateTimeEnd;
  final String? table;
  final String meetingTheme;
  final bool isNeedTranslator;
  final bool isNeedPhotograph;
  final String languages;
  final bool isYouSender;
  final bool isYouTimeChanger;
  final DateTime? newDateTimeStart;
  final DateTime? newDateTimeEnd;
  final bool isFeedbackFilled; // New field

  DetailMeeting({
    required this.id,
    required this.meetingStatusId,
    required this.meetingStatusName,
    required this.participant,
    required this.participantOrganization,
    required this.dateTimeStart,
    required this.dateTimeEnd,
    this.table,
    required this.meetingTheme,
    required this.isNeedTranslator,
    required this.isNeedPhotograph,
    required this.languages,
    required this.isYouSender,
    required this.isYouTimeChanger,
    this.newDateTimeStart,
    this.newDateTimeEnd,
    required this.isFeedbackFilled, // New parameter in constructor
  });

  factory DetailMeeting.fromJson(Map<String, dynamic> json) {
    return DetailMeeting(
      id: json['id'],
      meetingStatusId: json['meetingStatusId'],
      meetingStatusName: json['meetingStatusName'],
      participant: json['participant'],
      participantOrganization: json['participantOrganization'],
      dateTimeStart: DateTime.parse(json['dateTimeStart']),
      dateTimeEnd: DateTime.parse(json['dateTimeEnd']),
      table: json['table'],
      meetingTheme: json['meetingTheme'],
      isNeedTranslator: json['isNeedTranlator'],
      isNeedPhotograph: json['isNeedPhotograph'],
      languages: json['languages'],
      isYouSender: json['isYouSender'],
      isYouTimeChanger: json['isYouTimeChanger'],
      newDateTimeStart: json['newDateTimeStart'] != null
          ? DateTime.parse(json['newDateTimeStart'])
          : null,
      newDateTimeEnd: json['newDateTimeEnd'] != null
          ? DateTime.parse(json['newDateTimeEnd'])
          : null,
      isFeedbackFilled: json['isFeedbackFilled'] ?? false, // Parse new field
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'meetingStatusId': meetingStatusId,
        'meetingStatusName': meetingStatusName,
        'participant': participant,
        'participantOrganization': participantOrganization,
        'dateTimeStart': dateTimeStart.toIso8601String(),
        'dateTimeEnd': dateTimeEnd.toIso8601String(),
        'table': table,
        'meetingTheme': meetingTheme,
        'isNeedTranlator': isNeedTranslator,
        'isNeedPhotograph': isNeedPhotograph,
        'languages': languages,
        'isYouSender': isYouSender,
        'isYouTimeChanger': isYouTimeChanger,
        'newDateTimeStart': newDateTimeStart?.toIso8601String(),
        'newDateTimeEnd': newDateTimeEnd?.toIso8601String(),
        'isFeedbackFilled': isFeedbackFilled, // Add new field to JSON output
      };
}



// Модель встречи (Meeting)
class Meeting {
  final String id;
  final String participantName;
  final String companyName;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String status;

  Meeting({
    required this.id,
    required this.participantName,
    required this.companyName,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.status,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'],
      participantName: json['participantName'],
      companyName: json['companyName'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'participantName': participantName,
        'companyName': companyName,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'location': location,
        'status': status,
      };
}
class LanguageModel {
  final int id;
  final String name;

  LanguageModel({
    required this.id,
    required this.name,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
class TimeslotModel {
  final int id;
  final String nameRus;
  final String nameEng;
  final String? nameChi; 
  final DateTime dateTimeStart;
  final DateTime dateTimeEnd;
  final int? personalProgramId;

  TimeslotModel({
    required this.id,
    required this.nameRus,
    required this.nameEng,
    this.nameChi, 
    required this.dateTimeStart,
    required this.dateTimeEnd,
    this.personalProgramId, 
  });

  factory TimeslotModel.fromJson(Map<String, dynamic> json) {
    return TimeslotModel(
      id: json['id'],
      nameRus: json['nameRus'],
      nameEng: json['nameEng'],
      nameChi: json['nameChi'], 
      dateTimeStart: DateTime.parse(json['dateTimeStart']),
      dateTimeEnd: DateTime.parse(json['dateTimeEnd']),
      personalProgramId: json['personalProgramId'], 
    );
  }

  String get formattedTime => 
      '${dateTimeStart.hour}:${dateTimeStart.minute.toString().padLeft(2, '0')} - '
      '${dateTimeEnd.hour}:${dateTimeEnd.minute.toString().padLeft(2, '0')}';
}


// Модель стола для встречи (TableModel)
class TableModel {
  final String id;
  final int tableNumber;
  final bool isAvailable;

  TableModel({
    required this.id,
    required this.tableNumber,
    required this.isAvailable,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      tableNumber: json['tableNumber'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tableNumber': tableNumber,
        'isAvailable': isAvailable,
      };
}

// Модель темы встречи (ThemeModel)
class ThemeModel {
  final int id;
  final String nameRus;
  final String nameEng;

  ThemeModel({
    required this.id,
    required this.nameRus,
    required this.nameEng,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'],
      nameRus: json['nameRus'] ?? 'Без названия',
      nameEng: json['nameEng'] ?? 'No name',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nameRus': nameRus,
        'nameEng': nameEng,
      };
}


// Модель статуса встречи (StatusModel)
class StatusModel {
  final String id;
  final String statusName;

  StatusModel({
    required this.id,
    required this.statusName,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      statusName: json['statusName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'statusName': statusName,
      };
}

// Модель для обратной связи (FeedbackModel)
class FeedbackModel {
  final String id;
  final String comments;
  final int rating;

  FeedbackModel({
    required this.id,
    required this.comments,
    required this.rating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      comments: json['comments'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'comments': comments,
        'rating': rating,
      };
}


String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

FeedbackModel feedbackModelFromJson(String str) => FeedbackModel.fromJson(json.decode(str));
