import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';

abstract class FilmsRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String accessToken, {String search = ''});
  Future<Either<AppError, Map<String, dynamic>>>
  getFilmSessionsJson(String accessToken, {String filmId='', String sessionId=''});
  String getDateTimeNow();
  Future<Either<AppError, Map<String, dynamic>>>
  bookTicket(String accessToken, int sessionId, List<int> seats);
}

class FilmsRemoteDatasourseImpl implements FilmsRemoteDatasourse{
  //move out?
  @override
  String getDateTimeNow(){
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String accessToken, {String search = ''}) async {
    String formattedDate = getDateTimeNow();
    final response = await http.get(Uri.parse('${API.apiFilmsAddress}?date=$formattedDate&query=$search'),
        headers: {'Authorization': 'Bearer $accessToken'});
  //  print('statusCode: ${response.statusCode}');
  //  print('responseBody: ${response.body}');
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      return Right(data);
      }
    return const Left(AppError(AppErrorType.network));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getFilmSessionsJson(String accessToken, {String filmId='', String sessionId=''}) async{
    var request;
    String formattedDate = getDateTimeNow();
    sessionId.isEmpty && filmId.isNotEmpty?
    request = '?movieId=${filmId}date=$formattedDate':
      request = '/$sessionId';
  //  print('session id: $sessionId');
    final response = await http.get(Uri.parse('${API.apiFilmSessionAddress}$request'),
        headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
    //  print('got session: ${data['data'][0]}');
    //  print('got session2:${data['data'][1]}');
    //  print('for each now (datalength: ${data.length}):\n');
    /*  for (var i = 0; i< data.length; i++){
        print(data['data']['room']);
      }*/
      return Right(data);
    }
    return const Left(AppError(AppErrorType.network));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  bookTicket(String accessToken, int sessionId, List<int> seats) async{
 //   print(accessToken);
 //   print('session id: ${sessionId}\ntype: ${sessionId is int}');
 //   print('seats: ${seats}\n${seats is List<int>}');
 //   print(jsonEncode({'seats': seats, 'sessionID':sessionId}));
    final response = await http.post(Uri.parse(API.apiFilmBookAddress),
        headers: {'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'},
        body: jsonEncode({
          'seats': seats,
          'sessionId': sessionId
        })
    );
  //  print(response.statusCode);
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
   //   print(data);
      if(data['success'] == true && data['data'] == true){
        return Right(data);
      }
    }
    return const Left(AppError(AppErrorType.api));
  }
}
