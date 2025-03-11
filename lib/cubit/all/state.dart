import 'package:flutter/material.dart';

abstract class FilterState {}

class FilterOpenState extends FilterState {}

class FilterClosedState extends FilterState {}

abstract class SlidingAuthState {}

class SlidingAuthOpenState extends SlidingAuthState {}

class SlidingAuthClosedState extends SlidingAuthState {}

abstract class SlidingQrState {}

class SlidingQrOpenState extends SlidingQrState {}

class SlidingQrClosedState extends SlidingQrState {}

abstract class SlidingMapState {}

class SlidingMapOpenState extends SlidingMapState {
  String? name;
  String? opisanie;
  String? adress;
  String? site;
  String? tel;
  Color? color;
  SlidingMapOpenState(
      {this.name, this.opisanie, this.adress, this.site, this.tel, this.color});
}

class SlidingMapClosedState extends SlidingMapState {}

// ? --------------------- Заявки ---------------------

abstract class ProfilePageState {}

class ProfilePageLoadingState extends ProfilePageState {}

class ProfilePageLoadedState extends ProfilePageState {
  dynamic loadedProfilePage;
  dynamic loadedCountry;
  dynamic loadedTitles;
  dynamic loadedSpheres;
  dynamic loadrusRegions;
  dynamic loadedmedia;
  ProfilePageLoadedState(
      {this.loadedProfilePage,
      this.loadedCountry,
      this.loadedTitles,
      this.loadedSpheres,
      this.loadedmedia,
      this.loadrusRegions});
}

class ProfilePageErrorState extends ProfilePageState {}
//------ClaimPage

abstract class ClaimPageState {}

class ClaimPageLoadingState extends ClaimPageState {}

class ClaimPageLoadedState extends ClaimPageState {
  dynamic loadedClaimPage;
  ClaimPageLoadedState({this.loadedClaimPage});
}

class ClaimPageErrorState extends ClaimPageState {}
//------ClaimDelete

abstract class ClaimDeleteState {}

class ClaimDeleteClaimState extends ClaimDeleteState {}

class ClaimDeleteErrorState extends ClaimDeleteState {}

class ClaimDeleteEmptyState extends ClaimDeleteState {}
//------Claim Update

abstract class ClaimUpdatetate {}

class ClaimNoEditState extends ClaimUpdatetate {
  bool edited;
  ClaimNoEditState({required this.edited});
}

class ClaimUpdateClaimState extends ClaimUpdatetate {}

class ClaimLoadedClaimState extends ClaimUpdatetate {}

class ClaimUpdateErrorState extends ClaimUpdatetate {}

class ClaimUpdateEmptyState extends ClaimUpdatetate {}
//------Filter b2b

abstract class FilterB2bState {}

class FilterB2bOpenState extends FilterB2bState {}

class FilterB2bClosedState extends FilterB2bState {}
//------EventProgram

abstract class EventProgramState {}

class CardLoadingState extends EventProgramState {}

class CardLoadedState extends EventProgramState {
  List<dynamic>? loadedCard;
  CardLoadedState({this.loadedCard});
}

class CardErrorState extends EventProgramState {}

//------Culture program
abstract class EventCultureProgramState {}

class CardLoadingState2 extends EventCultureProgramState {}

class CardLoadedState2 extends EventCultureProgramState {
  List<dynamic>? loadedCard2;
  CardLoadedState2({this.loadedCard2});
}

class CardErrorState2 extends EventCultureProgramState {}

//------Speakers
abstract class SpeakersState {}

class CardLoadingState3 extends SpeakersState {}

class CardLoadedState3 extends SpeakersState {
  List<dynamic>? loadedCard3;
  CardLoadedState3({this.loadedCard3});
}

class CardErrorState3 extends SpeakersState {}

//! Голосование
abstract class VotingState {}

class VotingLoadingState extends VotingState {}

class VotingEmptyState extends VotingState {}

class VotingMessageState extends VotingState {
  String message;
  VotingMessageState({required this.message});
}

class VotingLoadedState extends VotingState {
  String title;
  String number;
  String count;
  List<String> answer;
  List<String> answerid;
  String voteId;

  VotingLoadedState(
      {required this.title,
      required this.number,
      required this.count,
      required this.answer,
      required this.answerid,
      required this.voteId});
}

class VotingErrorState extends VotingState {}

//! Feedback
abstract class FeedbackState {}

class FeedbackSendState extends FeedbackState {}

class FeedbackClearState extends FeedbackState {}

class FeedbackErrorState extends FeedbackState {}

abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  List<dynamic>? newsloaded;
  NewsLoaded({this.newsloaded});
}

class NewsError extends NewsState {}

// ? --------------------- Точки на карте ---------------------

abstract class MapTochkiState {}

class MapTochkiLoadingState extends MapTochkiState {}

class MapTochkiLoadedState extends MapTochkiState {
  List<dynamic>? facilities;
  List<dynamic>? hotels;
  List<dynamic>? showplaces;

  MapTochkiLoadedState({this.facilities, this.hotels, this.showplaces});
}

class MapTochkiErrorState extends MapTochkiState {}

// ? --------------------- Точки на карте2 ---------------------

abstract class MapTochkiVisibleState {}

class MapTochkiVisibleLoadingState extends MapTochkiVisibleState {}

class MapTochkiVisibleErrorState extends MapTochkiVisibleState {}

