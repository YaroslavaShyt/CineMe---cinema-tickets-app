import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'category_option_widget.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text('Category',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color.fromRGBO(73, 71, 167, 100),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: OutlinedButtonTheme(
              data: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              child: SizedBox(
                width: 100,
                child: OutlinedButton(
                    onPressed: () {},
                    child: const Text(
                      'See more',
                      style: TextStyle(
                          color: Color.fromRGBO(168, 167, 199, 100),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    )),
              )),
        )
      ],
    );
  }
}

class CategoryOptionsRow extends StatelessWidget {
  const CategoryOptionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryOptionItem(text: 'Romance', icon: Icon(
          FontAwesome.heart,
          color: Color.fromRGBO(73, 71, 167, 100),
        )),
        CategoryOptionItem(text: 'Adventure', icon: Icon(
          FontAwesome.bicycle,
          color: Color.fromRGBO(73, 71, 167, 100),
        ),),
        CategoryOptionItem(text: 'Horror', icon: Icon(
          FontAwesome.snapchat_ghost,
          color: Color.fromRGBO(73, 71, 167, 100),
        ),),CategoryOptionItem(text: 'Action', icon: Icon(
          FontAwesome.space_shuttle,
          color: Color.fromRGBO(73, 71, 167, 100),
        )),
      ],
    );
  }
}
