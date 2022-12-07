import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _curruntIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("GASTLESSEN PLANNER")),
        body: SizedBox.expand(
            child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _curruntIndex = index;
            });
          },
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              color: Colors.indigo,
            ),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.purpleAccent,
            ),
          ],
        )),
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: _curruntIndex,
            onItemSelected: (index) {
              setState(() {
                _pageController.jumpToPage(index);
              });
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(title: Text("Home"), icon: Icon(Icons.home)),
              BottomNavyBarItem(
                  title: Text("Agenda"), icon: Icon(Icons.view_agenda)),
              BottomNavyBarItem(
                  title: Text("Messages"), icon: Icon(Icons.chat_bubble)),
              BottomNavyBarItem(
                  title: Text("Settings"), icon: Icon(Icons.settings)),
            ]),
      ),
    );
  }
}
