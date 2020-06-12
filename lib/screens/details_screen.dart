import 'package:covid_19/constants.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: kPrimaryColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
