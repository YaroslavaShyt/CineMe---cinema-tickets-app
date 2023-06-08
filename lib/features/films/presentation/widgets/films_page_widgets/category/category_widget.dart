import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'category_option_widget.dart';

class CategoryOptionsRow extends StatelessWidget {
  final onPressedRomance;
  final onPressedAction;
  final onPressedHorror;
  final onPressedAdventure;
  const CategoryOptionsRow({
    Key? key,
    required this.onPressedAction,
    required this.onPressedAdventure,
    required this.onPressedHorror,
    required this.onPressedRomance
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryOptionItem(
          onPressed: onPressedRomance,
            text: "romance".tr().toString(),
            icon: const Icon(
          FontAwesome.heart,
          color: Color.fromRGBO(73, 71, 167, 100),
        )),
        CategoryOptionItem(
          onPressed: onPressedAdventure,
          text: "adventure".tr().toString(),
          icon: const Icon(
          FontAwesome.bicycle,
          color: Color.fromRGBO(73, 71, 167, 100),
        ),),
        CategoryOptionItem(
          onPressed: onPressedHorror,
          text: "horror".tr().toString(),
          icon: const Icon(
          FontAwesome.snapchat_ghost,
          color: Color.fromRGBO(73, 71, 167, 100),
        ),),CategoryOptionItem(
          onPressed: onPressedAction,
            text: "action".tr().toString(),
            icon: const Icon(
          FontAwesome.space_shuttle,
          color: Color.fromRGBO(73, 71, 167, 100),
        )),
      ],
    );
  }
}
