import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>>
  getUserJson(String accessToken, {Map<String, dynamic> newUserData=const {}});
}

class AccountRemoteDatasourseImpl implements AccountRemoteDatasourse{

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getUserJson(String accessToken, {Map<String, dynamic> newUserData=const{}}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    var response;
    if(newUserData.isEmpty) {
       response = await http.get(Uri.parse(API.apiUserAddress),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });
    }else{
      response = await http.post(Uri.parse(API.apiUserAddress),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',},
          body: jsonEncode({'name': '', 'phoneNumber': '+38098762543568'})
      );
    }
    if (response.statusCode == 200) {
    //  print(response.body);
      return Right(jsonDecode(response.body));
    }
   // print(response.statusCode);
    return const Left(AppError(AppErrorType.api));
  }
}