import 'package:flutter/material.dart';

import '../constants.dart';
import 'infocard.dart';

class InfoPannel extends StatelessWidget {
    final List dataAsMap;


  const InfoPannel({
    Key key, this.dataAsMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            effectedNum:dataAsMap[20]["districtData"][18]["confirmed"],
            iconColor: Color(0xFFFF8C00),
            press: () {
              print('Confirmed Cases Infocard');
            },
          ),
          InfoCard(
            title: "Total Deaths",
            effectedNum: dataAsMap[20]["districtData"][18]["deceased"],
            iconColor: Color(0xFFFF2D55),
            press: () {
              print('Total Deaths Infocard');
            },
          ),
          InfoCard(
            title: "Total Recovered",
            effectedNum: dataAsMap[20]["districtData"][18]["recovered"],
            iconColor: Color(0xFF50E3C2),
            press: () {
              print('Total recovered Infocard');
            },
          ),
          InfoCard(
            title: "Active Cases",
            effectedNum: dataAsMap[20]["districtData"][18]["active"],
            iconColor: Color(0xFF820909),
            press: () {
              print('Active cases Infocard');
            },
          ),
          InfoCard(
            title: "New Cases",
            effectedNum: dataAsMap[20]["districtData"][18]["delta"]["confirmed"],
            iconColor: Color(0xFF5856D6),
            press: () {
              print('New cases Infocard');
            },
          ),
          InfoCard(
            title: "Recovered today",
            effectedNum: dataAsMap[20]["districtData"][18]["delta"]["recovered"],
            iconColor: Color(0xFFFF47FF),
            press: () {
              print('Recovered today Infocard');
            },
          ),
        ],
      )),
    );
  }
}
