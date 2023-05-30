import 'package:cine_me/features/authentication/presentation/bloc/silent_login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';

class CustomBottomNavBar extends StatefulWidget implements PreferredSizeWidget{
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}
class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: 1 - _animation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: white.withOpacity(1 - _animation.value),
                    width: 1.0,
                  ),
                ),
                height: 50,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      _animationController.forward().then((_) {
                        BlocProvider.of<SilentLoginBloc>(context).add(
                          const SilentLoginInitiateEvent(),
                        );
                      });
                    },
                    child: FadeTransition(
                      opacity: _animation,
                      child: const Text(
                        'Авторизацiя',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
