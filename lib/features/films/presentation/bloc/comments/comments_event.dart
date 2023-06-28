part of 'comments_bloc.dart';


abstract class CommentsEvent extends Equatable{
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class CommentsInitiateEvent extends CommentsEvent {
  final String filmId;
  final String localization;
  const CommentsInitiateEvent({this.filmId = '', this.localization = 'en'});


  @override
  List<Object> get props => [];
}

class CommentDeleteInitiateEvent extends CommentsEvent {
  final String commentId;
  final String localization;
  const CommentDeleteInitiateEvent({this.commentId = '', this.localization = 'en'});


  @override
  List<Object> get props => [];
}

class AddCommentInitiateEvent extends CommentsEvent {
  final String filmId;
  final String localization;
  final String comment;
  final int rating;
  const AddCommentInitiateEvent({this.filmId = '', this.localization = 'en', this.rating = 0, this.comment=''});


  @override
  List<Object> get props => [];
}
