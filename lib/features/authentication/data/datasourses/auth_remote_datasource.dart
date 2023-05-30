import 'dart:convert';
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';


abstract class AuthenticationRemoteDatasource {
  Future<String> getSessionToken();
  String calculateSignature(String sessionToken);
  Future<String> getAccessToken(
      String deviceID, String sessionToken, String signature);
  Future<String> getDeviceInfo();
  Future<bool> checkUserExists();
}

class AuthenticationRemoteDatasourceImpl implements AuthenticationRemoteDatasource {
  final Dio dio = Dio();

  @override
  Future<String> getSessionToken() async {
    try {
      final response = await dio.post(
        API.apiSessionTokenAddress,
        options: buildOptions(),
        data: {'key': 'your_secret_key'},
      );

      if (response.statusCode == 200) {
        return response.data['data']['sessionToken'];
      } else {
        throw Future.error('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Future.error('Error: $e');
    }
  }

  @override
  String calculateSignature(String sessionToken) {
    final bytes = utf8.encode(sessionToken + API.secretKey);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<String> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
    return '';
  }

  @override
  Future<String> getAccessToken(
      String deviceID,
      String sessionToken,
      String signature,
      ) async {
    try {
      final response = await dio.post(
        API.apiAuthTokenAddress,
        options: buildOptions(),
        data: {
          'sessionToken': sessionToken,
          'signature': signature,
          'deviceID': deviceID,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data']['sessionToken'];
      } else {
        throw Future.error('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Future.error('Error: $e');
    }
  }

  @override
  Future<bool> checkUserExists() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      final response = await dio.post(
        API.apiUserAddress,
        options: buildOptions(authorization: 'Bearer $accessToken'),
      );

      if (response.statusCode == 200) {
        return response.data['success'];
      }
    } catch (e) {
      throw Future.error('Error: $e');
    }
    return false;
  }

  Options buildOptions({String? authorization}) {
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': 'uk',
        if (authorization != null) 'Authorization': authorization,
      },
    );
  }
}
