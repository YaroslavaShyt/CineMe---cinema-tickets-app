import 'package:cine_me/core/constants/theme.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/drawer/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../../core/get_it/get_it.dart';
import '../../../../../account/presentation/bloc/account_bloc.dart';
import 'package:provider/provider.dart';


class CustomDrawer extends StatefulWidget {
  static Locale selectedLanguage = const Locale("uk", "UA");
  final function;
  const CustomDrawer({Key? key, required this.function}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late AccountBloc accountBloc;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  late String _newName = '';
  late String _newPhoneNumber = '';
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
  }

  @override
  void initState() {
    accountBloc = getItInst<AccountBloc>(
        param1: {'name': '', 'phoneNumber': ''}, param2: '');
    accountBloc.add(const AccountInitiateEvent());
    super.initState();
  }

  @override
  void dispose() {
    accountBloc.close();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => accountBloc)],
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: BlocConsumer<AccountBloc, AccountState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is AccountSuccess) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${"hello".tr().toString()} ${state.user.name}',
                                      style: TextStyle(
                                        color:Provider.of<ThemeProvider>(context).getTheme == light
                                            ? const Color.fromRGBO(73, 71, 167, 100)
                                            : const Color.fromRGBO(236, 237, 246, 10),
                                        fontSize: 24,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text(
                                                  'Редагувати дані',
                                                  style: TextStyle(
                                                    color: Provider.of<ThemeProvider>(context).getTheme == light ?
                                                         Colors.black38 : Colors.white
                                                  ,
                                                  )),
                                                content: SizedBox(
                                                    height: 100,
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              _controller1,
                                                          onChanged: (text) {
                                                            _newName = text;
                                                          },
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _controller2,
                                                          onChanged: (text) {
                                                            _newPhoneNumber =
                                                                text;
                                                          },
                                                        )
                                                      ],
                                                    )),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                      'Зберегти',
                                                    ),
                                                    onPressed: () {
                                                      accountBloc.add(
                                                          AccountInitiateEvent(
                                                              newUserData: {
                                                            'name': _newName,
                                                            'phoneNumber':
                                                                _newPhoneNumber
                                                          }));
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                      'Відміна',
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          setState(() {
                                            _controller1.text = state.user.name;
                                            _controller2.text =
                                                state.user.phoneNumber;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.grey,
                                          size: 20,
                                        ))
                                  ],
                                ),
                                Text(
                                  state.user.phoneNumber,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Provider.of<ThemeProvider>(context).getTheme == light ? Colors.black38 : Colors.grey),
                                )
                              ]);
                        }
                        return const Center(child: CircularProgressIndicator(color: Color.fromRGBO(95, 94, 183, 100),));
                      })),
              ListTile(
                leading: const Icon(FontAwesome.paint_brush),
                title: GestureDetector(
                  onTap: () {
                    toggleSwitch(!isSwitched);
                    Provider.of<ThemeProvider>(context, listen: false).swapTheme();
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeProvider>(context).getTheme == light ? Colors.black38 : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        Provider.of<ThemeProvider>(context).getTheme == light ? '${"dark".tr().toString()}' : '${"light".tr().toString()}',
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).getTheme == light ? Colors.white  : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  // Handle the onTap action for the home option
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: const Icon(FontAwesome.language),
                title: DropDownMenu(function: widget.function,),
              ),
            ],
          ),
        ));
  }
}
