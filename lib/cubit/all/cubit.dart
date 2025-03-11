import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/all/api.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/repository.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/locator_services.dart';
import 'package:eventssytem/other/filter_b2b.dart';
import 'package:eventssytem/other/filter_sh.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/other/personal_sh.dart';
import 'package:eventssytem/other/search_const.dart';
import 'package:eventssytem/other/transport_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferences sharedPreferences = sl<SharedPreferences>();

class BottomNavigationControllerSelect extends Cubit<int> {
  BottomNavigationControllerSelect() : super(0);

  void select(int index) {
    emit(index);
    // if (index == 1) {
    //   EventProgramCubitApi().getConfig();
    // }
  }
}

class TabShVerhController extends Cubit<int> {
  TabShVerhController() : super(0);
  void select2(int index) {
    emit(index);
  }
}

class Checklivestream extends Cubit<bool> {
  Checklivestream() : super(false);
  void select(bool index) {
    emit(index);
  }
}

class CheckTr extends Cubit<bool> {
  CheckTr() : super(false);
  void select(bool index) {
    emit(index);
  }
}

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(Locale(ConstantsClass.locale));

  Locale? _locale;

  Locale? get locale => _locale;

  void getlocale() async {
    final locale = sharedPreferences.getString("locale");
    if (locale == null) {
      setLocale(Locale(ConstantsClass.locale));
    }
    if (locale != null) {
      setLocale(Locale(locale));
    }
  }

  void setLocale(Locale locale) async {
    await sharedPreferences.setString("locale", locale.toString());
    ConstantsClass.locale = locale.toString();
    emit(locale);
  }
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterClosedState());

  Future<void> open() async {
    if (state is FilterOpenState) emit(FilterClosedState());
    emit(FilterOpenState());
  }

  Future<void> hide() async {
    if (state is FilterClosedState) return;
    emit(FilterClosedState());
  }
}

class SlidingAutgCubit extends Cubit<SlidingAuthState> {
  SlidingAutgCubit() : super(SlidingAuthClosedState());

  Future<void> open() async {
    if (state is SlidingAuthOpenState) emit(SlidingAuthClosedState());
    emit(SlidingAuthOpenState());
  }

  Future<void> hide() async {
    if (state is SlidingAuthClosedState) return;
    emit(SlidingAuthClosedState());
  }
}

class SlidingQrCubit extends Cubit<SlidingQrState> {
  SlidingQrCubit() : super(SlidingQrClosedState());

  Future<void> open() async {
    if (state is SlidingQrOpenState) emit(SlidingQrClosedState());
    emit(SlidingQrOpenState());
  }

  Future<void> hide() async {
    if (state is SlidingQrClosedState) return;
    emit(SlidingQrClosedState());
  }
}

class SlidingMapCubit extends Cubit<SlidingMapState> {
  SlidingMapCubit() : super(SlidingMapClosedState());

  Future<void> open(String name, String opisanie, String adress, String site,
      String tel, Color color) async {
    if (state is SlidingMapOpenState) emit(SlidingMapClosedState());
    emit(SlidingMapOpenState(
        name: name,
        opisanie: opisanie,
        adress: adress,
        site: site,
        tel: tel,
        color: color));
  }

  Future<void> hide() async {
    if (state is SlidingMapClosedState) return;
    emit(SlidingMapClosedState());
  }
}

// class ProfilePageCubit extends Cubit<ProfilePageState> {
//   final ProfilePageRepository profilePageRepository;

//   ProfilePageCubit(this.profilePageRepository)
//       : super(ProfilePageLoadedState());

//   Future<void> fetchProfilePage() async {
//     try {
//       emit(ProfilePageLoadingState());
//       ProfilePageModel _loaded =
//           await profilePageRepository.getAllProfilePage();
//       emit(ProfilePageLoadedState(loadedProfilePage: _loaded));
//     } catch (_) {
//       emit(ProfilePageErrorState());
//     }
//   }
// }

// class ClaimPageCubit extends Cubit<ClaimPageState> {
//   final ClaimPageRepository claimPageRepository;

//   ClaimPageCubit(this.claimPageRepository) : super(ClaimPageLoadedState());

