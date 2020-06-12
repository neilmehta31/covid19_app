import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/details_screen.dart';
import 'package:covid_19/widgets/infocard.dart';
import 'package:flutter/material.dart';

// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        cacheExtent: 100.0,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 40,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
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
                      title: "Confirmed Cases",
                      effectedNum: 1062,
                      iconColor: Color(0xFFFF8C00),
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Deaths",
                      effectedNum: 75,
                      iconColor: Color(0xFFFF2D55),
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Recovered",
                      effectedNum: 689,
                      iconColor: Color(0xFF50E3C2),
                      press: () {},
                    ),
                    InfoCard(
                      title: "New Cases",
                      effectedNum: 75,
                      iconColor: Color(0xFF5856D6),
                      press: () {
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
              ),
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
                            .title
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
                        .title
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
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        )
      ],
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
          style:
              Theme.of(context).textTheme.body2.copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
