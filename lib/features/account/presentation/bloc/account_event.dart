part of 'account_bloc.dart';


abstract class AccountEvent extends Equatable{
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountInitiateEvent extends AccountEvent {
  final Map<String, dynamic> newUserData;
  final String localization;
  const AccountInitiateEvent({this.newUserData = const {'name':'', 'phoneNumber': ''}, this.localization='eng'});

  @override
  List<Object> get props => [];
}
