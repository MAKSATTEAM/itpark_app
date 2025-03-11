import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:eventssytem/cubit/all/b2b_cubit.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/auth/login_auth.dart';
import 'package:eventssytem/cubit/auth/login_cubit.dart';
import 'package:eventssytem/cubit/auth/login_state.dart';
import 'package:eventssytem/cubit/locator_services.dart';
import 'package:eventssytem/other/drops.dart';
import 'package:eventssytem/other/notification_class.dart';
import 'package:eventssytem/screens/%D1%81ontacts_page.dart';
import 'package:eventssytem/screens/auth_info_page.dart';
import 'package:eventssytem/screens/auth_page.dart';
import 'package:eventssytem/screens/b2b_page.dart';
import 'package:eventssytem/screens/event_page_put.dart';
import 'package:eventssytem/screens/feedback_page.dart';
import 'package:eventssytem/screens/management.dart';
import 'package:eventssytem/screens/map_info_page.dart';
import 'package:eventssytem/screens/map_page.dart';
import 'package:eventssytem/screens/news_page.dart';
import 'package:eventssytem/screens/notification_page.dart';
import 'package:eventssytem/screens/partners_page.dart';
import 'package:eventssytem/screens/profile_edit_page.dart';
import 'package:eventssytem/screens/search_page.dart';
import 'package:eventssytem/screens/settings_page.dart';
import 'package:eventssytem/screens/speaker_page.dart';
import 'cubit/all/b2b_repository.dart';
import 'package:eventssytem/screens/transport_page.dart';
import 'package:eventssytem/screens/useful_materials_page.dart';
import 'package:eventssytem/screens/voting_page.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/widgets/sliding_filter.dart';
import 'package:eventssytem/widgets/sliding_qr.dart';
import 'utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/cubit/locator_services.dart' as servic;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Drops drops = Drops({"null": Citizenship(id: "null", display: "null")});

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(NotificationClassAdapter());
  await Hive.openBox<NotificationClass>('notificationList');

  RemoteNotification? notification = message.notification;

  if (notification != null) {
    var box = Hive.box<NotificationClass>("notificationList");
    box.add(NotificationClass(
        title: notification.title,
        body: notification.body,
        date: DateFormat('yyyy-MM-dd \n kk:mm:ss')
            .format(DateTime.now())
            .toString(),
        read: false));
  }

  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: kBacColor,
    statusBarIconBrightness: Brightness.dark,
  ));
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Запрос разрешений на уведомления и инициализация Firebase Messaging
  await _initializeFirebaseMessaging();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Настройки уведомлений
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Инициализация Hive и прочих сервисов
  await servic.init();
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationClassAdapter());
  await Hive.openBox<String>('favoriteTransportList');
  await Hive.openBox<NotificationClass>('notificationList');

  runApp(const MyApp());
}

