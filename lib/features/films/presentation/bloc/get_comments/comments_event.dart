part of 'comments_bloc.dart';


abstract class CommentsEvent extends Equatable{
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class CommentsInitiateEvent extends CommentsEvent {
  final String filmId;
  final String localization;
  CommentsInitiateEvent({this.filmId = '', this.localization = 'en'}){
    print('initiate: $filmId');
  }


  @override
  List<Object> get props => [];
}