class MapTochkiVisibleLoadedState extends MapTochkiVisibleState {
  List<dynamic>? tochki;
  bool v;
  MapTochkiVisibleLoadedState({required this.tochki, required this.v});
}

//? - Полезные материалы

abstract class MaterialsState {}

class MaterialsLoading extends MaterialsState {}

class MaterialsLoaded extends MaterialsState {
  List<dynamic>? loaded;
  MaterialsLoaded({this.loaded});
}

class MaterialsError extends MaterialsState {}

//------OneEvenAction

abstract class EventProgramByIdState {}

class EventProgramByIdLoadingState extends EventProgramByIdState {}

class EventProgramByIdLoadedState extends EventProgramByIdState {
  dynamic loaded;
  EventProgramByIdLoadedState({this.loaded});
}

class EventProgramByIdErrorState extends EventProgramByIdState {}
//------ClaimDelete

//------Поиск
abstract class SearchInAppState {}

class SearchInAppLoadingState extends SearchInAppState {}

class SearchInAppErrorState extends SearchInAppState {}

class SearchInAppLoadedState extends SearchInAppState {
  SearchInAppLoadedState();
}

//------Категории Главная и расписание

abstract class EventProgramCategoryState {}

class EventProgramCategoryLoadingState extends EventProgramCategoryState {}

class EventProgramCategoryLoadedState extends EventProgramCategoryState {
  dynamic loaded;
  EventProgramCategoryLoadedState({this.loaded});
}

class EventProgramCategoryErrorState extends EventProgramCategoryState {}

//------Наполнение фильтра расписания

abstract class ShFilterNapolnitelState {}

class ShFilterNapolnitelLoadingState extends ShFilterNapolnitelState {}

class ShFilterNapolnitelLoadedState extends ShFilterNapolnitelState {
  dynamic spheres;
  dynamic eventFormats;

  ShFilterNapolnitelLoadedState({this.spheres, this.eventFormats});
}

class ShFilterNapolnitelErrorState extends ShFilterNapolnitelState {}

//------Трансляции на главной

abstract class EventProgramLiveState {}

class EventProgramLiveLoadingState extends EventProgramLiveState {}

class EventProgramLiveLoadedState extends EventProgramLiveState {
  dynamic loaded;
  EventProgramLiveLoadedState({this.loaded});
}

class EventProgramLiveErrorState extends EventProgramLiveState {}

//------Личное расписание

abstract class PersonalscheduleState {}

class PersonalscheduleLoadingState extends PersonalscheduleState {}

class PersonalscheduleLoadedState extends PersonalscheduleState {
  dynamic loaded;
  PersonalscheduleLoadedState({this.loaded});
}

class PersonalscheduleErrorState extends PersonalscheduleState {}

class PersonalscheduleConstainState extends PersonalscheduleState {}

class PersonalscheduleNoConstainState extends PersonalscheduleState {}

//------b2b
abstract class B2bListState {}

class B2bListLoadingState extends B2bListState {}

class B2bListErrorState extends B2bListState {}

class B2bListLoadedState extends B2bListState {
  dynamic loaded;
  B2bListLoadedState({this.loaded});
}

//------Наполнение фильтра б2б

abstract class B2bFilterNapolnitelState {}

class B2bFilterNapolnitelLoadingState extends B2bFilterNapolnitelState {}

class B2bFilterNapolnitelLoadedState extends B2bFilterNapolnitelState {
  dynamic countyid;
  dynamic company;
  dynamic otrasl;

  B2bFilterNapolnitelLoadedState({this.countyid, this.company, this.otrasl});
}

class B2bFilterNapolnitelErrorState extends B2bFilterNapolnitelState {}

//! b2bsend
abstract class B2bsendState {}

class B2bsendSendState extends B2bsendState {}

class B2bsendClearState extends B2bsendState {}

class B2bsendErrorState extends B2bsendState {}

//------Партнеры
abstract class PartnersState {}

class PartnersLoadingState extends PartnersState {}

class PartnersErrorState extends PartnersState {}

class PartnersLoadedState extends PartnersState {
  dynamic loaded;
  PartnersLoadedState({this.loaded});
}

//------qr code
abstract class QrState {}

class QrLoadingState extends QrState {}

class QrErrorState extends QrState {}

class QrLoadedState extends QrState {
  dynamic loadedp;
  dynamic loadedv;
  QrLoadedState({this.loadedp, this.loadedv});
}

//------transport
abstract class TransportState {}

class TransportLoadingState extends TransportState {}

class TransportErrorState extends TransportState {}

class TransportLoadedState extends TransportState {
  dynamic loaded;
  TransportLoadedState({this.loaded});
}

//------transport
abstract class TransportTwoState {}

class TransportTwoLoadingState extends TransportTwoState {}

class TransportTwoErrorState extends TransportTwoState {}

class TransportTwoLoadedState extends TransportTwoState {
  dynamic loaded;
  dynamic from;
  dynamic to;
  TransportTwoLoadedState({this.loaded, this.from, this.to});
}

//------transport
abstract class PayedState {}

class PayedGoodState extends PayedState {}

class PayedBadState extends PayedState {}

class PayedLoadingState extends PayedState {}

//------B2bdd
abstract class B2bdState {}

class B2bdGoodState extends B2bdState {}

class B2bdBadState extends B2bdState {}

class B2bdLoadingState extends B2bdState {}
