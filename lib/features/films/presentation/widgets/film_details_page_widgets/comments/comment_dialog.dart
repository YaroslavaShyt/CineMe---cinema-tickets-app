import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/comments/rating_widget.dart';
import 'package:cine_me/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/theme.dart';
import '../../../bloc/comments/comments_bloc.dart';

class CommentDialog extends StatefulWidget {
  final String filmId;
  const CommentDialog({super.key, required this.filmId});

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}
class _CommentDialogState extends State<CommentDialog> {
  final TextEditingController controller = TextEditingController();
  final CommentsBloc commentsBloc = getItInst<CommentsBloc>();

  int selectedRating = 0;

  void handleRatingChanged(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "share opinion".tr().toString(),
        style: TextStyle(
          color: Provider.of<ThemeProvider>(context).getTheme == light
              ? const Color.fromRGBO(73, 71, 157, 10)
              : const Color.fromRGBO(236, 237, 246, 10),
        ),
      ),
      content: SizedBox(
        height: 80,
        child: Column(
          children: [
            RatingWidget(
              maxRating: 5,
              currentRating: selectedRating,
              onRatingChanged: handleRatingChanged,
            ),
            TextField(
              cursorColor: Provider.of<ThemeProvider>(context).getTheme == light
                  ? const Color.fromRGBO(73, 71, 157, 10)
                  : const Color.fromRGBO(236, 237, 246, 10),
              controller: controller,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(73, 71, 157, 10)
                        : const Color.fromRGBO(236, 237, 246, 10),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(73, 71, 157, 10)
                        : const Color.fromRGBO(236, 237, 246, 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: 100,
          height: 40,
          child: CustomButton(
            text: 'OK',
            onPressed: () {
              commentsBloc.add(AddCommentInitiateEvent(
                filmId: widget.filmId,
                comment: controller.text,
                rating: selectedRating,
              ));
              Navigator.of(context).pop(); // Close the dialog immediately
            },

          ),
        ),
        SizedBox(
          width: 100,
          height: 40,
          child: CustomButton(
            text: "Cancel".tr().toString(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
