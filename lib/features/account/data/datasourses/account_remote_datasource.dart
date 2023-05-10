import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>>
  getUserJson(String accessToken, {Map<String, dynamic> newUserData=const {}});
  Future<Either<AppError, Map<String, dynamic>>>
  getUserTicketsJson(String accessToken);
}

class AccountRemoteDatasourseImpl implements AccountRemoteDatasourse{

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getUserJson(String accessToken, {Map<String, dynamic> newUserData=const{'name': '', 'phoneNumber': ''}}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    print('in the beginning');
    var response;
    var data;
    if(newUserData['name'].isEmpty && newUserData['phoneNumber'].isEmpty) {
       response = await http.get(Uri.parse(API.apiUserAddress),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
            'Accept-Language': 'uk'
          });
    }else{
      if(newUserData['name'].isNotEmpty && newUserData['phoneNumber'].isNotEmpty){
        data = {'name': newUserData['name'], 'phoneNumber': newUserData['phoneNumber']};
      }
      else if(newUserData['name'].isEmpty && newUserData['phoneNumber'].isNotEmpty){
        data = {'phoneNumber': newUserData['phoneNumber']};
      }
      else if(newUserData['name'].isNotEmpty && newUserData['phoneNumber'].isEmpty){
        data = {'name': newUserData['name']};
      }
      response = await http.post(Uri.parse(API.apiUserAddress),
          headers: {
            'Accept-Language': 'uk',
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',},
          body: jsonEncode(data)
      );
    }
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body));
    }
    return const Left(AppError(AppErrorType.api));
  }

  @override
  Future <Either<AppError, Map<String, dynamic>>>
  getUserTicketsJson(String accessToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    final response = await http.get(Uri.parse(API.apiUserTicketsAddress),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': 'uk'
        });
    if(response.statusCode==200){
      final elseData = jsonDecode(response.body);
      if(elseData['success'] == true){
        return Right(elseData);
      }
    }
    return const Left(AppError(AppErrorType.api));
  }
}