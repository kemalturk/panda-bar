import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/pandabar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String page = 'Blue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(
        buttonData: [
          PandaBarButtonData(
            id: 'Blue',
            icon: Icons.dashboard,
            title: 'Blue',
          ),
          PandaBarButtonData(
            id: 'Green',
            icon: Icons.book,
            title: 'Green'
          ),
          PandaBarButtonData(
            id: 'Red',
            icon: Icons.account_balance_wallet,
            title: 'Red'
          ),
          PandaBarButtonData(
            id: 'Yellow',
            icon: Icons.notifications,
            title: 'Yellow'
          ),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text('Fab Button Pressed!'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Close'),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
          );
        },
      ),
      body: Builder(
        builder: (context) {

          switch (page) {
            case 'Green':
              return Container(color: Colors.green.shade500);
            case 'Blue':
              return Container(color: Colors.blue.shade900);
            case 'Red':
              return Container(color: Colors.red.shade900);
            case 'Yellow':
              return Container(color: Colors.yellow.shade700);
            default:
              return Container();
              
          }

        },
      ),
    );
  }
}
