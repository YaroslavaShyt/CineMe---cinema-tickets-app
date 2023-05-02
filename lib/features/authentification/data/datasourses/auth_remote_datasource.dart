import 'dart:convert';
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Build, Platform;


abstract class AuthenticationRemoteDatasource {
  Future<String> getSessionToken();
  String calculateSignature(String sessionToken);
  Future<String> getAccessToken(
      String deviceID, String sessionToken, String signature);
  Future<String> getDeviceInfo();
  Future<bool> checkUserExists();
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  @override
  Future<String> getSessionToken() async {
    final response = await http.post(Uri.parse(API.apiSessionTokenAddress),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'key': 'your_secret_key'}));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
  //    print('SESSION TOKEN BODY: ${response.body}');
  //    print('SESSION TOKEN: ${data['data']['sessionToken']}');
      return data['data']['sessionToken'];
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  @override
  String calculateSignature(String sessionToken) {
    var bytes = utf8.encode(sessionToken + API.secretKey);
    var digest = sha256.convert(bytes);
  //  print(digest);
    return digest.toString();
  }

  @override
  Future<String> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //    print(androidInfo.id);
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? '';
      }
    } catch (e) {
      print('Error getting device info: $e');
    }
    return 'empty string';
  }


  @override
  Future<String> getAccessToken(
      String deviceID, String sessionToken, String signature) async {
    var response = await http.post(Uri.parse(API.apiAuthTokenAddress),
        body: jsonEncode({
          'sessionToken': sessionToken,
          'signature': signature,
          'deviceID': deviceID
        }),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
 //     print('access token: ${jsonDecode(response.body)['data']['accessToken']}');
  //    print('code: ${response.statusCode}');
  //    print('ACCESS TOKEN: ${jsonDecode(response.body)['data']['sessionToken']}');
      return jsonDecode(response.body)['data']['sessionToken'];
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  @override
  Future<bool> checkUserExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    var response = await http.post(Uri.parse(API.apiUserAddress),
    headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (response.statusCode == 200) {
        print(response.body);
      return jsonDecode(response.body)['success'];
    }
  //  print(response.statusCode);
    return false;
  }
}