//   Future<void> fetchClaimPage(String id) async {
//     try {
//       emit(ClaimPageLoadingState());
//       ClaimPageModel _loaded2 = await claimPageRepository.getAllClaimPage(id);
//       print("_loaded $_loaded2");
//       emit(ClaimPageLoadedState(loadedClaimPage: _loaded2));
//     } catch (_) {
//       emit(ClaimPageErrorState());
//     }
//   }
// }

// class ClaimDeleteCubit extends Cubit<ClaimDeleteState> {
//   ClaimDeleteCubit() : super(ClaimDeleteEmptyState());

//   Future<void> deleteclaim(String id) async {
//     try {
//       String resp = await DeleteClaimApi().delete(id);
//       print(resp);
//       if (resp == "Delete") {
//         print("go del");
//         emit(ClaimDeleteClaimState());
//       } else {
//         emit(ClaimDeleteErrorState());
//       }
//     } catch (_) {
//       emit(ClaimDeleteErrorState());
//     }
//   }
// }

// class ClaimUpdateCubit extends Cubit<ClaimUpdatetate> {
//   ClaimUpdateCubit() : super(ClaimUpdateEmptyState());

//   Future<void> updateclaim(
//       String id,
//       String templateId,
//       Map<String, Citizenship> selecteddrops,
//       Map<String, bool> selectedcheck,
//       Map<String, String> selectedradio,
//       Map<String, TextEditingController> textEditingControllers) async {
//     emit(ClaimLoadedClaimState());
//     try {
//       String resp = await UpdateClaimApi().update(id, templateId, selecteddrops,
//           selectedcheck, selectedradio, textEditingControllers);
//       print(resp);
//       if (resp == "ok") {
//         print("okl");
//         emit(ClaimUpdateClaimState());
//       } else {
//         emit(ClaimUpdateErrorState());
//       }
//     } catch (_) {
//       emit(ClaimUpdateErrorState());
//     }
//   }
// }

class FilterB2bCubit extends Cubit<FilterB2bState> {
  FilterB2bCubit() : super(FilterB2bClosedState());

  Future<void> open() async {
    print("object");
    if (state is FilterB2bOpenState) emit(FilterB2bClosedState());
    emit(FilterB2bOpenState());
  }

  Future<void> hide() async {
    if (state is FilterB2bClosedState) return;
    emit(FilterB2bClosedState());
  }
}

class EventProgramCubit extends Cubit<EventProgramState> {
  final EventProgramRepository eventProgramRepository;

  EventProgramCubit(this.eventProgramRepository) : super(CardLoadedState());

  Future<void> fetchCard(
      {required List<int> eventTypeIds,
      required List<int> eventDateIds,
      List<int>? sphereIds,
      List<int>? eventFormat}) async {
    try {
      emit(CardLoadingState());
      List<dynamic> loaded = await eventProgramRepository.getAllEventPrograms(
          eventTypeIds: eventTypeIds,
          eventDateIds: eventDateIds,
          sphereIds: sphereIds,
          eventFormat: eventFormat);

      print("приватная  $loaded");
      emit(CardLoadedState(loadedCard: loaded));
    } catch (_) {
      emit(CardErrorState());
    }
  }
}

class EventCulturProgramCubit extends Cubit<EventCultureProgramState> {
  final EventCultureProgramRepository eventCultureProgramRepository;

  EventCulturProgramCubit(this.eventCultureProgramRepository)
      : super(CardLoadedState2());

  Future<void> fetchCard2() async {
    try {
      emit(CardLoadingState2());
      List<EventCulturModel> loaded =
          await eventCultureProgramRepository.getAllEventPrograms2();
      print("приватная  $loaded");
      emit(CardLoadedState2(loadedCard2: loaded));
    } catch (_) {
      emit(CardErrorState2());
    }
  }
}

class SpeakersCubit extends Cubit<SpeakersState> {
  final SpeakersRepository speakersRepository;

  SpeakersCubit(this.speakersRepository) : super(CardLoadedState3());

