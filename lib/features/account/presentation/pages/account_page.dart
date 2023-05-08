import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/core/widgets/films_app_bar.dart';
import 'package:cine_me/features/account/presentation/bloc/account_bloc.dart';
import 'package:cine_me/features/account/presentation/widgets/account_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/font_styling.dart';


class AccountPage extends StatefulWidget {
  final String detailsPath;
  const AccountPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late AccountBloc accountBloc;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  late String _newName = '';
  late String _newPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    accountBloc = getItInst<AccountBloc>(
        param1: {'name': '', 'phoneNumber': ''}, param2: '');
    accountBloc.add(const AccountInitiateEvent());
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
        child: Scaffold(
            backgroundColor: lightBlack,
            appBar: const FilmsAppBar(title: 'Акаунт',),
            body: BlocConsumer<AccountBloc, AccountState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AccountError) {
                    return const ErrorPage();
                  } else if (state is AccountSuccess) {
                    final account = state.user;
                    final tickets = state.ticketsResponse.map((value) => value);
                    final ticketsList = tickets.getOrElse(() => []);
                    {
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                          AccountPageHead(
                            onPressed2: (){},
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: lightBlack,
                                    title: const Text(
                                      'Редагувати дані',
                                      style: notoSansDisplayBoldSmall,
                                    ),
                                    content: SizedBox(
                                        height: 100,
                                        child: Column(
                                      children: [
                                        TextFormField(
                                          style: notoSansDisplayRegularTiny,
                                          controller: _controller1,
                                          onChanged: (text) {
                                            _newName = text;
                                          },
                                        ),
                                        TextFormField(
                                          style: notoSansDisplayRegularTiny,
                                          controller: _controller2,
                                          onChanged: (text) {
                                            _newPhoneNumber = text;
                                          },
                                        )
                                      ],
                                    )),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Зберегти', style: notoSansDisplayRegularTiny,),
                                        onPressed: () {
                                          accountBloc.add(AccountInitiateEvent(
                                              newUserData: {
                                                'name': _newName,
                                                'phoneNumber': _newPhoneNumber
                                              }));
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Відміна', style: notoSansDisplayRegularTiny,),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              setState(() {
                                _controller1.text = account.name;
                                _controller2.text = account.phoneNumber;
                              });
                            },
                            phoneNumber: account.phoneNumber,
                            username: account.name,
                          ),
                          const SizedBox(height: 20,),
                          if (ticketsList.isNotEmpty)
                            SizedBox(
                                height: 600, // set a fixed height
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (var i = ticketsList.length-1; i >=0; i--)
                                        TicketCard(
                                            id: ticketsList[i].id,
                                            date: ticketsList[i].date,
                                            image: ticketsList[i].image,
                                            title: ticketsList[i].name,
                                         )
                                  ],
                                ))
                              else if(ticketsList.isEmpty)
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const[
                                        SizedBox(height: 200,),
                                    Text('Йой, ви ще не були у кіно?', style: notoSansDisplayRegularSmall,),
                                    Text('Гайда до афіші!', style: notoSansDisplayRegularSmall,),
                                   ])
                        ]),
                      ));
                    }
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: white,
                  ));
                })));
  }
}
