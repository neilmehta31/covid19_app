import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
          app: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVID-19 App',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
                displayColor: kTextColor,
              ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
