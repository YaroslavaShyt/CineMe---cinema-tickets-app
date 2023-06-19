import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';

class SummaryWidget extends StatelessWidget {
  final String director;
  final String writers;
  final String image;
  const SummaryWidget({
    Key? key,
    required this.director,
    required this.writers,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [
          SizedBox(
            width: 200,
            child: Wrap(
              children: [
                Text(
                  '${"directors".tr().toString()}: ',
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(73, 71, 157, 10)
                        : const Color.fromRGBO(236, 237, 246, 10),
                    fontSize: 15,
                  ),
                ),
                  for (var j in director.split(' '))
                    Column(
                      children: [
                        Text(
                          '$j ',
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).getTheme == light
                                ? const Color.fromRGBO(73, 71, 157, 10)
                                : const Color.fromRGBO(236, 237, 246, 10),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),


          const SizedBox(height: 30,),
          SizedBox(
            width: 200,
            child: Wrap(
              children: [
                Text(
                  '${"writers".tr().toString()}: ',
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(73, 71, 157, 10)
                        : const Color.fromRGBO(236, 237, 246, 10),
                    fontSize: 15,
                  ),
                ),
                for (var i = 0; i < writers.length; i++)
                  for (var j = 0; j < writers[i].length; j++)
                    Column(
                      children: [
                        Text(
                          writers[i][j],
                          style: TextStyle(
                            color: Provider.of<ThemeProvider>(context).getTheme == light
                                ? const Color.fromRGBO(73, 71, 157, 10)
                                : const Color.fromRGBO(236, 237, 246, 10),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        if (j < writers[i].length - 1 && writers[i][j + 1] != ' ') const Text(', '),
                      ],
                    ),
              ],
            ),
          ),
        ],),
        const SizedBox(width: 40,),
        ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            ),
            child: Image(
                height: 170,
                image: NetworkImage(image)))
      ],
    );
  }
}
