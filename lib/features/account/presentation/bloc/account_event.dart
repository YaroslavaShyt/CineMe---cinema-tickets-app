part of 'account_bloc.dart';


abstract class AccountEvent extends Equatable{
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountInitiateEvent extends AccountEvent {
  final String search;
  const AccountInitiateEvent({this.search = ''});

  @override
  List<Object> get props => [];
}
