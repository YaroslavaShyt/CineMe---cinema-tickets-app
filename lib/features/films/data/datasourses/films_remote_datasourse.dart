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
  Future<Either<AppError, Map<String, dynamic>>>
  buyTicket(String accessToken, int sessionId, List<int> seats,
      String email, String cardNumber, String expirationDate, String cvv);
}

class FilmsRemoteDatasourseImpl implements FilmsRemoteDatasourse{

  @override
  String getDateTimeNow(){
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String accessToken, {String search = ''}) async {
    String formattedDate = getDateTimeNow();
    var request = '${API.apiFilmsAddress}?date=$formattedDate&query=$search';
    if(search.isNotEmpty){
      request = '${API.apiFilmsAddress}?query=$search';
    }
    final response = await http.get(Uri.parse(request),
        headers: {
      'Authorization': 'Bearer $accessToken',
          'Accept-Language': 'uk'});
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
    final response = await http.get(Uri.parse('${API.apiFilmSessionAddress}$request'),
        headers: {'Authorization': 'Bearer $accessToken',
          'Accept-Language': 'uk'});
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      return Right(data);
    }
    return const Left(AppError(AppErrorType.network));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  bookTicket(String accessToken, int sessionId, List<int> seats) async{
    final response = await http.post(Uri.parse(API.apiFilmBookAddress),
        headers: {'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
          'Accept-Language': 'uk'},
        body: jsonEncode({
          'seats': seats,
          'sessionId': sessionId
        })
    );
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(data['success'] == true && data['data'] == true){
        return Right(data);
      }
    }
    return const Left(AppError(AppErrorType.api));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  buyTicket(String accessToken,
      int sessionId,
      List<int> seats,
      String email,
      String cvv,
      String cardNumber,
      String expirationDate,
     ) async{

    final response = await http.post(Uri.parse(API.apiFilmBuyAddress),
           headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
             'Accept-Language': 'uk'},
           body: jsonEncode({
              'sessionId': sessionId,
              'seats': seats,
              'email': email,
              'cardNumber': cardNumber.toString(),
              'expirationDate': expirationDate,
              'cvv': cvv
           })
    );
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(data['success'] == true){
        return Right(data);
      }
    }
    return const Left(AppError(AppErrorType.api));
  }
}
