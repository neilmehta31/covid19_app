import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_19/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class IndiaStatsScreen extends StatefulWidget {
  @override
  _IndiaStatsScreenState createState() => _IndiaStatsScreenState();
}

class _IndiaStatsScreenState extends State<IndiaStatsScreen> {
  Map statesDataAsMap;
  getDataOfStates() async {
    http.Response respState =
        await http.get("https://api.covid19india.org/data.json");
    setState(
      () {
        statesDataAsMap = json.decode(respState.body);
      },
    );
  }

  Map statesDataWithInitialsAsMap;
  dataOfStatesWithInitials() async {
    http.Response respState =
        await http.get("https://api.covid19india.org/v3/data.json");
    setState(
      () {
        statesDataWithInitialsAsMap = json.decode(respState.body);
      },
    );
  }

  @override
  void initState() {
    dataOfStatesWithInitials();
    getDataOfStates();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(statesDataAsMap);
    print('__________________________________________________');
    print(statesDataWithInitialsAsMap);
    return Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(),
        drawer: DrawerWidget(),
        body: ListView(
          scrollDirection: Axis.vertical,
          cacheExtent: 100.0,
          children: [
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Text.rich(
                                TextSpan(
                                  text: "India",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      right: 90,
                      child: Container(
                        child: Text.rich(
                          TextSpan(
                            text: "Statistics",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    StatsListview(
                      statesDataAsMap: statesDataAsMap,
                      statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(0.03),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
          // print('Drawer');
        }, //TO-DO: remove the dialog box printing of drawer
      ),
    );
  }
}

class StatsListview extends StatelessWidget {
  final Map statesDataAsMap;
  final Map statesDataWithInitialsAsMap;

  const StatsListview({
    Key key,
    this.statesDataAsMap,
    this.statesDataWithInitialsAsMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(35),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
              color: kBackgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 225,
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 110,
            ),
            child: statesDataAsMap == null
                ? LinearProgressIndicator()
                : StateAndIndiaPannel(
                    statesDataAsMap: statesDataAsMap,
                  ),
          ),
        ),
        Divider(
          color: Colors.black87,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            // color: Colors.green,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          text: "All State/Union Territory",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 13, right: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        // color: Colors.brown,
                        child: Text.rich(
                          TextSpan(text: "Location"),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        child: Text.rich(
                          TextSpan(text: "Confirmed"),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.pink,
                        child: Text.rich(
                          TextSpan(text: "Deceased"),
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.blueAccent,
                        child: Text.rich(
                          TextSpan(text: "Recovered"),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                statesDataWithInitialsAsMap == null
                    ? LinearProgressIndicator()
                    : StatesAndUtData(
                        statesDataWithInitialsAsMap:
                            statesDataWithInitialsAsMap,
                        initials: 'AN',
                        stateName: 'Andaman and Nicobar Islands',
                      ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'AP',
                  stateName: 'Andhra Pradesh',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'AR',
                  stateName: 'Arunachal Pradesh	',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'AS',
                  stateName: 'Assam',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'BR',
                  stateName: 'Bihar',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'CH',
                  stateName: 'Chandigarh',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'CT',
                  stateName: 'Chhattisgarh',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'DL',
                  stateName: 'Delhi',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'DN',
                  stateName: 'Dadra and Nagar Haveli',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'GA',
                  stateName: 'Goa',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'GJ',
                  stateName: 'Gujarat',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'HP',
                  stateName: 'Himachal Pradesh',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'HR',
                  stateName: 'Haryana',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'JH',
                  stateName: 'Jharkhand',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'JK',
                  stateName: 'Jammu and Kashmir',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'KA',
                  stateName: 'Karnataka',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'KL',
                  stateName: 'Kerala',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'LA',
                  stateName: 'Laddakh',
                ),
                Divider(),
                // StatesAndUtData(
                //   statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                //   initials: 'LD',
                //   stateName: 'Lakshadweep',
                // ),
                // Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'MH',
                  stateName: 'Maharashtra',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'ML',
                  stateName: 'Meghalaya',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'MN',
                  stateName: 'Manipur',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'MP',
                  stateName: 'Madhya Pradesh',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'MZ',
                  stateName: 'Mizoram',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'NL',
                  stateName: 'Nagaland',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'OR',
                  stateName: 'Odisha',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'PB',
                  stateName: 'Punjab',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'PY',
                  stateName: 'Puducherry',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'RJ',
                  stateName: 'Rajasthan',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'SK',
                  stateName: 'Sikkim',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'TG',
                  stateName: 'Telangana',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'TN',
                  stateName: 'Tamil Nadu',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'TR',
                  stateName: 'Tripura',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'TT',
                  stateName: 'Maharashtra',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'UP',
                  stateName: 'Uttar Pradesh',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'UT',
                  stateName: 'Uttarakhand',
                ),
                Divider(),
                StatesAndUtData(
                  statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                  initials: 'WB',
                  stateName: 'West Bengal',
                ),
                // // Divider(),
                // // StatesAndUtData(
                // //   statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                // //   initials: 'MH',
                // //   stateName: 'Maharashtra',
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StatesAndUtData extends StatelessWidget {
  // final Map statesDataAsMap;
  final Map statesDataWithInitialsAsMap;
  final String initials;
  final String stateName;
  // final int indexState;
  const StatesAndUtData({
    Key key,
    //this.statesDataAsMap,
    this.statesDataWithInitialsAsMap,
    this.initials,
    this.stateName,
    // this.indexState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text.rich(TextSpan(
        text: stateName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      )),
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text.rich(
              //confirmed
              TextSpan(
                text: statesDataWithInitialsAsMap[initials]['total']
                                ['confirmed']
                            .toString() ==
                        'null'
                    ? '0'
                    : statesDataWithInitialsAsMap[initials]['total']
                            ['confirmed']
                        .toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text.rich(
              //deceased
              TextSpan(
                text: statesDataWithInitialsAsMap[initials]['total']['deceased']
                            .toString() ==
                        'null'
                    ? '0'
                    : statesDataWithInitialsAsMap[initials]['total']['deceased']
                        .toString(),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text.rich(
              //recovered
              TextSpan(
                text: statesDataWithInitialsAsMap[initials]['total']
                                ['recovered']
                            .toString() ==
                        'null'
                    ? '0'
                    : statesDataWithInitialsAsMap[initials]['total']
                            ['recovered']
                        .toString(),
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StateAndIndiaPannel extends StatelessWidget {
  final Map statesDataAsMap;
  const StateAndIndiaPannel({
    Key key,
    this.statesDataAsMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text.rich(TextSpan(
                  text: "Maharashtra",
                  style: TextStyle(fontWeight: FontWeight.w900))),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Confirmed',
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Deceased',
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Recovered',
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: statesDataAsMap['statewise'][1]['confirmed'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: statesDataAsMap['statewise'][1]['deaths'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: statesDataAsMap['statewise'][1]['recovered'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black54,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text.rich(TextSpan(
                text: "Across India",
                style: TextStyle(fontWeight: FontWeight.w900),
              )),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Confirmed',
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Deceased',
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Recovered',
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: statesDataAsMap['statewise'][0]['confirmed'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: statesDataAsMap['statewise'][0]['deaths'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: statesDataAsMap['statewise'][0]['recovered'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
