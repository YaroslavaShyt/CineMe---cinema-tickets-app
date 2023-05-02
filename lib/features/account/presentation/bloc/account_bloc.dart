import 'package:cine_me/features/account/data/models/ticket_model.dart';
import 'package:cine_me/features/account/domain/usecases/get_user_tickets.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState>{
  final Account account;
  final Tickets tickets;
  final Map<String, dynamic> newUserData;

  AccountBloc({required this.account, required this.tickets, this.newUserData=const{}}):
  super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async*{
    if(event is AccountInitiateEvent){
     // print('in bloc before account');
      print('in bloc: ${event.newUserData}');
      final response = await account(newUserData: event.newUserData);
      final ticketsResponse = await tickets();
     // print('in bloc after account');
      yield* response.fold((l){
        return Stream.value(const AccountError('error'));
      }, (r)=> Stream.fromIterable([AccountSuccess(r, ticketsResponse)]));
    }
  }
}