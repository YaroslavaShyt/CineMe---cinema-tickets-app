import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cine_me/core/constants/api_constants.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';

abstract class AccountRemoteDataSource {
  Future<Either<AppError, Map<String, dynamic>>> getUserJson(
      String accessToken, {
        Map<String, dynamic> newUserData = const {},
      });

  Future<Either<AppError, Map<String, dynamic>>> getUserTicketsJson(
      String accessToken,
      );
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<Either<AppError, Map<String, dynamic>>> getUserJson(String accessToken,
      {
        Map<String, dynamic> newUserData = const {
          'name': '',
          'phoneNumber': ''
        },
      }) async {
    var options = Options(
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );

    Map<String, String> data = {};
    if (newUserData['name'].isEmpty && newUserData['phoneNumber'].isEmpty) {
      try {
        var response = await dio.get(
          API.apiUserAddress,
          options: options,
        );
        if (response.statusCode == 200) {
          return Right(response.data);
        }
      } catch (error) {
        return Left(AppError('Error: $error'));
      }
    } else {
      data = {
        if (newUserData['name'].isNotEmpty) 'name': newUserData['name'],
        if (newUserData['phoneNumber'].isNotEmpty)
          'phoneNumber': newUserData['phoneNumber'],
      };
      try {
        var response = await dio.post(
          API.apiUserAddress,
          options: options,
          data: data,
        );
        if (response.statusCode == 200) {
          return Right(response.data);
        }
      } catch (error) {
        return Left(AppError('Error: $error'));
      }
    }
    return const Left(AppError('Не вдалося отримати дані про користувача.'));
  }

  @override
  Future<Either<AppError, Map<String, dynamic>>> getUserTicketsJson(
      String accessToken) async {
    var options = Options(
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'Accept-Language': 'uk',
      },
    );
    try {
      var response = await dio.get(
        API.apiUserTicketsAddress,
        options: options,
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        return Right(response.data);
      } else {
        return Left(AppError('Error: ${response.statusCode}'));
      }
    } catch (error) {
      return Left(AppError('Error: $error'));
    }
  }
}