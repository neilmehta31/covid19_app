import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/details_screen.dart';
import 'package:covid_19/widgets/infocard.dart';
import 'package:flutter/material.dart';

// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      drawer: DrawerWidget(),
      body: ListView(
        scrollDirection: Axis.vertical,
        cacheExtent: 100.0,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('covid19nagpurdb')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    } else {
                      //TO-DO: Watch out for not connecting to the firebase database.
                      // print(snapshot.data.documents[3]['title']);
                      return Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                          bottom: 40,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.04),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: (Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: <Widget>[
                            InfoCard(
                              title: 'Confirmed Cases',
                              effectedNum: snapshot.data.documents[0]
                                  ['affectedNumbers'],
                              iconColor: Color(0xFFFF8C00),
                              press: () {
                                print('Confirmed Cases Infocard');
                              },
                            ),
                            InfoCard(
                              title: "Total Deaths",
                              effectedNum: snapshot.data.documents[3]
                                  ['affectedNumbers'],
                              iconColor: Color(0xFFFF2D55),
                              press: () {
                                print('Total Deaths Infocard');
                              },
                            ),
                            InfoCard(
                              title: "Total Recovered",
                              effectedNum: snapshot.data.documents[2]
                                  ['affectedNumbers'],
                              iconColor: Color(0xFF50E3C2),
                              press: () {
                                print('Total recovered Infocard');
                              },
                            ),
                            InfoCard(
                              title: "New Cases",
                              effectedNum: snapshot.data.documents[1]
                                  ['affectedNumbers'],
                              iconColor: Color(0xFF5856D6),
                              press: () {
                                print('New cases Infocard');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DetailsScreen();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
                      );
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Preventions",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildPrevention(),
                      SizedBox(
                        height: 20,
                      ),
                      buildHelpCard(context),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildPrevention() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventionCard(
          title: "Wash Hands",
          svgSrc: "assets/icons/hand_wash.svg",
        ),
        PreventionCard(
          title: "Use Masks",
          svgSrc: "assets/icons/use_mask.svg",
        ),
        PreventionCard(
          title: "Use Disinfectant",
          svgSrc: "assets/icons/Clean_Disinfect.svg",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              //Left side padding is 40% of the width of the container.
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Dial govt. helpline number 1075 \nfor medical help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
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

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            //HEADER of Drawer
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.8),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[350])),
                ),
                child: ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Call NMC Helpline'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                    launch("tel:0712-2567021");
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.grey[350]),
                )),
                child: ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Call govt. Helpline'),
                  onTap: () {
                    launch('tel:1075');
                    // Update the state of the app.
                    // ...
                  },
                ),
              ),
            ),

            Center(
              child: Container(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.feedback),
                            title: Text('Feedback'),
                            onTap: () {
                              launch(_emailLaunchUri.toString());
                            },
                          ),
                        ),
                        GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.code),
                            title: Text('Source'),
                            onTap: () {
                              _launchSourceURL();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventionCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventionCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}

_launchSourceURL() async {
  const url = 'https://bing.com/covid/local/nagpur_maharashtra_india';
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true, enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}

final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'neil.mehta310501@gmail.com',
    queryParameters: {'subject': 'FEEDBACK and BUGS of COVID19 Nagpur APP'});
