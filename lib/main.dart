import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EditImage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),() => callScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff622F74),
              gradient: LinearGradient(
                colors: [Color(0xff6094e8),Color(0xffde5cbc)],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(Icons.camera_rear,size: 50.0,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text("EditImage",
                      style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),)
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Text("Loading...",style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  callScreen(){
    Route route = MaterialPageRoute(builder: (context) => TabUI());
    Navigator.push(this.context, route);
  }
}

class TabUI extends StatefulWidget {
  @override
  TabUIState createState() => TabUIState();
}

class TabUIState extends State<TabUI> {

  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final Key keyThree = PageStorageKey('pageThree');
  final Key keyFour = PageStorageKey('pageFour');

  int currentTab = 0;

  PageOne one;
  PageTwo two;
  PageThree three;
  PageFour four;
  List<Widget> pages;
  Widget currentPage;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {

    one = PageOne(
      key: keyOne
    );
    two = PageTwo(
      key: keyTwo,
    );
    three = PageThree(
      key: keyThree,
    );
    four = PageFour(
      key: keyFour,
    );

    pages = [one, two, three,four];

    currentPage= one;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("EditPicture"),
        ),
        body: PageStorage(
          child: currentPage,
          bucket: bucket,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (int index) {
              setState(() {
                currentTab = index;
                currentPage = pages[index];
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.blue[800],),
                title: Text("Home")
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera, color: Colors.blue[800],),
                title: Text("Camera")
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.crop,color: Colors.blue[800]),
                title: Text("Crop")
              ),
              BottomNavigationBarItem(
                icon:  Icon(Icons.person_outline,color: Colors.blue[800]),
                title: Text("MyData")
              )
            ]
        ),
      ),
    );
  }
}

class bottomBar extends StatefulWidget {
  @override
  _bottomBarState createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8,right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.home),
          Icon(Icons.camera),
          Icon(Icons.crop),
          Icon(Icons.person_outline)
        ],
      ),
    );
  }
}

class PageOne extends StatefulWidget {

  PageOne({
    Key key
  }) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Text("Page One"),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {

  PageTwo({
    Key key
  }) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {

  File image;

  galleryImage() async{
    image=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }

  cameraImage() async{
    image=await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {

    });
  }

  baseUI(){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: CircleAvatar(
                        child: Icon(Icons.camera_alt,size: 50,),radius: 50.0,
                      ),
                      onPressed: cameraImage,
                      color: Colors.orange,
                    ),

                    Text("Camera")
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: CircleAvatar(
                        child: Icon(Icons.image,size: 50,),radius: 50.0,
                      ),
                      onPressed: galleryImage,
                      color: Colors.orange,
                    ),

                    Text("Gallary")
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: image == null ? baseUI() : Image.file(image)
      ),
    );
  }
}

class PageThree extends StatefulWidget {

  PageThree({
    Key key
  }) : super(key: key);

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Text("Page Three"),
      ),
    );
  }
}

class PageFour extends StatefulWidget {

  PageFour({
    Key key
  }) : super(key: key);

  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Text("Page Four"),
      ),
    );
  }
}
