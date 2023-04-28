import 'dart:convert';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../authentification/domain/entities/app_error_entity.dart';

abstract class FilmsRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>> getTodayFilmsJson(String date, String search);
}

class FilmsRemoteDatasourseImpl implements FilmsRemoteDatasourse{
  Future<Either<AppError, Map<String, dynamic>>> getTodayFilmsJson(String date, String search) async {
    final response = await http.post(Uri.parse('${API.apiFilmsAddress}?date=$date&query=$search'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      return Right(data);
      }
    return const Left(AppError(AppErrorType.network));
  }
}
