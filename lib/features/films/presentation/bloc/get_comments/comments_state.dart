part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsSuccess extends CommentsState {
  final List<FilmCommentModel> comments;

  const CommentsSuccess(this.comments);

  @override
  List<Object> get props => [comments];
}

class CommentsError extends CommentsState {
  final String message;

  const CommentsError(this.message);

  @override
  List<Object> get props => [message];
}