import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../authentification/domain/entities/app_error_entity.dart';

abstract class FilmsRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String accessToken, {String search = ''});
  Future<Either<AppError, Map<String, dynamic>>>
  getFilmSessionsJson(String filmId, String accessToken);
}

class FilmsRemoteDatasourseImpl implements FilmsRemoteDatasourse{

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String accessToken, {String search = ''}) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
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
  getFilmSessionsJson(String filmId, String accessToken) async{
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final response = await http.get(Uri.parse('${API.apiFilmSessionAddress}?movieId=${filmId}date=$formattedDate'),
        headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      print('got sessions: ${data}');
      return Right(data);
    }
    return const Left(AppError(AppErrorType.network));
  }

}