// Инициализация Firebase Messaging и получение токена
Future<void> _initializeFirebaseMessaging() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Запрос разрешений на уведомления
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
      return; // Прерываем инициализацию, если разрешение не получено
    }

    // Получаем Firebase токен с обработкой ошибок
    String? token;
    try {
      token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        AppAuth.firebasetoken = token;
        print("Firebase token: $token");
      } else {
        print("Firebase token is not available.");
      }
    } catch (e) {
      print("Error fetching Firebase token: $e");
    }
  } catch (e) {
    print("Error during Firebase Messaging initialization: $e");
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        var box = Hive.box<NotificationClass>("notificationList");
        box.add(NotificationClass(
            title: notification.title,
            body: notification.body,
            date: DateFormat('yyyy-MM-dd \n kk:mm:ss')
                .format(DateTime.now())
                .toString(),
            read: false));
      }

      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationControllerSelect>(
              create: (context) => sl<BottomNavigationControllerSelect>()),
          BlocProvider<TabShVerhController>(
              create: (context) => sl<TabShVerhController>()),
          BlocProvider<FilterCubit>(create: (context) => sl<FilterCubit>()),
          BlocProvider<FilterB2bCubit>(
              create: (context) => sl<FilterB2bCubit>()),
          BlocProvider<EventProgramByIdCubit>(
              create: (context) => sl<EventProgramByIdCubit>()),
          BlocProvider<SlidingQrCubit>(
              create: (context) => sl<SlidingQrCubit>()),
          BlocProvider<LangCubit>(
              create: (context) => sl<LangCubit>()..getlocale()),
          BlocProvider<SlidingAutgCubit>(
              create: (context) => sl<SlidingAutgCubit>()),
          BlocProvider<AuthCubit>(
              create: (context) => sl<AuthCubit>()..check()),
          BlocProvider<ProfilePageCubit>(
              create: (context) => sl<ProfilePageCubit>()..fetchProfilePage()),
          BlocProvider<FeedbackCubit>(create: (context) => sl<FeedbackCubit>()),
          // BlocProvider<ClaimPageCubit>(
          //     create: (context) => sl<ClaimPageCubit>()),
          // BlocProvider<ClaimDeleteCubit>(
          //     create: (context) => sl<ClaimDeleteCubit>()),
          BlocProvider<ClaimUpdateCubit>(
              create: (context) => sl<ClaimUpdateCubit>()),
          BlocProvider<EventProgramCubit>(
              create: (context) => sl<EventProgramCubit>()),
          BlocProvider<CheckTr>(create: (context) => sl<CheckTr>()),
          BlocProvider<PayedCubit>(
              create: (context) => sl<PayedCubit>()..check()),
          BlocProvider<TransportCubit>(
              create: (context) => sl<TransportCubit>()..feth()),
          BlocProvider<TransportTwoCubit>(
              create: (context) => sl<TransportTwoCubit>()),
          BlocProvider<NewsCubit>(create: (context) => sl<NewsCubit>()),
          BlocProvider<QrCubit>(create: (context) => sl<QrCubit>()),
          BlocProvider<EventProgramLiveCubit>(
              create: (context) =>
                  sl<EventProgramLiveCubit>()..fetchCategory()),
          BlocProvider<ShFilterNapolnitelCubit>(
              create: (context) => sl<ShFilterNapolnitelCubit>()..fetchCard()),
          BlocProvider<B2bFilterNapolnitelCubit>(
              create: (context) => sl<B2bFilterNapolnitelCubit>()..fetchCard()),
          BlocProvider<EventCulturProgramCubit>(
              create: (context) => sl<EventCulturProgramCubit>()..fetchCard2()),
          BlocProvider<SpeakersCubit>(
              create: (context) => sl<SpeakersCubit>()..fetchCard3()),
          BlocProvider<Checklivestream>(
              create: (context) => sl<Checklivestream>()),
          BlocProvider<FilterShCountController>(
              create: (context) => sl<FilterShCountController>()),
          BlocProvider<FilterB2bCountController>(
              create: (context) => sl<FilterB2bCountController>()),
          BlocProvider<B2bdCubit>(
              create: (context) => sl<B2bdCubit>()..check()),
          BlocProvider<B2bsendCubit>(create: (context) => sl<B2bsendCubit>()),
          BlocProvider<SearchInAppCubit>(
              create: (context) => sl<SearchInAppCubit>()..fetchlists()),
          BlocProvider<MaterialsCubit>(
              create: (context) => sl<MaterialsCubit>()..fetcMaterials()),
          BlocProvider<VotingCubit>(
              create: (context) => sl<VotingCubit>()..loadVoting()),
          BlocProvider<SlidingMapCubit>(
              create: (context) => sl<SlidingMapCubit>()),
          BlocProvider<EventProgramCategoryCubit>(
              create: (context) =>
                  sl<EventProgramCategoryCubit>()..fetchCategory()),
          BlocProvider<MapCubit>(
              create: (context) => sl<MapCubit>()..fetchTochki()),
          BlocProvider<PersonalscheduleCubit>(
              create: (context) => sl<PersonalscheduleCubit>()..fetchEvent()),
          BlocProvider<PartnersCubit>(create: (context) => sl<PartnersCubit>()),
          BlocProvider<B2bListCubit>(
              create: (context) => sl<B2bListCubit>()..fethb2b()),
          BlocProvider(
            create: (context) => B2bCubit(sl<B2bRepository>()),
            child: B2bPage(),
          ),   
          BlocProvider<CheckPSHtream>(create: (context) => sl<CheckPSHtream>()),
          BlocProvider<Checkspekearb2b>(
              create: (context) => sl<Checkspekearb2b>()),
          BlocProvider<MapVisibleCubit>(
              create: (context) =>
                  sl<MapVisibleCubit>()..fetchTochki(v: false)),
        ],
        child: BlocBuilder<LangCubit, Locale>(
          builder: (context, locale) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'KS',
            theme: theme(),
            locale: locale,
            localizationsDelegates: [
             AppLocalizations.delegate,
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate,
            ],
             supportedLocales: [
             const Locale('en', ''), // Английский
             const Locale('ru', ''), // Русский
             const Locale('zh', ''), // Китайский
            ],
             localeResolutionCallback: (locale, supportedLocales) {
              // Проверка, поддерживается ли локаль
               for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                 return supportedLocale;
                }
               }
                // Если не поддерживается, то по умолчанию будет использоваться английский
               return supportedLocales.first;
              },
            home: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, startstate) => Scaffold(body:
                        BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                      if (state is LoginedState) {
                        return Stack(
                          children: [
                            Management(),
                            SlidingFilter(),
                            SlidingQr()
                          ],
                        );
                      }
                      if (state is LogoutedState) {
                        return AuthPage();
                      }
                      return AuthPage();
                    }))),
            routes: <String, WidgetBuilder>{
              '/contactpage': (BuildContext context) => ContactsPage(),
              // '/eventpage': (BuildContext context) => EventPage(),
              '/speakerpage': (BuildContext context) => SpeakerPage(),
              '/newspage': (BuildContext context) => NewsPage(),
              '/notificationpage': (BuildContext context) => NotificationPage(),
              // '/notificationpageopen': (BuildContext context) =>
              //     NotificationPageOpen(),
              // '/speakerpageopen': (BuildContext context) => SpeakerPageOpen(),
              '/partnerspage': (BuildContext context) => PartnersPage(),
              '/transportpage': (BuildContext context) => TransportPage(),
              '/feedbackpage': (BuildContext context) => FeedbackPage(),
              '/settingsPage': (BuildContext context) => SettingsPage(),
              // '/claimpage': (BuildContext context) => ClaimPage(),
              // '/claimeditpage': (BuildContext context) => ClaimEditPage(),
              '/evantputpage': (BuildContext context) => EventPagePut(),
              '/main': (BuildContext context) => Management(),
              '/b2b': (BuildContext context) => B2bPage(),
              '/search': (BuildContext context) => SearchPage(),
              '/voiting': (BuildContext context) => VotingPage(),
              '/map': (BuildContext context) => MapPage(),
              '/profileedit': (BuildContext context) => ProfileEditPage(),
              '/mapinfo': (BuildContext context) => MapInfoPage(),
              '/usefulmaterials': (BuildContext context) =>
                  UsefulMaterialsPage(),
              '/authinfopage': (BuildContext context) => AuthInfoPage(),
            },
          ),
        ));
  }
}