  Future<void> fetchCard3() async {
    try {
      emit(CardLoadingState3());
      List<SpeakersModel> loaded =
          await speakersRepository.getAllEventPrograms3();
      print("приватная  $loaded");
      emit(CardLoadedState3(loadedCard3: loaded));
    } catch (_) {
      emit(CardErrorState3());
    }
  }
}

class SearchInAppCubit extends Cubit<SearchInAppState> {
  final EventProgramRepository eventProgramRepository;
  final SpeakersRepository speakersRepository;

  SearchInAppCubit(this.eventProgramRepository, this.speakersRepository)
      : super(SearchInAppLoadingState());

  Future<void> fetchlists() async {
    try {
      List<SpeakersModel> loaded =
          await speakersRepository.getAllEventPrograms3();

      SearchConsts.speakers = loaded;

      List<EventProgramModel> loaded2 = await eventProgramRepository
          .getAllEventPrograms(
              eventTypeIds: [19], eventDateIds: [0], vse: true);

      SearchConsts.rasp = loaded2;

      emit(SearchInAppLoadedState());
    } catch (_) {
      emit(SearchInAppErrorState());
    }
  }
}

class VotingCubit extends Cubit<VotingState> {
  final VotingRepository votingRepository;

  VotingCubit(this.votingRepository) : super(VotingEmptyState());

  Future<void> setVoting(String voteId, String answerId) async {
    try {
      emit(VotingLoadingState());

      String loaded = await VotingApi().setVoting(voteId, answerId);

      emit(VotingMessageState(message: loaded));

      loadVoting();
    } catch (_) {
      emit(VotingErrorState());
    }
  }

  Future<void> loadVoting() async {
    try {
      emit(VotingLoadingState());
      List<VotingPageModel> loaded = await votingRepository.getAllVoting();

      int number = 1;
      String title = "";
      List<String> answer = [];
      List<String> answerid = [];
      for (var item in loaded) {
        if (item.choosedAnswerId == 0) {
          title =
              (ConstantsClass.locale == "en" ? item.nameEng : item.nameRus) ??
                  "";

          for (var item2 in item.voteAnswers!) {
            answer.add((ConstantsClass.locale == "en"
                    ? item2?.nameEng
                    : item2?.nameRus) ??
                "");
            answerid.add(item2!.id.toString());
          }

          emit(VotingLoadedState(
              title: title,
              number: number.toString(),
              count: loaded.length.toString(),
              answer: answer,
              answerid: answerid,
              voteId: item.id.toString()));
          break;
        }
        number++;
      }

      print(number);
      print(loaded.length);
      if (number > loaded.length) {
        emit(VotingEmptyState());
      }
    } catch (_) {
      emit(VotingErrorState());
    }
  }
}

class ProfilePageCubit extends Cubit<ProfilePageState> {
  final ProfilePageRepository profilePageRepository;
  
  ProfilePageCubit(this.profilePageRepository)
      : super(ProfilePageLoadedState());

  Future<void> fetchProfilePage() async {
    print("fetchProfilePage called"); 
    try {
      emit(ProfilePageLoadingState());
      ProfileOldModel loaded = await profilePageRepository.getAllProfilePage();

      print("_loaded $loaded");
      List<dynamic> countriesModel =
          await profilePageRepository.getAllCountries();

      print("countriesModel $countriesModel");

      List<dynamic> titles = await profilePageRepository.getAllTitles();

      List<dynamic> spheres = await profilePageRepository.getAllSpheres();

      List<dynamic> media = await profilePageRepository.getAllMedia();

      List<dynamic> rusRegions = await profilePageRepository.getRusRegions();

      emit(ProfilePageLoadedState(
          loadedProfilePage: loaded,
          loadedCountry: countriesModel,
          loadedTitles: titles,
          loadedSpheres: spheres,
          loadedmedia: media,
          loadrusRegions: rusRegions));
    } catch (_) {
      emit(ProfilePageErrorState());
    }
  }
}

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackClearState());
  Future<void> send(String title, String message, dynamic file) async {
    try {
      String send = await FeedBackApi().send(title, message, file);
      if (send == "OK") {
        emit(FeedbackSendState());
      } else {
        emit(FeedbackErrorState());
      }
    } catch (_) {
      emit(FeedbackErrorState());
    }
  }
}

