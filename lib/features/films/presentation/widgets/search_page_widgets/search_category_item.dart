import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';

class SearchCategoryItem extends StatelessWidget {
  final String text;
  final bool isFilmDetails;
  const SearchCategoryItem({Key? key, required this.text, this.isFilmDetails=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, right: 3.0),
      child: OutlinedButtonTheme(
          data: OutlinedButtonThemeData(
            style: ButtonStyle(
              side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                    return const BorderSide(color: Colors.transparent);
                  }),
              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(236, 237, 246, 100)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          child: SizedBox(
              height: 25,
              child: OutlinedButton(
                  onPressed: (){},
                  child: Text(
                    text,
                    style: TextStyle(
                        color: isFilmDetails ? Colors.white : Provider.of<ThemeProvider>(context).getTheme == light
                            ?  Colors.grey
                            : Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w400),
                  )))),
    );
  }
}
