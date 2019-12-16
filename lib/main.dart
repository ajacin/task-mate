import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerarray/pages/home_screen.dart';
import 'package:providerarray/providers/todos_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TodosModel(),
      child: MaterialApp(
        title: 'Todos',
        theme: ThemeData(
          //colors : https://coolors.co/8b1e3f-3a405a-89bd9e-f0c987-fffd98
          brightness: Brightness.light,
          primaryColor: Color(0XFF8B1E3F),
          accentColor: Color(0XFF3A405A),
          buttonColor: Color(0XFF89BD9E),
          fontFamily: 'Roboto',

        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   primarySwatch: Colors.yellow,
        // ),
        home: HomeScreen(title: 'My Tasks'),
      ),
    );
  }
}
