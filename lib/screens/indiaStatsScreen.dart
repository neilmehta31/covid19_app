import 'dart:convert';
import 'package:covid_19/widgets/stateData.dart';
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
//    print(statesDataWithInitialsAsMap['AP']['total']['confirmed']);
    // print(statesDataAsMap);
    // print('__________________________________________________');
    // print(statesDataWithInitialsAsMap);
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
                        padding: const EdgeInsets.only(left: 0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text.rich(
                                TextSpan(
                                  text: "COVID-19",
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
                    Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Container(
                        alignment: Alignment.center,
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
                    // Positioned(
                    //   right: 20,
                    //   top: 100,
                    //   child: Image.asset('assets/icons/mask_single.png',),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu_white_cleaned.svg"),
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
                ? CircularProgressIndicator()
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
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.amber[700],
                                  size: 15,
                                ),
                                SizedBox(width: 15,),
                                Text.rich(TextSpan(
                                  text: "Click to view detailed/district Statistics",
                                  style: TextStyle(color: Colors.grey[500])
                                ),),

                              ],
                            ),
                          )
                        ],
                      )
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
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Divider(),
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'AN',
                              stateName: 'Andaman and \nNicobar Islands',
                              launchStateData: launchANdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'AP',
                              stateName: 'Andhra \nPradesh',
                              launchStateData: launchAPdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'AR',
                              stateName: 'Arunachal \nPradesh	',
                              launchStateData: launchARdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'AS',
                              stateName: 'Assam',
                              launchStateData: launchASdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'BR',
                              stateName: 'Bihar',
                              launchStateData: launchBRdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'CH',
                              stateName: 'Chandigarh',
                              launchStateData: launchCHdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'CT',
                              stateName: 'Chhattisgarh',
                              launchStateData: launchCTdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'DL',
                              stateName: 'Delhi',
                              launchStateData: launchDLdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'DN',
                              stateName: 'Dadra and \nNagar Haveli',
                              launchStateData: launchDNdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'GA',
                              stateName: 'Goa',
                              launchStateData: launchGAdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'GJ',
                              stateName: 'Gujarat',
                              launchStateData: launchGJdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'HP',
                              stateName: 'Himachal \nPradesh',
                              launchStateData: launchHPdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'HR',
                              stateName: 'Haryana',
                              launchStateData: launchHRdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'JH',
                              stateName: 'Jharkhand',
                              launchStateData: launchJHdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'JK',
                              stateName: 'Jammu and \nKashmir',
                              launchStateData: launchJKdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'KA',
                              stateName: 'Karnataka',
                              launchStateData: launchKAdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'KL',
                              stateName: 'Kerala',
                              launchStateData: launchKLdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'LA',
                              stateName: 'Laddakh',
                              launchStateData: launchLAdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            // StatesAndUtData(
                            //   statesDataWithInitialsAsMap: statesDataWithInitialsAsMap,
                            //   initials: 'LD',
                            //   stateName: 'Lakshadweep',
                            // ),
                            // Divider(),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'MH',
                              stateName: 'Maharashtra',
                              launchStateData: launchMHdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'ML',
                              stateName: 'Meghalaya',
                              launchStateData: launchMLdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'MN',
                              stateName: 'Manipur',
                              launchStateData: launchMNdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'MP',
                              stateName: 'Madhya \nPradesh',
                              launchStateData: launchMPdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'MZ',
                              stateName: 'Mizoram',
                              launchStateData: launchMZdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'NL',
                              stateName: 'Nagaland',
                              launchStateData: launchNLdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'OR',
                              stateName: 'Odisha',
                              launchStateData: launchORdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'PB',
                              stateName: 'Punjab',
                              launchStateData: launchPBdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'PY',
                              stateName: 'Puducherry',
                              launchStateData: launchPYdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'RJ',
                              stateName: 'Rajasthan',
                              launchStateData: launchRJdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'SK',
                              stateName: 'Sikkim',
                              launchStateData: launchSKdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'TG',
                              stateName: 'Telangana',
                              launchStateData: launchTGdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'TN',
                              stateName: 'Tamil Nadu',
                              launchStateData: launchTNdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'TR',
                              stateName: 'Tripura',
                              launchStateData: launchTRdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),

                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'UP',
                              stateName: 'Uttar \nPradesh',
                              launchStateData: launchUPdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'UT',
                              stateName: 'Uttarakhand',
                              launchStateData: launchUTdata,
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            StatesAndUtData(
                              statesDataWithInitialsAsMap:
                                  statesDataWithInitialsAsMap,
                              initials: 'WB',
                              stateName: 'West Bengal',
                              launchStateData: launchWBdata,
                            ),
                          ],
                        ),
                      )
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
  final Function launchStateData;
  // final int indexState;
  const StatesAndUtData({
    Key key,
    //this.statesDataAsMap,
    this.statesDataWithInitialsAsMap,
    this.initials,
    this.stateName,
    this.launchStateData,
    // this.indexState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: launchStateData,
      child: ListTile(
        leading: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.amber[700],
              ),
              Text(
                stateName,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        title: Container(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              // Text.rich(TextSpan(
              //   text: stateName,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 11,
              //   ),
              // )),
              Positioned(
                right: MediaQuery.of(context).size.width * .49,
                child: Text.rich(
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
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * .265,
                child: Text.rich(
                  //deceased
                  TextSpan(
                    text: statesDataWithInitialsAsMap[initials]['total']
                                    ['deceased']
                                .toString() ==
                            'null'
                        ? '0'
                        : statesDataWithInitialsAsMap[initials]['total']
                                ['deceased']
                            .toString(),
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(text: ''),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * .04,
                child: Text.rich(
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
              ),
            ],
          ),
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
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Deceased',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Recovered',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
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
