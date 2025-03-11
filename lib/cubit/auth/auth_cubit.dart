
// import 'dart:convert';

// import 'package:eventssytem/cubit/locator_services.dart';
// import 'package:eventssytem/cubit/auth/app_auth.dart';
// import 'package:eventssytem/cubit/auth/auth_state.dart';

// import 'package:flutter_appauth/flutter_appauth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class AuthCubit extends Cubit<AuthState> {
//   //final SubscriptionRepository subscriptionRepository;

//   final FlutterAppAuth appAuth = sl<FlutterAppAuth>();
//   final FlutterSecureStorage secureStorage = sl<FlutterSecureStorage>();
//   final SharedPreferences sharedPreferences = sl<SharedPreferences>();

//   final String accessTokenKey = 'access_token';
//   final String refreshTokenKey = 'refresh_token';
//   final String accessTokenExpirationDateTimeKey =
//       'access_token_expiration_date_time';
//   final String idTokenKey = 'id_token';

//   AuthCubit() : super(EmptyState());

//   Future<void> check() async {
//     //   if (state is InProcessState) return;

//     final currentState = state;

//     if (currentState is LoginedState) {
//       return;
//     }

//     print("1");
//     //   emit(InProcessState());

//     final storedRefreshToken = await secureStorage.read(key: refreshTokenKey);
//     final storedAccessToken = await secureStorage.read(key: accessTokenKey);

//     if (storedRefreshToken == null) {
//       print("2");
//       emit(LogoutedState());
//       return;
//     }
//     if (storedAccessToken == null) {
//       print("3");
//       refresh();
//       return;
//     }
//     AppAuth.accessToken = storedAccessToken;

//     emit(LoginedState());
//   }

//   Future<void> refresh() async {
//     try {
//       final storedRefreshToken = await secureStorage.read(key: refreshTokenKey);
//       final TokenResponse? result = await appAuth
//           .token(TokenRequest(AppAuth.clientId, AppAuth.redirectUrl,
//               refreshToken: storedRefreshToken,
//               discoveryUrl: AppAuth.discoveryUrl,
//               //issuer: AppAuth.issuer,
//               scopes: AppAuth.scopes));

//       await saveTokens(result!.accessToken, result.refreshToken, result.idToken,
//           result.accessTokenExpirationDateTime);

//       final idToken = _parseIdToken(result.idToken!);
//       final profile = await _getUserDetails(result.accessToken!);

//       final userName = idToken['name'];
//       //picture = profile['picture'];
//     } catch (e, s) {
//       print('error on refresh token: $e - stack: $s');
//       logOut();
//     }
//   }

//   Future<void> logOut() async {
//     print("object");
//     final idTokenHint = await sharedPreferences.getString(idTokenKey);

//     print("idTokenHint: $idTokenHint");

//     //  emit(InProcessState());
//     print("Logout");
//     await secureStorage.delete(key: refreshTokenKey);
//     await secureStorage.delete(key: accessTokenKey);
//     await sharedPreferences.remove(accessTokenExpirationDateTimeKey);
//     await sharedPreferences.remove(idTokenKey);
//     AppAuth.accessToken = null;

//     await appAuth.endSession(EndSessionRequest(
//         idTokenHint: idTokenHint,
//         postLogoutRedirectUrl: 'com.eventssytem.mobile:/logout',
//         serviceConfiguration: AuthorizationServiceConfiguration(
//             authorizationEndpoint:
//                 'https://passport-ks.maksatlabs.ru/connect/authorize',
//             endSessionEndpoint:
//                 'https://passport-ks.maksatlabs.ru/connect/logout',
//             tokenEndpoint: 'https://passport-ks.maksatlabs.ru/connect/token')));
//     emit(LogoutedState());
//     print("Logout ended");
//   }

//   Future<void> signIn() async {
//     print("signIn");
//     //  if (state is InProcessState) return;

//     final currentState = state;

//     print("state in sign = $state");

//     if (currentState is LoginedState) {}

//     //emit(InProcessState());
//     print("result");
//     print(
//       AppAuth.clientId,
//     );
//     print(
//       AppAuth.redirectUrl,
//     );

//     final AuthorizationTokenResponse? result =
//         await appAuth.authorizeAndExchangeCode(
//       AuthorizationTokenRequest(
//         AppAuth.clientId,
//         AppAuth.redirectUrl,
//         //clientSecret: AppAuth.clientSecret,
//         serviceConfiguration: AppAuth.serviceConfiguration,
//         scopes: AppAuth.scopes,

//         //preferEphemeralSession: preferEphemeralSession,
//       ),
//     );

//     // this code block demonstrates passing in values for the prompt parameter. in this case it prompts the user login even if they have already signed in. the list of supported values depends on the identity provider
//     // final AuthorizationTokenResponse result = await _appAuth.authorizeAndExchangeCode(
//     //   AuthorizationTokenRequest(_clientId, _redirectUrl,
//     //       serviceConfiguration: _serviceConfiguration,
//     //       scopes: _scopes,
//     //       promptValues: ['login']),
//     // );
//     print("result = $result");
//     if (result == null) {
//       emit(ErrorState("undefined"));
//     } else {
//       await saveTokens(result.accessToken, result.refreshToken, result.idToken,
//           result.accessTokenExpirationDateTime);
//       print("accessToken = ${result.accessToken}");
//       print("idToken = ${result.idToken}");

//       String yourToken = "${result.accessToken}";
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
//       print(decodedToken);
//     }

//     emit(LoginedState());
//   }

//   Map<String, dynamic> _parseIdToken(String idToken) {
//     final parts = idToken.split(r'.');
//     assert(parts.length == 3);

//     return jsonDecode(
//         utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
//   }

//   Future<Map<String, dynamic>> _getUserDetails(String accessToken) async {
//     final url = 'https://${AppAuth.issuer}/userinfo';
//     final response = await http.get(
//       Uri.parse(url),
//       headers: {'Authorization': 'Bearer $accessToken'},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to get user details');
//     }
//   }

//   Future<void> saveTokens(String? accessToken, String? refreshToken,
//       String? idToken, DateTime? accessTokenExpirationDateTime) async {
//     try {
//       print("refreshToken $refreshToken");
//       await secureStorage.write(key: refreshTokenKey, value: refreshToken);
//       await secureStorage.write(key: accessTokenKey, value: accessToken);
//       //   await secureStorage.write(key: idTokenKey, value: idToken);
//       AppAuth.accessToken = accessToken;
//     } catch (error, ee) {
//       print(error);
//       print(ee);
//     }

//     try {
//       await sharedPreferences.setString(accessTokenExpirationDateTimeKey,
//           accessTokenExpirationDateTime.toString());
//       await sharedPreferences.setString(idTokenKey, idToken!);
//     } catch (error, ee) {
//       print(error);
//       print(ee);
//     }
//   }
// }