class B2bsendCubit extends Cubit<B2bsendState> {
  B2bsendCubit() : super(B2bsendClearState());
  Future<void> send({required String id, required String message}) async {
    try {
      String send = await B2bSendApi().send(id: id, message: message);
      if (send == "OK") {
        emit(B2bsendSendState());
      } else {
        emit(B2bsendErrorState());
      }
    } catch (_) {
      emit(B2bsendErrorState());
    }
  }
}

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;

  NewsCubit(this.newsRepository) : super(NewsLoading());

  Future<void> fetchNews() async {
    try {
      emit(NewsLoading());
      List<NewsModel> loaded = await newsRepository.getAllNews();
      emit(NewsLoaded(newsloaded: loaded));
    } catch (_) {
      emit(NewsError());
    }
  }
}

class ClaimUpdateCubit extends Cubit<ClaimUpdatetate> {
  ClaimUpdateCubit() : super(ClaimUpdateEmptyState());

  Future<void> check(String firstNameEng, String lastNameEng) async {
    if (state is ClaimNoEditState) return;
    try {
      String resp = await UpdateClaimApi().check(firstNameEng, lastNameEng);

      if (resp == "true") {
        emit((ClaimNoEditState(edited: true)));
      } else {
        emit((ClaimNoEditState(edited: false)));
      }
    } catch (e) {}
  }

  Future<void> updateclaim(
      String firstNameRus,
      String lastNameRus,
      String patronymic,
      String firstNameEng,
      String lastNameEng,
      String comment,
      organizationRus,
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
    emit(ClaimLoadedClaimState());
    try {
      String resp = await UpdateClaimApi().update(
          firstNameRus,
          lastNameRus,
          patronymic,
          firstNameEng,
          lastNameEng,
          comment,
          organizationRus,
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
          departureFlightInfo);
      print(resp);
      if (resp == "OK") {
        emit(ClaimUpdateClaimState());
      }
    } catch (_) {
      emit(ClaimUpdateErrorState());
    }
  }
}

//!Карта загрузка точек

class MapCubit extends Cubit<MapTochkiState> {
  final MapRepositories mapRepositories;

  MapCubit(this.mapRepositories) : super(MapTochkiLoadingState());

  Future<void> fetchTochki() async {
    try {
      emit(MapTochkiLoadingState());

      List<dynamic> facilities = await mapRepositories.getAllfacilities();

      List<dynamic> hotels = await mapRepositories.getALLhotels();

      List<dynamic> showplaces = await mapRepositories.getAllshowplaces();

      emit(MapTochkiLoadedState(
          facilities: facilities, hotels: hotels, showplaces: showplaces));
    } catch (_) {
      emit(MapTochkiErrorState());
    }
  }
}

class MapVisibleCubit extends Cubit<MapTochkiVisibleState> {
  MapVisibleCubit() : super(MapTochkiVisibleLoadingState());

  Future<void> fetchTochki({dynamic s, required bool v}) async {
    try {
      emit(MapTochkiVisibleLoadingState());
      List<dynamic> tocka = [];

      if (s == null || s == "") {
        print("object");
        tocka = await MapRepositories().getAllList();
      } else {
        tocka = [];
        tocka.add(s);
      }

      emit(MapTochkiVisibleLoadedState(tochki: tocka, v: v));
    } catch (_) {
      emit(MapTochkiVisibleErrorState());
    }
  }
}

class MaterialsCubit extends Cubit<MaterialsState> {
  final MaterialsRepository materialsRepository;
  MaterialsCubit(this.materialsRepository) : super(MaterialsLoading());

  Future<void> fetcMaterials() async {
    try {
      emit(MaterialsLoading());
      List<dynamic> loaded = await materialsRepository.getAllMaterials();
      emit(MaterialsLoaded(loaded: loaded));
    } catch (_) {
      emit(MaterialsError());
    }
  }
}

class EventProgramByIdCubit extends Cubit<EventProgramByIdState> {
  final EventProgramByIdRepository eventProgramByIdRepository;

  EventProgramByIdCubit(this.eventProgramByIdRepository)
      : super(EventProgramByIdLoadingState());

