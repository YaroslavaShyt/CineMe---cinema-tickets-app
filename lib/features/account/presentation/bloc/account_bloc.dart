import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState>{
  final Account account;
  final Map<String, dynamic> newUserData;

  AccountBloc({required this.account, this.newUserData=const{}}):
  super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async*{
    if(event is AccountInitiateEvent){
     // print('in bloc before account');
      final response = await account(newUserData: newUserData);
     // print('in bloc after account');
      yield response.fold((l){
        return const AccountError('error');
      }, (r)=> AccountSuccess(r));
    }else{
      print('it is not initial films');
    }
  }
}