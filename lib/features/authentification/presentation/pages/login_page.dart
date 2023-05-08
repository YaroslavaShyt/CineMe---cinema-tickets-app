import 'package:cine_me/cine_me_app.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/authentification/presentation/widgets/custom_bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/silent_login_bloc.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/images.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: image1,
      bottomNavigationBar:
      BlocConsumer<SilentLoginBloc, SilentLoginState>(
        builder: (context, state) {
          if (state is SilentLoginError) {
            return const ErrorPage();
          }
          return const CustomBottomNavBar();
        },
        listenWhen: (previous, current) => current is SilentLoginSuccess,
        listener: (context, state){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => appFilms));
        }
    ));
  }
}
