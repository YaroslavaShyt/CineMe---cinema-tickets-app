import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DropDownMenu extends StatefulWidget {
  final function;
  DropDownMenu({Key? key, required this.function}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  final List<String> dropdownItems = ['🇺🇦 Українська', '🇬🇧 English', '🇪🇸 Español'];
  String selectedOption = '🇺🇦 Українська';

  @override
  void initState(){
    _loadSavedOption();
    super.initState();

  }

  void _loadSavedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString('selectedOption') ?? '🇺🇦 Українська';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(73, 71, 167, 100),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: DropdownButton<String>(
          value: selectedOption,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedOption = newValue;
                _changeLanguage(newValue);
              });
            }
          },
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          dropdownColor: const Color.fromRGBO(73, 71, 167, 200),
          items: dropdownItems.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 14),),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _changeLanguage(String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale? locale;
    if (newValue == '🇺🇦 Українська') {
      locale = const Locale('uk', 'UA');
    } else if (newValue == '🇬🇧 English') {
      locale = const Locale('en', 'US');
    } else if (newValue == '🇪🇸 Español') {
      locale = const Locale('es', 'ES');
    }
    if (locale != null) {
      setState(() {
        selectedOption = newValue;
        CustomDrawer.selectedLanguage = locale!;
        context.setLocale(locale);
      });
      prefs.setString('selectedOption', newValue);
      Get.updateLocale(locale);
      widget.function(locale.languageCode == 'uk' && locale.countryCode == 'UA' ? 'uk' : 'en');
    }

  }
}
