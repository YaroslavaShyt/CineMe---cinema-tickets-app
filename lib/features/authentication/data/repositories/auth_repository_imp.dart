import 'package:cine_me/core/usecases/shared_pref_access_token.dart';
import 'package:cine_me/features/authentication/data/datasourses/auth_remote_datasource.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/repositories/silent_authentication_repository.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository{
  final AuthenticationRemoteDatasource _authenticationRemoteDatasource;

  AuthenticationRepositoryImp(this._authenticationRemoteDatasource);

  @override
  Future<Either<AppError, bool>> loginUser() async {
    final sessionToken = await _authenticationRemoteDatasource.getSessionToken();
    try{
      final signature = _authenticationRemoteDatasource
          .calculateSignature(sessionToken);
      final deviceID = await _authenticationRemoteDatasource
          .getDeviceInfo();
      final accessToken = await _authenticationRemoteDatasource
          .getAccessToken(deviceID, sessionToken, signature);
      saveAccessToken(accessToken);
      return const Right(true);
    }catch (e){
      return Left(AppError('Не вдалося здійснити вхід., $e'));
    }
  }

  @override
  Future<Either<AppError, bool>> checkUserExists() async {
    try{
      final exists = await _authenticationRemoteDatasource.checkUserExists();
      return Right(exists);
    }catch(e){
      return Left(AppError('Такого користувача не існує. $e'));
    }
  }
  
}