import 'package:flutter/material.dart';
class RatingWidget extends StatelessWidget {
  final int maxRating;
  final int currentRating;
  final Function(int) onRatingChanged;

  RatingWidget({
    Key? key,
    this.maxRating = 5,
    required this.currentRating,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxRating, (index) {
        return GestureDetector(
          onTap: () {
            onRatingChanged(index + 1);
          },
          child: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
            size: 30,
          ),
        );
      }),
    );
  }
}
