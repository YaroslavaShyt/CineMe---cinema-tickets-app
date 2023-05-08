import 'package:cine_me/features/account/data/datasourses/account_remote_datasource.dart';
import 'package:cine_me/features/account/data/models/ticket_model.dart';
import 'package:cine_me/features/account/data/models/user_model.dart';

import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/shared_pref_access_token.dart';
import '../../domain/repository/account_repository.dart';

class AccountRepositoryImp implements AccountRepository{
  final AccountRemoteDatasourse _accountRemoteDatasourse;

  AccountRepositoryImp(this._accountRemoteDatasourse);


  @override
  Future<Either<AppError, UserModel>>
  getAccountData({Map<String, dynamic> newUserData = const {'name': '', 'phoneNumber': ''}}) async{
    final accessToken = await getAccessToken();
    final data = await _accountRemoteDatasourse.getUserJson(accessToken, newUserData: newUserData);
    if (data.isRight()){
      final elseData = data.getOrElse(() => {});
      if (elseData != {}){
        final mapData = elseData['data'];
        if(mapData['name'] == null || mapData['phoneNumber'] == null){
          mapData['name'] = 'Anonymus';
          mapData['phoneNumber'] = '+000000000000';
        }
        return Right(UserModel(name: mapData['name'], phoneNumber: mapData['phoneNumber']));
      }
    }
    return const Left(AppError(AppErrorType.api));
  }

  @override
  Future<Either<AppError, List<TicketModel>>>
  getUserTickets()async{
    List<TicketModel> ticketsList = [];
    final accessToken = await getAccessToken();
    final data = await _accountRemoteDatasourse.getUserTicketsJson(accessToken);
    if(data.isRight()){
      final elseData = data.getOrElse(() => {});
      if (elseData != {}){
        final mapData = elseData['data'];
        for (var i = 0; i < mapData.length; i++){
          ticketsList.add(TicketModel(
              id: mapData[i]['id'],
              movieId: mapData[i]['movieId'],
              name: mapData[i]['name'],
              image: mapData[i]['image'],
              smallImage: mapData[i]['smallImage'],
              date: mapData[i]['date']
          ));
        }
        print(ticketsList);
        return Right(ticketsList);
      }
    }
    return const Left(AppError(AppErrorType.api));
  }
}