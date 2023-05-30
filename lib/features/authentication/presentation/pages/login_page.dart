import 'package:cine_me/cine_me_app.dart';
import 'package:cine_me/features/authentication/presentation/widgets/body.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/core/progress_page.dart';
import 'package:cine_me/features/authentication/presentation/widgets/custom_bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/features/authentication/presentation/bloc/silent_login_bloc.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn>{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SilentLoginBloc, SilentLoginState>(
        builder: (context, state) {
          if (state is SilentLoginError) {
            return const ErrorPage();
          }
          if (state is SilentLoginInitial) {
            return const Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              body: LogInBody(),
              bottomNavigationBar: CustomBottomNavBar(),
            );
          }
          return const ProgressPage(processName: 'Авторизація...');
        },
        listenWhen: (previous, current) => current is SilentLoginSuccess,
        listener: (context, state){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => appFilms));
        }
    );
  }
}
