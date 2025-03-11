import 'package:eventssytem/cubit/all/api.dart';
import 'package:eventssytem/cubit/all/model.dart';

// class ProfilePageRepository {
//   ProfilePageApi profilePageApi = ProfilePageApi();
//   Future<ProfilePageModel> getAllProfilePage() =>
//       profilePageApi.getProfilePage();
// }

// class ClaimPageRepository {
//   ClaimPageApi claimPageApi = ClaimPageApi();
//   Future<ClaimPageModel> getAllClaimPage(String id) =>
//       claimPageApi.getClaimPage(id);
// }

class EventProgramRepository {
  EventProgramCubitApi eventProgramCubit = EventProgramCubitApi();
  Future<List<EventProgramModel>> getAllEventPrograms(
          {required List<int> eventTypeIds,
          required List<int> eventDateIds,
          List<int>? sphereIds,
          List<int>? eventFormat,
          bool vse = false}) =>
      eventProgramCubit.getConfig(
          eventTypeIds: eventTypeIds,
          eventDateIds: eventDateIds,
          sphereIds: sphereIds,
          eventFormat: eventFormat,
          vse: vse);
}

class EventCultureProgramRepository {
  EventCulturProgramCubitApi eventCulturProgramCubit =
      EventCulturProgramCubitApi();
  Future<List<EventCulturModel>> getAllEventPrograms2() =>
      eventCulturProgramCubit.getConfig2();
}

class SpeakersRepository {
  SpeakersApi speakersApi = SpeakersApi();
  Future<List<SpeakersModel>> getAllEventPrograms3() =>
      speakersApi.getConfig3();
}

class VotingRepository {
  VotingApi votingApi = VotingApi();
  Future<List<VotingPageModel>> getAllVoting() => votingApi.getVoting();
}

class ProfilePageRepository {
  ProfilePageApi profilePageApi = ProfilePageApi();
  Future<ProfileOldModel> getAllProfilePage() =>
      profilePageApi.getProfilePage();
  Future<List<dynamic>> getAllCountries() {
    return profilePageApi.getCountries();
  }

  Future<List<dynamic>> getAllTitles() {
    return profilePageApi.getTitles();
  }

  Future<List<dynamic>> getAllSpheres() {
    return profilePageApi.getSpheres();
  }

  Future<List<dynamic>> getAllMedia() {
    return profilePageApi.getMedia();
  }

  Future<List<dynamic>> getRusRegions() {
    return profilePageApi.getRusRegions();
  }

  Future<List<dynamic>> getAllEventFormats() {
    return profilePageApi.getEventFormats();
  }

  Future<List<dynamic>> getAllCompanies() {
    return profilePageApi.getCompanies();
  }
}

class NewsRepository {
  NewsApi newsApi = NewsApi();
  Future<List<NewsModel>> getAllNews() => newsApi.getNews();
}

class MapRepositories {
  MapPageApi mapPageApi = MapPageApi();

  Future<List<dynamic>> getAllfacilities() {
    return mapPageApi.getfacilities();
  }

  Future<List<dynamic>> getALLhotels() {
    return mapPageApi.gethotels();
  }

  Future<List<dynamic>> getAllshowplaces() {
    return mapPageApi.getshowplaces();
  }

  getAllList() async {
    print("objectlll");

    List<dynamic> allList = [];
    allList.addAll(await getAllfacilities());
    allList.addAll(await getALLhotels());
    allList.addAll(await getAllshowplaces());
    return allList;
  }
}

class MaterialsRepository {
  MaterialsApi materialsApi = MaterialsApi();

  Future<List<dynamic>> getAllMaterials() => materialsApi.getMaterials();
}

class EventProgramByIdRepository {
  EventProgramByIdApi eventProgramByIdApi = EventProgramByIdApi();
  Future<EventProgramModel> getProgram(String id) =>
      eventProgramByIdApi.getone(id);
}

class EventProgramCategoryRepository {
  EventProgramCategoryApi eventProgramCategoryApi = EventProgramCategoryApi();
  Future<List<dynamic>> getAllCategory() =>
      eventProgramCategoryApi.getCategory();
}

class EventProgramLiveRepository {
  EventProgramLiveApi eventProgramLiveApi = EventProgramLiveApi();
  Future<List<EventProgramModel>> geAlltLive() => eventProgramLiveApi.getLive();
}

class PersonalscheduleRepository {
  PersonalscheduleApi personalscheduleApi = PersonalscheduleApi();
  Future<List<EventProgramModel>> geAllPSH() => personalscheduleApi.getPSH();
}

class B2bListRepository {
  B2bListApi b2bListApi = B2bListApi();
  Future<B2BListModel> getAll(
          {String? name = "",
          int? countryId,
          String? companyName = "",
          String? sphereName}) =>
      b2bListApi.getList(
          name: name,
          countryId: countryId,
          companyName: companyName,
          sphereName: sphereName);
}

class PartnersRepository {
  PartnersApi partnersApi = PartnersApi();
  Future<List<dynamic>> getAllPartners() => partnersApi.getPartners();
}

class TransportRepository {
  TransportApi transportApi = TransportApi();
  Future<List<dynamic>> getAllTransport() => transportApi.getTransport();
}
