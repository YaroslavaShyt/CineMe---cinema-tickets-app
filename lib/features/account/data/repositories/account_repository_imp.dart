import 'package:cine_me/features/account/data/datasourses/account_remote_datasource.dart';
import 'package:cine_me/features/account/data/models/user_model.dart';

import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/shared_pref_access_token.dart';
import '../../domain/repository/account_repository.dart';

class AccountRepositoryImp implements AccountRepository{
  final AccountRemoteDatasourse _accountRemoteDatasourse;

  AccountRepositoryImp(this._accountRemoteDatasourse);


  @override
  Future<Either<AppError, UserModel>> getAccountData({Map<String, dynamic> newUserData = const {}}) async{
    final accessToken = await getAccessToken();
    final data = await _accountRemoteDatasourse.getUserJson(accessToken, newUserData: newUserData);
    if (data.isRight()){
      final elseData = data.getOrElse(() => {});
      if (elseData != {}){
        final mapData = elseData['data'];
        return Right(UserModel(name: mapData['name'], phoneNumber: mapData['phoneNumber']));
      }
    }
    return const Left(AppError(AppErrorType.api));
  }

}