  Future<void> fetchEvent(String id) async {
    try {
      emit(EventProgramByIdLoadingState());

      dynamic loaded = await eventProgramByIdRepository.getProgram(id);

      emit(EventProgramByIdLoadedState(loaded: loaded));
    } catch (_) {
      emit(EventProgramByIdErrorState());
    }
  }
}

class EventProgramCategoryCubit extends Cubit<EventProgramCategoryState> {
  final EventProgramCategoryRepository eventProgramCategoryRepository;

  EventProgramCategoryCubit(this.eventProgramCategoryRepository)
      : super(EventProgramCategoryLoadingState());

  Future<void> fetchCategory() async {
    try {
      emit(EventProgramCategoryLoadingState());
      List<dynamic> loadedEventProgramCategory =
          await eventProgramCategoryRepository.getAllCategory();

      emit(EventProgramCategoryLoadedState(loaded: loadedEventProgramCategory));
    } catch (_) {
      emit(EventProgramCategoryErrorState());
    }
  }
}

class ShFilterNapolnitelCubit extends Cubit<ShFilterNapolnitelState> {
  final ProfilePageRepository profilePageRepository;

  ShFilterNapolnitelCubit(this.profilePageRepository)
      : super(ShFilterNapolnitelLoadingState());

  Future<void> fetchCard() async {
    try {
      emit(ShFilterNapolnitelLoadingState());

      List<dynamic> getAllSpheres = await profilePageRepository.getAllSpheres();
      List<dynamic> getAllEventFormats =
          await profilePageRepository.getAllEventFormats();

      emit(ShFilterNapolnitelLoadedState(
          spheres: getAllSpheres, eventFormats: getAllEventFormats));
    } catch (_) {
      emit(ShFilterNapolnitelErrorState());
    }
  }
}

class FilterShCountController extends Cubit<int> {
  FilterShCountController() : super(0);
  void count() {
    int countig = 0;

    countig = FliterInits.listItemsSpheres.length +
        FliterInits.listItemsEventFormats.length;

    emit(countig);
  }
}

class EventProgramLiveCubit extends Cubit<EventProgramLiveState> {
  final EventProgramLiveRepository eventProgramLiveRepository;

  EventProgramLiveCubit(this.eventProgramLiveRepository)
      : super(EventProgramLiveLoadingState());

  Future<void> fetchCategory() async {
    try {
      emit(EventProgramLiveLoadingState());
      List<dynamic> load = await eventProgramLiveRepository.geAlltLive();

      emit(EventProgramLiveLoadedState(loaded: load));
    } catch (_) {
      emit(EventProgramLiveErrorState());
    }
  }
}

class PersonalscheduleCubit extends Cubit<PersonalscheduleState> {
  final PersonalscheduleRepository personalscheduleRepository;
  PersonalscheduleCubit(this.personalscheduleRepository)
      : super(PersonalscheduleLoadingState());

  Future<void> fetchEvent() async {
    try {
      emit(PersonalscheduleLoadingState());
      List<dynamic> load = await personalscheduleRepository.geAllPSH();

      Personalschedule.psList = load;

      emit(PersonalscheduleLoadedState(loaded: load));
    } catch (_) {
      emit(PersonalscheduleErrorState());
    }
  }

  Future<void> add(int id) async {
    emit(PersonalscheduleLoadingState());
    await PersonalscheduleApi().addPSH(id.toString());
    fetchEvent();
  }

  Future<void> del(int id) async {
    emit(PersonalscheduleLoadingState());
    await PersonalscheduleApi().delPSH(id.toString());
    fetchEvent();
  }
}

class CheckPSHtream extends Cubit<bool> {
  CheckPSHtream() : super(false);
  void select(bool index) {
    emit(index);
  }
}

class B2bListCubit extends Cubit<B2bListState> {
  final B2bListRepository b2bListRepository;

  B2bListCubit(this.b2bListRepository) : super(B2bListLoadingState());

  Future<void> fethb2b(
      {String? name = "",
      int? countryId,
      String? companyName = "",
      String? sphereName}) async {
    try {
      emit(B2bListLoadingState());
      dynamic load = await b2bListRepository.getAll(
          name: name,
          countryId: countryId,
          companyName: companyName,
          sphereName: sphereName);

      emit(B2bListLoadedState(loaded: load));
    } catch (_) {
      emit(B2bListErrorState());
    }
  }
}

