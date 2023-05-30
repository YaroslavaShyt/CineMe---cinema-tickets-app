import 'package:flutter/material.dart';
import 'package:cine_me/features/authentication/presentation/widgets/app_title_widget.dart' as title;
import 'package:cine_me/features/authentication/presentation/widgets/images.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({Key? key}) : super(key: key);

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image1,
        Center(
            child:  LayoutBuilder(
              builder: (context, constraints) {
                final containerWidth = constraints.maxWidth * 0.9;
                const containerHeight = 350.0;

                return SizedBox(
                  width: containerWidth,
                  height: containerHeight,
                  child: const title.Title(),
                );
              },
            ),
        ),
      ],
    ); //image;
  }
}

