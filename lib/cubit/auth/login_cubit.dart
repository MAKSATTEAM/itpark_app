import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:eventssytem/cubit/auth/firebase_api.dart';
import 'package:eventssytem/cubit/auth/login_auth.dart';
import 'package:eventssytem/cubit/auth/login_state.dart';
import 'package:http/http.dart' as http;
import 'package:eventssytem/cubit/locator_services.dart';
import 'package:eventssytem/other/other.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(EmptyState());
  final FlutterSecureStorage secureStorage = sl<FlutterSecureStorage>();
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();

////*Авторизация

  Future<void> signIn(String login, String pass) async {
    Map<String, String> headers = {"content-type": "application/json"};
    Map<String, String> body = {"userName": login, "password": pass};
    final response = await http.post(
        Uri.parse("${ConstantsClass.url}/api/mobile/token"),
        headers: headers,
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      var kk = jsonDecode(response.body);
      AppAuth.accessToken = kk["access_token"].toString();
      AppAuth.participantId = kk["participantId"].toString();
      AppAuth.finishTime = kk["finish"].toString();
      AppAuth.eventId = kk["eventId"].toString();

      FireBaseApi().putToken();

      saveTokens();
      emit(LoginedUPDState());
      emit(LoginedState());
    } else {
      dynamic locale = sharedPreferences.getString("locale");
      String localeName =
          locale[0].toUpperCase() + locale.substring(1).toLowerCase();
      try {
        var kk2 = jsonDecode(utf8.decode(response.bodyBytes));
        emit(ErrorState(kk2[localeName]));
      } catch (e) {
        emit(ErrorState("Error"));
      }
    }
  }

////*Восстановление пароля

  Future<void> forgotPassword(String login, String email) async {
    Map<String, String> headers = {"content-type": "application/json"};
    Map<String, String> body = {"username": login, "email": email};

    final response = await http.post(
        Uri.parse("${ConstantsClass.url}/api/forgot-password"),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      emit(ForgotPasswordState());
    } else {
      dynamic locale = sharedPreferences.getString("locale");
      String localeName =
          locale[0].toUpperCase() + locale.substring(1).toLowerCase();
      try {
        var kk2 = jsonDecode(utf8.decode(response.bodyBytes));
        emit(ErrorState(kk2[localeName]));
      } catch (e) {
        emit(ErrorState("Error"));
      }
    }
  }

////*Выход
  Future<void> logOut() async {
    await secureStorage.delete(key: "accessToken");
    await secureStorage.delete(key: "participantId");
    await sharedPreferences.remove("finishTime");
    await sharedPreferences.remove("eventId");

    emit(LogoutedState());
  }

////*Проверка - живой ли токен
  Future<void> check() async {
    AppAuth.accessToken = await secureStorage.read(key: "accessToken");
    AppAuth.participantId = await secureStorage.read(key: "participantId");
    AppAuth.finishTime = sharedPreferences.getString("finishTime");
    AppAuth.eventId = sharedPreferences.getString("eventId");

    final currentState = state;

    if (currentState is LoginedState) {
      return;
    }

    if (AppAuth.accessToken == null) {
      emit(LogoutedState());
      return;
    }

    if (AppAuth.participantId == null) {
      emit(LogoutedState());
      return;
    }

    final now = DateTime.now();
    DateTime finishDate = DateTime.parse(AppAuth.finishTime!);

    if (now.millisecondsSinceEpoch >= finishDate.millisecondsSinceEpoch) {
      await logOut();
      print("dsds $state");
      return;
    }
    emit(LoginedState());
  }

////*Сохранение токена
  Future<void> saveTokens() async {
    await secureStorage.write(key: "accessToken", value: AppAuth.accessToken);
    await secureStorage.write(
        key: "participantId", value: AppAuth.participantId);
    await sharedPreferences.setString(
        "finishTime", AppAuth.finishTime.toString());
    await sharedPreferences.setString("eventId", AppAuth.eventId.toString());
  }
}
