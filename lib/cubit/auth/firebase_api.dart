import 'package:http/http.dart' as http;
import 'package:eventssytem/cubit/auth/login_auth.dart';
import 'package:eventssytem/other/other.dart';

class FireBaseApi {
  Future<void> putToken() async {
    Map<String, String> headers = {"content-type": "application/json"};

    if (AppAuth.accessToken != null && AppAuth.accessToken!.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer ${AppAuth.accessToken}'});
    }

    final response = await http.patch(
        Uri.parse(
            "${ConstantsClass.url}/api/push/mobiletoken?token=${AppAuth.firebasetoken}"),
        headers: headers);

    print("FireBaseApi - ${response.body}");

    if (response.statusCode == 200) {
      print("FireBaseApi - f");
    } else {
      throw Exception('Error putToken');
    }
  }
}
