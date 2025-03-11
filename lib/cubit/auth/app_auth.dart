// import 'package:flutter_appauth/flutter_appauth.dart';

// class AppAuth {
//   bool _isBusy = false;
//   final FlutterAppAuth _appAuth = FlutterAppAuth();
//   static const String clientId = "mobile";
//   static const String redirectUrl = "com.eventssytem.mobile:/auth";
//   static const String issuer = 'https://passport-ks.maksatlabs.ru/';
//   static const String discoveryUrl =
//       'https://passport-ks.maksatlabs.ru/.well-known/openid-configuration';
//   static const List<String> scopes = <String>[
//     'openid',
//     // 'profile',
//     // 'email',
//     // 'roles',
//     'offline_access',
//     'demo_api'
//   ];

//   static String? accessToken;
// //  static String? refreshToken;
//   static String? userInfo;
//   static String? userName;
// //  static String? idToken;
// //  static DateTime? accessTokenExpirationDateTime;

//   static AuthorizationServiceConfiguration serviceConfiguration =
//       // ignore: prefer_const_constructors
//       AuthorizationServiceConfiguration(
//           authorizationEndpoint:
//               'https://passport-ks.maksatlabs.ru/connect/authorize',
//           tokenEndpoint: 'https://passport-ks.maksatlabs.ru/connect/token',
//           endSessionEndpoint:
//               "https://passport-ks.maksatlabs.ru/connect/logout");
// }
