import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:eventssytem/cubit/all/repository.dart';
import 'package:eventssytem/cubit/auth/login_cubit.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventssytem/cubit/all/b2b_repository.dart';
import 'package:eventssytem/cubit/all/b2b_cubit.dart';

final sl = GetIt.instance;
final profilePageRepository = ProfilePageRepository();
// final claimPageRepository = ClaimPageRepository();

EventProgramLiveRepository eventProgramLiveRepository =
    EventProgramLiveRepository();

EventProgramCategoryRepository eventProgramCategoryRepository =
    EventProgramCategoryRepository();

EventProgramRepository eventProgramRepository = EventProgramRepository();
EventCultureProgramRepository eventCultureProgramRepository =
    EventCultureProgramRepository();
SpeakersRepository speakersRepository = SpeakersRepository();

MapRepositories mapRepositories = MapRepositories();

MaterialsRepository materialsRepository = MaterialsRepository();

EventProgramByIdRepository eventProgramByIdRepository =
    EventProgramByIdRepository();

PersonalscheduleRepository personalscheduleRepository =
    PersonalscheduleRepository();

VotingRepository votingRepository = VotingRepository();
NewsRepository newsRepository = NewsRepository();

B2bListRepository b2bListRepository = B2bListRepository();

PartnersRepository partnersRepository = PartnersRepository();

TransportRepository transportRepository = TransportRepository();

Future<void> init() async {
  sl.registerFactory(() => BottomNavigationControllerSelect());
  sl.registerFactory(() => TabShVerhController());
  sl.registerFactory(() => FilterCubit());
  sl.registerFactory(() => FilterB2bCubit());
  sl.registerFactory(() => SlidingMapCubit());
  sl.registerFactory(() => LangCubit());
  sl.registerFactory(() => SlidingQrCubit());
  sl.registerFactory(() => SlidingAutgCubit());
  sl.registerFactory(() => AuthCubit());
  sl.registerFactory(() => FeedbackCubit());
  sl.registerFactory(() => Checklivestream());
  sl.registerFactory(() => FilterShCountController());
  sl.registerFactory(() => FilterB2bCountController());
  sl.registerFactory(() => MapVisibleCubit());
  sl.registerFactory(() => Checkspekearb2b());
  sl.registerFactory(() => B2bsendCubit());
  sl.registerFactory(() => TransportTwoCubit());
  sl.registerFactory(() => CheckTr());
  sl.registerFactory(() => PayedCubit());
  sl.registerFactory(() => B2bdCubit());
  sl.registerFactory(() => TransportCubit(transportRepository));
  sl.registerFactory(() => PartnersCubit(partnersRepository));
  sl.registerFactory(() => B2bFilterNapolnitelCubit(profilePageRepository));
  sl.registerFactory(() => B2bCubit(sl<B2bRepository>()));
  sl.registerFactory(() => B2bListCubit(b2bListRepository));

  sl.registerFactory(() => CheckPSHtream());

  sl.registerFactory(() => PersonalscheduleCubit(personalscheduleRepository));

  sl.registerFactory(() => EventProgramLiveCubit(eventProgramLiveRepository));

  sl.registerFactory(() => ShFilterNapolnitelCubit(profilePageRepository));

  sl.registerFactory(
      () => EventProgramCategoryCubit(eventProgramCategoryRepository));

  sl.registerFactory(
      () => SearchInAppCubit(eventProgramRepository, speakersRepository));

  sl.registerFactory(() => MaterialsCubit(materialsRepository));
  sl.registerFactory(() => MapCubit(mapRepositories));
  sl.registerFactory(() => EventProgramByIdCubit(eventProgramByIdRepository));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final FlutterAppAuth appAuth = FlutterAppAuth();
  sl.registerLazySingleton(() => appAuth);

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton<B2bRepository>(() => B2bRepository());

  sl.registerFactory(() => ProfilePageCubit(profilePageRepository));
  // sl.registerFactory(() => ClaimPageCubit(claimPageRepository));

  // sl.registerFactory(() => ClaimDeleteCubit());
  sl.registerFactory(() => ClaimUpdateCubit());
  sl.registerFactory(() => EventProgramCubit(eventProgramRepository));
  sl.registerFactory(
      () => EventCulturProgramCubit(eventCultureProgramRepository));
  sl.registerFactory(() => SpeakersCubit(speakersRepository));

  sl.registerFactory(() => VotingCubit(votingRepository));
  sl.registerFactory(() => NewsCubit(newsRepository));

  sl.registerFactory(() => QrCubit());
}
