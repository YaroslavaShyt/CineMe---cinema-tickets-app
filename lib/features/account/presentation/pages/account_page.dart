import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/account/data/models/ticket_model.dart';
import 'package:cine_me/features/account/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            body: BlocConsumer<AccountBloc, AccountState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AccountError) {
                    return const Text('Отакої, виникла помилка!');
                  } else if (state is AccountSuccess) {
                    final account = state.user;
                    final tickets = state.ticketsResponse.map((value) => value);
                    final ticketsList = tickets.getOrElse(() => []);
                    {return SafeArea(
                        child: Column(children: [
                          Column(
                            children: [
                              Text(account.name),
                              Text(account.phoneNumber)
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Alert'),
                                      content: Column(
                                        children: [
                                          TextFormField(
                                            controller: _controller1,
                                            onChanged: (text) {
                                              _newName = text;
                                            },
                                          ),
                                          TextFormField(
                                            controller: _controller2,
                                            onChanged: (text) {
                                              _newPhoneNumber = text;
                                            },
                                          )
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Зберегти'),
                                          onPressed: () {
                                            accountBloc.add(
                                                AccountInitiateEvent(
                                                    newUserData: {
                                                  'name': _newName,
                                                  'phoneNumber': _newPhoneNumber
                                                }));
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Відміна'),
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
                              icon: const Icon(Icons.edit)),
                          if (ticketsList.isNotEmpty)
                              SizedBox(
                              height: 200, // set a fixed height
                              child: ListView(
                                children: [
                                    for (var i = 0; i < ticketsList.length; i++)
                                      Text(
                                          '${ticketsList[i].id}\n${ticketsList[i].name}')
                                ],
                            ))
                        ]),
                      );
                    }
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
