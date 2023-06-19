import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cine_me/core/usecases/get_today_date.dart';
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';

abstract class FilmsRemoteDataSource{
  Future<Either<AppError, Map<String, dynamic>>>
  getTodayFilmsJson(String localization, String accessToken, {String search = ''});
  Future<Either<AppError, Map<String, dynamic>>>
  getFilmSessionsJson(String accessToken, {String filmId='', String sessionId=''});

  Future<Either<AppError, Map<String, dynamic>>>
  bookTicket(String accessToken, int sessionId, List<int> seats);
  Future<Either<AppError, Map<String, dynamic>>>
  buyTicket(String accessToken, int sessionId,List<int> seats,
      String email, String cardNumber, String expirationDate, String cvv);

  Future<Either<AppError, Map<String, dynamic>>>
  getFilmCommentsJson(String localization, String accessToken, String filmId);
}

class FilmsRemoteDataSourceImpl implements FilmsRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<Either<AppError, Map<String, dynamic>>> getFilmCommentsJson(
      String localization, String accessToken, String filmId) async{
    try {
    final response = await dio.get(
      '${API.apiFilmComments}?movieId=$filmId',
      options: buildOptions(accessToken, localization),
    );

    print('status code ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data;
        print(data);
        return Right(data);
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return const Left(AppError('Не вдалося отримати дані про коменти.'));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> getTodayFilmsJson(
      String localization, String accessToken, {String search = ''}) async {
    String formattedDate = getDateTimeNow();
    String request = '${API.apiFilmsAddress}?date=$formattedDate&query=$search';
    if (search.isNotEmpty) {
      request = '${API.apiFilmsAddress}?query=$search';
    }
    try {
      final response = await dio.get(
        request,
        options: buildOptions(accessToken, localization),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return Right(data);
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return const Left(AppError('Не вдалося отримати дані про .'));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> getFilmSessionsJson(
      String accessToken ,
      {String filmId = '', String sessionId = ''}) async {
    String request;
    String formattedDate = getDateTimeNow();
    if (sessionId.isEmpty && filmId.isNotEmpty) {
      request = '?movieId=$filmId&date=$formattedDate';
    } else {
      request = '/$sessionId';
    }
    try {
      final response = await dio.get(
        '${API.apiFilmSessionAddress}$request',
        options: buildOptions(accessToken, 'en'),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return Right(data);
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return const Left(AppError('Не вдалося отримати дані про сеанси.'));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> bookTicket(
      String accessToken, int sessionId ,  List<int> seats) async {
    try {
      final response = await dio.post(
        API.apiFilmBookAddress,
        options: buildOptions(accessToken, 'en'),
        data: {
          'seats': seats,
          'sessionId': sessionId,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] == true) {
          return Right(data);
        }
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return const Left(AppError('Не вдалося забронювати квиток.'));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> buyTicket(
      String accessToken,
      int sessionId,
      List<int> seats,
      String email,
      String cvv,
      String cardNumber,
      String expirationDate,
      ) async {
    try {
      final response = await dio.post(
        API.apiFilmBuyAddress,
        options: buildOptions(accessToken, 'en'),
        data: {
          'sessionId': sessionId,
          'seats': seats,
          'email': email,
          'cardNumber': cardNumber.toString(),
          'expirationDate': expirationDate,
          'cvv': cvv,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          return Right(data);
        }
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return const Left(AppError('Не вдалося придбати квиток.'));
  }

  Options buildOptions(String accessToken, String localization) {
    return Options(
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': localization,
      },
    );
  }
}
