import 'package:cine_me/features/authentification/presentation/bloc/silent_login_bloc.dart';
import 'package:cine_me/features/authentification/presentation/widgets/gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavBar extends StatefulWidget implements PreferredSizeWidget{
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(300);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
          gradient: bottomNavBarGradient
      ),
      child: BottomAppBar(
          color: Colors.transparent,
        elevation: 0,
          child: OutlinedButton(onPressed: (){
            BlocProvider.of<SilentLoginBloc>(context).add(
               SilentLoginInitiateEvent()
            );
            print('button pressed');
          },
            child: const Text('Авторизацiя')),
      ),
      );}
  }


