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
          //colors :https://coolors.co/2b2d42-8d99ae-d1d1d1-f47382-d80032
          //logo : https://preview.freelogodesign.org/?lang=en&name=&logo=dc652122-2901-43fd-a538-6aea9f8d8a79
          brightness: Brightness.light,
          primaryColor: Color(0XFF2B2D42),
          accentColor: Color(0XFF8D99AE),
          buttonColor: Color(0XFFD1D1D1),
          fontFamily: 'Roboto',

        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   primarySwatch: Colors.yellow,
        // ),
        home: HomeScreen(title: 'Task Mate'),
      ),
    );
  }
}
