import 'package:equatable/equatable.dart';
import 'package:eventssytem/models/b2b_model.dart'; // Модели данных

// Базовый класс для всех состояний B2B
abstract class B2bState extends Equatable {
  @override
  List<Object> get props => [];
}

// Начальное состояние
class B2bInitial extends B2bState {}

// Состояние загрузки (вызов API в процессе)
class B2bLoading extends B2bState {}

// Состояние при успешной загрузке таймслотов
class B2bLoadedTimeslots extends B2bState {
  final List<MeetingSlot> timeslots;

  B2bLoadedTimeslots(this.timeslots);

  @override
  List<Object> get props => [timeslots];
}

// Состояние при успешной загрузке приглашений
class B2bLoadedInvitations extends B2bState {
  final List<Invitation> invitations;

  B2bLoadedInvitations(this.invitations);

  @override
  List<Object> get props => [invitations];
}

// Состояние при успешной загрузке данных о конкретной встрече
class B2bLoadedMeeting extends B2bState {
  final Meeting meeting;

  B2bLoadedMeeting(this.meeting);

  @override
  List<Object> get props => [meeting];
}

// Состояние после успешного создания новой встречи
class B2bMeetingCreated extends B2bState {}

// Состояние после успешного обновления статуса встречи
class B2bMeetingStatusUpdated extends B2bState {}

// Состояние при успешной загрузке доступных столов для встречи
class B2bLoadedTables extends B2bState {
  final List<TableModel> tables;

  B2bLoadedTables(this.tables);

  @override
  List<Object> get props => [tables];
}

// Состояние при успешной загрузке тем встреч
class B2bLoadedThemes extends B2bState {
  final List<ThemeModel> themes;

  B2bLoadedThemes(this.themes);

  @override
  List<Object> get props => [themes];
}

// Состояние при успешной загрузке статусов встреч
class B2bLoadedStatuses extends B2bState {
  final List<StatusModel> statuses;

  B2bLoadedStatuses(this.statuses);

  @override
  List<Object> get props => [statuses];
}

// Состояние при успешном обновлении доступности участника
class B2bParticipantAvailabilityUpdated extends B2bState {}

// Состояние после подтверждения аккредитации
class B2bAccreditationConfirmed extends B2bState {}

// Состояние после успешного сохранения отзыва о встрече
class B2bFeedbackSaved extends B2bState {}

// Состояние ошибки (в случае неудачного API вызова)
class B2bError extends B2bState {
  final String message;

  B2bError(this.message);

  @override
  List<Object> get props => [message];
}
