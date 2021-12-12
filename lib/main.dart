import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_app/widgets/appBar.dart';
import 'package:tinder_app/widgets/bottomBar.dart';
import 'package:tinder_app/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  List<String> name = ['Shweta', 'Rahul', 'Ananya', 'Jackie'];

  @override
  void initState() {
    for (int i = 0; i < name.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(name[i]),
          likeAction: () {},
          nopeAction: () {},
          superlikeAction: () {}));
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70),
            TopBar(),
            Expanded(
                child: Container(
              child: SwipeCards(
                  matchEngine: _matchEngine,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        image:
                            DecorationImage(image: AssetImage(images[index])),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [Text(name[index])],
                      ),
                    );
                  },
                  onStackFinished: () {
                    return ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('The list is over')));
                  }),
            )),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}

class Content {
  final String? text;
  Content(this.text);
}
