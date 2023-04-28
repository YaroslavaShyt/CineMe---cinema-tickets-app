import 'package:cine_me/core/usecases/shared_pref_access_token.dart';
import 'package:cine_me/features/authentification/data/datasourses/auth_remote_datasource.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/silent_authentication_repository.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository{
  final AuthenticationRemoteDatasource _authenticationRemoteDatasource;

  AuthenticationRepositoryImp(
      this._authenticationRemoteDatasource
      );

  @override
  Future<Either<AppError, bool>> loginUser() async {
    final sessionToken = await _authenticationRemoteDatasource.getSessionToken();
    try{
      final signature = _authenticationRemoteDatasource.calculateSignature(sessionToken);
      final deviceID = await _authenticationRemoteDatasource.getDeviceInfo();
      final accessToken = await _authenticationRemoteDatasource.getAccessToken(deviceID, sessionToken, signature);
      print('access token in login user: $accessToken');
      saveAccessToken(accessToken);
      return const Right(true);
    }catch (e){
      print('error in login user: $e');
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> checkUserExists() async {
    try{
      final exists = await _authenticationRemoteDatasource.checkUserExists();
      return Right(exists);
    }catch(e){
      print('error user exists: $e');
      return const Left(AppError(AppErrorType.sessionDenied));
    }
  }
  
}