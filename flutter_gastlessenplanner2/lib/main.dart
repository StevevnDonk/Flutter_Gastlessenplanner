import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/flutter_agenda.dart';
import 'package:getwidget/getwidget.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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

  late List<Resource> resources = <Resource>[
    Resource(head: Header(title: 'test', object: 1), events: [
      AgendaEvent(
        title: 'Test Title',
        subtitle: 'Geen',
        backgroundColor: Colors.blue,
        start: EventTime(hour: 10, minute: 0),
        end: EventTime(hour: 10, minute: 30),
      ),
    ])
  ];

  @override
  Widget build(BuildContext context) {
    MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(title: const Text("GASTLESSEN PLANNER")),
            body: SizedBox.expand(
                child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _curruntIndex = index;
                });
              },
              children: [
                GFCard(
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.start,
                  image: Image.asset(
                    'lib/assets/cup.jpg',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  showImage: true,
                  title: GFListTile(
                    avatar: GFAvatar(
                      backgroundImage: AssetImage('assets/macbook.jpg'),
                    ),
                    titleText: 'Title',
                    subTitleText: 'Sub Title',
                  ),
                  content: Text("Some quick example text to build on the card"),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFAvatar(
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.DARK,
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.DANGER,
                        child: Icon(
                          Icons.help,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                FlutterAgenda(
                  resources: resources,
                  agendaStyle: const AgendaStyle(
                    startHour: 9,
                    endHour: 20,
                    direction: TextDirection.ltr,
                    headerLogo: HeaderLogo.bar,
                    timeItemWidth: 45,
                    timeSlot: TimeSlot.quarter,
                  ),
                  onTap: (clickedTime, object) {
                    print(
                        "Clicked time: ${clickedTime.hour}:${clickedTime.minute}");
                    // dont forget to cast the object back to it's original type
                    print("Head Object related to the resource: $object");
                  },
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
                  BottomNavyBarItem(
                      title: const Text("Home"), icon: const Icon(Icons.home)),
                  BottomNavyBarItem(
                      title: const Text("Agenda"),
                      icon: const Icon(Icons.view_agenda)),
                  BottomNavyBarItem(
                      title: const Text("Messages"),
                      icon: const Icon(Icons.chat_bubble)),
                  BottomNavyBarItem(
                      title: const Text("Settings"),
                      icon: const Icon(Icons.settings)),
                ]),
          ),
        ));
  }
}
