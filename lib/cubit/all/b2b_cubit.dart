// управление состоянием встречь, приглашений и тд

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/all/b2b_state.dart';// Состояния B2B
import 'package:eventssytem/cubit/all/b2b_repository.dart'; // Репозиторий для работы с API

class B2bCubit extends Cubit<B2bState> {
  final B2bRepository repository;

  B2bCubit(this.repository) : super(B2bInitial());

  // Загрузка слотов встреч для участника
  Future<void> fetchTimeslots(String eventId, String participantId, String date) async {
    emit(B2bLoading()); 
    try {
      final timeslots = await repository.getTimeslots(eventId, participantId, date);
      emit(B2bLoadedTimeslots(timeslots));
      for (var slot in timeslots) {
        print("Полученный MeetingSlot ID: ${slot.id}");
      }
    } catch (e) {
      emit(B2bError('Ошибка загрузки слотов встреч'));
    }
  }

  
  

  // Загрузка приглашений для участника
  Future<void> fetchInvitations(String eventId, String participantId) async {
    emit(B2bLoading()); // Сброс состояния перед загрузкой
    try {
      final invitations = await repository.getInvitations(eventId, participantId);
      emit(B2bLoadedInvitations(invitations));
    } catch (e) {
      emit(B2bError('Ошибка загрузки приглашений'));
    }
  }

  // Получение конкретной встречи
  Future<void> fetchMeeting(String eventId, String participantId, String meetingId) async {
    try {
      emit(B2bLoading());
      final meeting = await repository.getMeeting(eventId, participantId, meetingId);
      emit(B2bLoadedMeeting(meeting));
    } catch (e) {
      emit(B2bError('Ошибка загрузки встречи: $e'));
    }
  }

  

  // Принятие или отклонение встречи
  Future<void> updateMeetingStatus(
  String eventId,
  String participantId,
  String meetingId,
  int statusId, 
) async {
  try {
    await repository.updateMeetingStatus(
      eventId: eventId,
      participantId: participantId,
      meetingId: meetingId,
      statusId: statusId,
    );
    emit(B2bMeetingStatusUpdated());
  } catch (e) {
    emit(B2bError('Ошибка изменения статуса встречи: $e'));
  }
}


  // Получение доступных столов для слота
  Future<void> fetchTables(String eventId, String timeslotId) async {
    try {
      emit(B2bLoading());
      final tables = await repository.getTables(eventId, timeslotId);
      emit(B2bLoadedTables(tables));
    } catch (e) {
      emit(B2bError('Ошибка загрузки столов: $e'));
    }
  }

  // Получение тем для встречи
  Future<void> fetchMeetingThemes() async {
    try {
      emit(B2bLoading());
      final themes = await repository.getMeetingThemes();
      emit(B2bLoadedThemes(themes));
    } catch (e) {
      emit(B2bError('Ошибка загрузки тем встреч: $e'));
    }
  }

  // Получение доступных статусов встречи
  Future<void> fetchMeetingStatuses() async {
    try {
      emit(B2bLoading());
      final statuses = await repository.getMeetingStatuses();
      emit(B2bLoadedStatuses(statuses));
    } catch (e) {
      emit(B2bError('Ошибка загрузки статусов встреч: $e'));
    }
  }

  // Изменение данных участника
  Future<void> updateParticipantAvailability(String eventId, String participantId, bool available) async {
    try {
      await repository.updateParticipantAvailability(eventId, participantId, available);
      emit(B2bParticipantAvailabilityUpdated());
    } catch (e) {
      emit(B2bError('Ошибка изменения доступности участника: $e'));
    }
  }

  // Подтверждение аккредитации
  Future<void> confirmAccreditation(String eventId, String participantId) async {
    try {
      await repository.confirmAccreditation(eventId, participantId);
      emit(B2bAccreditationConfirmed());
    } catch (e) {
      emit(B2bError('Ошибка подтверждения аккредитации: $e'));
    }
  }

  // Сохранение результата опроса после встречи
  Future<void> saveMeetingFeedback(String eventId, String participantId, Map<String, dynamic> feedbackData) async {
    try {
      await repository.saveMeetingFeedback(eventId, participantId, feedbackData);
      emit(B2bFeedbackSaved());
    } catch (e) {
      emit(B2bError('Ошибка сохранения отзыва о встрече: $e'));
    }
  }
}