class Checkspekearb2b extends Cubit<bool> {
  Checkspekearb2b() : super(false);
  void select(bool index) {
    emit(index);
  }
}

class FilterB2bCountController extends Cubit<int> {
  FilterB2bCountController() : super(0);
  void count() {
    int countig = 0;

    countig = FliterB2b.companyName.length +
        FliterB2b.countryId.length +
        FliterB2b.sphereName.length;

    emit(countig);
  }
}

class B2bFilterNapolnitelCubit extends Cubit<B2bFilterNapolnitelState> {
  final ProfilePageRepository profilePageRepository;

  B2bFilterNapolnitelCubit(this.profilePageRepository)
      : super(B2bFilterNapolnitelLoadingState());

  Future<void> fetchCard() async {
    try {
      emit(B2bFilterNapolnitelLoadingState());

      List<dynamic> countyid = await profilePageRepository.getAllCountries();
      List<dynamic> company = await profilePageRepository.getAllCompanies();
      List<dynamic> otrasl = await profilePageRepository.getAllSpheres();

      emit(B2bFilterNapolnitelLoadedState(
          countyid: countyid, company: company, otrasl: otrasl));
    } catch (_) {
      emit(B2bFilterNapolnitelErrorState());
    }
  }
}

class PartnersCubit extends Cubit<PartnersState> {
  final PartnersRepository partnersRepository;
  PartnersCubit(this.partnersRepository) : super(PartnersLoadingState());
  Future<void> feth() async {
    try {
      emit(PartnersLoadingState());
      dynamic load = await partnersRepository.getAllPartners();
      emit(PartnersLoadedState(loaded: load));
    } catch (_) {
      emit(PartnersErrorState());
    }
  }
}

class QrCubit extends Cubit<QrState> {
  QrCubit() : super(QrLoadingState());
  Future<void> feth() async {
    try {
      emit(QrLoadingState());

      dynamic loadprint = await QrApi().getqrprint();
      dynamic loadgo = await QrApi().getqrgo();

      emit(QrLoadedState(loadedp: loadprint, loadedv: loadgo));
    } catch (_) {
      emit(QrErrorState());
    }
  }
}

class TransportCubit extends Cubit<TransportState> {
  final TransportRepository transportRepository;
  TransportCubit(this.transportRepository) : super(TransportLoadingState());
  dynamic load;

  Future<void> feth() async {
    try {
      emit(TransportLoadingState());
      load = await transportRepository.getAllTransport();
      TransportList.listik = load;

      emit(TransportLoadedState(loaded: load));
    } catch (_) {
      emit(TransportErrorState());
    }
  }
}

class TransportTwoCubit extends Cubit<TransportTwoState> {
  TransportTwoCubit() : super(TransportTwoLoadingState());
  dynamic load;
  Future<void> feth() async {
    try {
      emit(TransportTwoLoadingState());
      load = TransportList.listik;
      emit(TransportTwoLoadedState(loaded: load));
    } catch (_) {
      emit(TransportTwoErrorState());
    }
  }
}

class PayedCubit extends Cubit<PayedState> {
  PayedCubit() : super(PayedLoadingState());
  Future<void> check() async {
    try {
      emit(PayedLoadingState());

      bool truefalse = await CheckDostupApi().checkPay();
      if (truefalse == true) {
        emit(PayedGoodState());
      }
      if (truefalse == false) {
        emit(PayedBadState());
      }
    } catch (_) {
      emit(PayedBadState());
    }
  }
}

class B2bdCubit extends Cubit<B2bdState> {
  B2bdCubit() : super(B2bdLoadingState());
  Future<void> check() async {
    try {
      emit(B2bdLoadingState());

      bool truefalse = await CheckDostupApi().checkCategotyId();
      if (truefalse == true) {
        emit(B2bdGoodState());
      }
      if (truefalse == false) {
        emit(B2bdBadState());
      }
    } catch (_) {
      emit(B2bdBadState());
    }
  }
}
