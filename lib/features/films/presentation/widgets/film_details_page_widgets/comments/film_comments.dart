import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/comments/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/theme.dart';
import '../../../../../../core/get_it/get_it.dart';
import '../../../bloc/comments/comments_bloc.dart';
import 'comment_dialog.dart';

class FilmComments extends StatefulWidget {
  final String filmId;
  final onDelete;
  const FilmComments({Key? key, required this.filmId, required this.onDelete}) : super(key: key);

  @override
  State<FilmComments> createState() => _FilmCommentsState();
}


class _FilmCommentsState extends State<FilmComments> {
  final TextEditingController controller = TextEditingController();
  late CommentsBloc commentsBloc;

  @override
  void initState() {
    super.initState();
    commentsBloc = getItInst<CommentsBloc>();
    commentsBloc.add(
        CommentsInitiateEvent(filmId: widget.filmId)); // Fetch initial comments
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsInitial) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        } else if (state is CommentsSuccess) {
          final comments = state.comments;
          return Scaffold(
            floatingActionButton: IconButton(
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CommentDialog(filmId: widget.filmId);
                  },
                );
                if (result == 'success') {
                  commentsBloc.add(CommentsInitiateEvent(
                      filmId: widget.filmId)); // Refresh comments after adding
                }
              },
              icon: const Icon(Icons.add),
              color: Provider
                  .of<ThemeProvider>(context)
                  .getTheme == light
                  ? const Color.fromRGBO(73, 71, 157, 10)
                  : const Color.fromRGBO(236, 237, 246, 10),
            ),
            body: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentWidget(
                  filmCommentModel: comments[index],
                  filmId: widget.filmId,
                  onPressed: () {
                    setState(() {
                      commentsBloc.add(CommentDeleteInitiateEvent(
                          commentId: comments[index].id ?? ''));
                      commentsBloc.add(CommentsInitiateEvent(filmId: widget
                          .filmId)); // Refresh comments after deleting
                    });
                  },
                );
              },
            ),
          );
        } else if (state is CommentsError) {
          return Text('Error: ${state.message}');
        }
        return const SizedBox.shrink();
      },
    );
  }
}