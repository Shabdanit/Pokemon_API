import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main (){
  runApp(
    ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: Pokemon(),
  ),);



}

class Pokemon extends StatelessWidget {
  const Pokemon({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Home(),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('en', 'US'),
      // ],
    );
  }
}
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
