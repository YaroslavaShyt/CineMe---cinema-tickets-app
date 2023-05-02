import 'package:cine_me/features/account/data/models/user_model.dart';
import 'package:cine_me/features/account/domain/repository/account_repository.dart';
import 'package:cine_me/features/account/domain/usecases/usecase.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:dartz/dartz.dart';

class Account implements UseCaseAccount{
  final AccountRepository _accountRepository;

  Account(this._accountRepository);

  @override
  Future<Either<AppError, UserModel>> call({Map<String, dynamic> newUserData=const {}}) async=>
      _accountRepository.getAccountData(newUserData: newUserData);
}