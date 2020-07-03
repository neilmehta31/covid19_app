import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/screens/indiaStatsScreen.dart';

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
        home: BottomNavBar(),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  var screens = [
    HomeScreen(),
    IndiaStatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
    controller: _pageController,
    children: <Widget>[
     HomeScreen(),
     IndiaStatsScreen(),
    ],
    onPageChanged: (page){
      setState(() {
        _currentIndex = page;
      });
    },
  ),
      //  screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 12,
        // iconSize: 15,
        backgroundColor: Color(0xFFF5F5F5),
        type: BottomNavigationBarType.shifting,
        // iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              backgroundColor: kPrimaryColor,
              title: Text('Nagpur Stats')),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            backgroundColor: Colors.blue[600],
            title: Text('India Stats'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

