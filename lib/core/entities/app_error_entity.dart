import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String appErrorType;

  const AppError(this.appErrorType);

  @override
  List<Object> get props => [appErrorType];
}
