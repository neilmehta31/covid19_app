import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              //HEADER of Drawer
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/mask.jpg'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                ),
                child: null,
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.add_call,
                  color: Colors.green,
                ),
                title: Text('NMC Helpline'),
                subtitle: Text(
                  'Nagpur Municipal Corporation helpline for queries related to COVID-19',
                  style: TextStyle(color: Colors.grey[500]),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[350])),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.call,
                          color: Colors.blue,
                        ),
                        title: Text('0712-2567021'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                          launch("tel:0712-2567021");
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[350])),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.call,
                          color: Colors.blue,
                        ),
                        title: Text('0712-2551866'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                          launch("tel:0712-2551866");
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[350])),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.call,
                          color: Colors.blue,
                        ),
                        title: Text('18002333764'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                          launch("tel:18002333764");
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  child: Container(
                    child: ListTile(
                      leading: Icon(
                        Icons.call,
                        color: Colors.blue,
                      ),
                      title: Text('Call GOVT. Helpline'),
                      subtitle: Text(
                        'Health ministry toll-free helpline for queries related to COVID-19',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      onTap: () {
                        launch('tel:1075');
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                child: ListTile(
                  leading: Icon(
                    Icons.contact_mail,
                    color: Colors.lightBlue,
                  ),
                  title: Text('E-pass to travel out of Nagpur'),
                  onTap: () {
                    _launchEpass();
                  },
                ),
              ),
              Center(
                child: Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.code,
                            color: Colors.deepOrange,
                          ),
                          title: Text('Source'),
                          subtitle: Text('www.covid19india.org'),
                        ),
                        GestureDetector(
                          child: ListTile(
                            leading: Icon(
                              Icons.feedback,
                              color: Colors.deepPurple,
                            ),
                            title: Text('Feedback'),
                            onTap: () {
                              launch('https://forms.gle/i9AAHmKNZfy7gNKJ8');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/icons/wfh.jpg'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.bookmark,color: Colors.amber,),
                title: Text.rich(TextSpan(
                  text:"Developed By Neil Mehta",
                  style:TextStyle(color: Colors.grey[600]),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_launchEpass() async {
  const url = 'https://covid19.mhpolice.in/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}