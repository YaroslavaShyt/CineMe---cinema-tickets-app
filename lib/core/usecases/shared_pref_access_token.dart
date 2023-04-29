import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveAccessToken(String sessionToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', sessionToken);
}


Future<bool> hasAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('accessToken');
}


Future<String> getAccessToken() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken')!;
}