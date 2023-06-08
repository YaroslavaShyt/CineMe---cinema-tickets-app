import 'package:cine_me/core/constants/theme.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/core/getit/get_it.dart' as getIt;
import 'package:cine_me/cine_me_app.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cine_me/core/widgets/bottom_nav_bar.dart';
import 'package:cine_me/features/authentication/domain/repositories/silent_authentication_repository.dart';
import 'core/getit/get_it.dart';
import 'package:cine_me/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  getIt.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Widget initialScreen = const LogIn();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  if (accessToken!=null){
    AuthenticationRepository datasource = getItInst<AuthenticationRepository>();
    Either<AppError, bool> exists = await datasource.checkUserExists();
    if (exists == Right(true)){
      initialScreen = const BottomNavBar();
    }
  }
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => ThemeProvider(isDarkMode: prefs.getBool("isDarkTheme") ?? false),
    child: EasyLocalization(
      supportedLocales: const [
        Locale("uk", "UA"),
        Locale("en", "US")
      ],
path: 'assets/translations/symbols',
        saveLocale: true,
        fallbackLocale: const Locale("uk", "UA"),
        child: CineMe(initScreen: initialScreen)
    ),
  ));}