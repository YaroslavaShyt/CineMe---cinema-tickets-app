import 'package:cine_me/core/entities/app_error_entity.dart';
import 'package:cine_me/core/getit/get_it.dart' as getIt;
import 'package:cine_me/cine_me_app.dart';
import 'package:cine_me/features/films/presentation/pages/films/films_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'features/authentification/domain/repositories/silent_authentication_repository.dart';
import 'core/getit/get_it.dart';
import 'features/authentification/presentation/pages/login_page.dart';


Future<void> main() async {
  getIt.init();
  WidgetsFlutterBinding.ensureInitialized();
  Widget initialScreen = const LogIn();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  if (accessToken!=null){
    AuthenticationRepository datasource = getItInst<AuthenticationRepository>();
    Either<AppError, bool> exists = await datasource.checkUserExists();
    if (exists == Right(true)){
      initialScreen = const BottomNavBar();
    }
  }
  runApp(CineMe(initScreen: initialScreen));
}

