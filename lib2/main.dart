import 'package:KushProject/specific_report_card.dart';

import './profile_page.dart';

import './previous_report_card.dart';
import './calender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple),
      //routes: {
       // SpecificReportCard.routeName: (ctx) => SpecificReportCard()
      //},
    );
  }
}

class MyHomePage extends StatefulWidget
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  List<Widget> pages = [ProfilePage(), KushCalendar(), PreviousReports()] ;
  int selectPageIndex = 0 ;
  selectPage(int index)
  {
    setState(() {
      selectPageIndex = index ;
      print(selectPageIndex) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Row(mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[Container(child: Image.asset("assets/icon/Logo.png", height: 50, width: 50,)
        , decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),), SizedBox(width: 40,)
        , Text("आत्मनिरीक्षण", style: TextStyle(fontSize: 24, color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),),],)
      , backgroundColor: Colors.purple, actions: <Widget>[IconButton(icon: Icon(Icons.notifications_none), onPressed: () {},)],)
      , body: pages[selectPageIndex]
      , bottomNavigationBar: BottomNavigationBar(onTap: selectPage, backgroundColor: Colors.purple
        , selectedItemColor: Colors.yellow, unselectedItemColor: Colors.white, currentIndex: selectPageIndex
        , items: [BottomNavigationBarItem(icon: Icon(Icons.account_circle,)
      , title: Text("Profile"), backgroundColor: Colors.purple,)
    , BottomNavigationBarItem(icon: Icon(Icons.apps,)
    , title: Text("Calendar"), backgroundColor: Colors.purple,)
    , BottomNavigationBarItem(icon: Icon(Icons.list)
    , title: Text("Previous Reports"), backgroundColor: Colors.purple,),]),);
  }
}