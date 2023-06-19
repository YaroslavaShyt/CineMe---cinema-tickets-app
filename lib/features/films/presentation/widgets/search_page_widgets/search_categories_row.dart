import 'package:cine_me/core/widgets/rounded_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchCategoryRow extends StatelessWidget {
  final VoidCallback onPressedFilms;
  final VoidCallback onPressedCartoons;
  final VoidCallback onPressedShow;
  final VoidCallback onPressedEmpty;
  const SearchCategoryRow({Key? key,
    required this.onPressedEmpty,
    required this.onPressedFilms,
    required this.onPressedCartoons,
    required this.onPressedShow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedButton(onPressedEmpty: onPressedEmpty, onPressed: onPressedShow, text: "show".tr().toString()),
        const SizedBox(width: 5,),
        RoundedButton(onPressedEmpty: onPressedEmpty, onPressed: onPressedCartoons, text: "cartoon".tr().toString()),
        const SizedBox(width: 5,),
        RoundedButton(onPressedEmpty: onPressedEmpty, onPressed: onPressedFilms, text: "film".tr().toString()),
      ],
    );
  }
}
