import 'dart:convert';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../authentification/domain/entities/app_error_entity.dart';

abstract class FilmsRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String date, String search, String accessToken);
}

class FilmsRemoteDatasourseImpl implements FilmsRemoteDatasourse{

  @override
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String date, String search, String accessToken) async {
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
}
