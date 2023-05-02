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
    var response;
    print('error is here, ${newUserData['name']}');
    if(newUserData['name'].isEmpty && newUserData['phoneNumber'].isEmpty) {
      print('works');
       response = await http.get(Uri.parse(API.apiUserAddress),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });
    }else{
      print('have data: ${newUserData}');
      response = await http.post(Uri.parse(API.apiUserAddress),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',},
          body: jsonEncode({'name': newUserData['name'], 'phoneNumber': newUserData['phoneNumber']})
      );
    }
    if (response.statusCode == 200) {
      print('in datasourse: ${response.body}');
      return Right(jsonDecode(response.body));
    }
   // print(response.statusCode);
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
        });
    if(response.statusCode==200){
      final elseData = jsonDecode(response.body);
      if(elseData['success'] == true){
        print('else data: $elseData');
        return Right(elseData);
      }
    }
    return const Left(AppError(AppErrorType.api));
  }
}