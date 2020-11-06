import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecificReportCard extends StatefulWidget
{
  @override
  _SpecificReportCardState createState() => _SpecificReportCardState();
}

class _SpecificReportCardState extends State<SpecificReportCard> {
  int presentDDBValue = 12 ;
  int radioValue ;
  void initState() {
    // TODO: implement initState
    radioValue = 0 ;
    super.initState();
  }

  TextEditingController perfectGrade = TextEditingController() ;
  TextEditingController strengthsText = TextEditingController() ;
  TextEditingController weaknessesText = TextEditingController() ;
  TextEditingController elseText = TextEditingController() ;

  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Scaffold(appBar: AppBar(backgroundColor: Colors.black,),
      body: SingleChildScrollView(child: Center(
        child: Column(children: <Widget>[Container(height: MediaQuery.of(context).size.height*0.8, width: MediaQuery.of(context).size.width*0.95
          , decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.yellow, width: 5))
          , padding: EdgeInsets.all(3), margin: EdgeInsets.all(2), alignment: Alignment.topCenter
          , child: Column(
            children: <Widget>[
              Text("Self Analysis"
                  , style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))
              , Container(alignment: Alignment.topLeft
                , child: Row(children: <Widget>[Text("What GRADE do you want to give yourself ?     ")
                  , Container(color: Colors.yellow[200], padding: EdgeInsets.symmetric(horizontal: 5),
                    child: DropdownButton(value: presentDDBValue
                      , items: [DropdownMenuItem(child: Text("Ex1"), value: 1,)
                      , DropdownMenuItem(child: Text("Ex2"), value: 2)
                        , DropdownMenuItem(child: Text("A1"), value: 3)
                        , DropdownMenuItem(child: Text("A2"), value: 4)
                        , DropdownMenuItem(child: Text("A3"), value: 5)
                        , DropdownMenuItem(child: Text("B1"), value: 6)
                        , DropdownMenuItem(child: Text("B2"), value: 7)
                        , DropdownMenuItem(child: Text("B3"), value: 8)
                        , DropdownMenuItem(child: Text("B4"), value: 9)
                        , DropdownMenuItem(child: Text("B5"), value: 10)
                        , DropdownMenuItem(child: Text("C1"), value: 11)
                        , DropdownMenuItem(child: Text("C2"), value: 12)
                        , DropdownMenuItem(child: Text("C3"), value: 13)
                        , DropdownMenuItem(child: Text("C4"), value: 14)
                        , DropdownMenuItem(child: Text("C5"), value: 15)
                        , DropdownMenuItem(child: Text("D1"), value: 16)
                        , DropdownMenuItem(child: Text("D2"), value: 17)
                        , DropdownMenuItem(child: Text("D3"), value: 18)
                        , DropdownMenuItem(child: Text("D4"), value: 19)
                        , DropdownMenuItem(child: Text("D5"), value: 20)
                        , DropdownMenuItem(child: Text("E1"), value: 21)
                        , DropdownMenuItem(child: Text("E2"), value: 22)
                        , DropdownMenuItem(child: Text("E3"), value: 23)
                        , DropdownMenuItem(child: Text("F"), value: 24)]
                      , onChanged: (value){
                      setState(() {
                        presentDDBValue = value ;
                      });
                      },),
                  )],),)
              , Container(margin: EdgeInsets.all(10), alignment: Alignment.topLeft
                  , child: Column(children: <Widget>[Text("Ques 1: Why do you think this grade is perfect for you?")
                    , TextField(controller: perfectGrade, cursorColor: Colors.black
                        , style: TextStyle(backgroundColor: Colors.white, color: Colors.black))], crossAxisAlignment: CrossAxisAlignment.start,))
              , Container(margin: EdgeInsets.all(10), alignment: Alignment.topLeft
                  , child: Column(children: <Widget>[Text("Ques 2: Are you satisfied with your grade?")
                    , Row(children: <Widget>[Text("Options : "), Text("YES"), Radio(value: 1, groupValue: radioValue
                          , activeColor: Colors.black, onChanged: (val) => setState(() {
                            radioValue = val ;
                          }),), SizedBox(width: 50,), Text("NO"), Radio(value: 2, groupValue: radioValue
                          , activeColor: Colors.black, onChanged: (val) => setState(() {
                            radioValue = val ;
                          }),)], mainAxisAlignment: MainAxisAlignment.spaceAround,)]
                    , crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceAround,))
              , Container(margin: EdgeInsets.all(10), alignment: Alignment.topLeft
                  , child: Column(children: <Widget>[Text("Ques 3: What else you think you can do to improve your grade?")
                    , TextField(controller: elseText, cursorColor: Colors.black
                        , style: TextStyle(backgroundColor: Colors.white, color: Colors.black))], crossAxisAlignment: CrossAxisAlignment.start,))
              , Container(margin: EdgeInsets.all(10), alignment: Alignment.topLeft
                  , child: Column(children: <Widget>[Text("Ques 4: What you think your strengths are ?")
                    , TextField(controller: strengthsText, cursorColor: Colors.black
                        , style: TextStyle(backgroundColor: Colors.white, color: Colors.black))], crossAxisAlignment: CrossAxisAlignment.start,))
              , Container(margin: EdgeInsets.all(10), alignment: Alignment.topLeft
                  , child: Column(children: <Widget>[Text("Ques 5: What you think your weaknesses are?")
                    , TextField(controller: weaknessesText, cursorColor: Colors.black
                    , style: TextStyle(backgroundColor: Colors.white, color: Colors.black),)], crossAxisAlignment: CrossAxisAlignment.start,),)],
          ),)
        , Container(height: MediaQuery.of(context).size.height*0.8, width: MediaQuery.of(context).size.width*0.9
            , decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.yellow, width: 5))
            , padding: EdgeInsets.all(10), margin: EdgeInsets.all(10), alignment: Alignment.topCenter
            , child: Column(
              children: <Widget>[
                Text("My Capabilities"
                    , style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))
              , Container(margin: EdgeInsets.all(10), child: Text("After analysing your test results, we have following conclusions : "
              , style: TextStyle(fontSize: 20), ))
                , Container(alignment: Alignment.center, height: 100, width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.all(15)
                  , child: Column(children: <Widget>[Text("Logical Reasoning", style: TextStyle(fontSize: 20),)
                  , RaisedButton(onPressed: () {}, color: Colors.white, child: Text("EXPLANATION", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),)]
                  , mainAxisAlignment: MainAxisAlignment.spaceAround,),)
                , Container(alignment: Alignment.center, height: 100, width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.all(15)
                  , child: Column(children: <Widget>[Text("Brain Capacity", style: TextStyle(fontSize: 20),)
                    , RaisedButton(onPressed: () {}, color: Colors.white, child: Text("EXPLANATION", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),)]
                    , mainAxisAlignment: MainAxisAlignment.spaceAround,),)
                , Container(alignment: Alignment.center, height: 100, width: MediaQuery.of(context).size.width*0.9, margin: EdgeInsets.all(15)
                  , child: Column(children: <Widget>[Text("Comprehensive Ability", style: TextStyle(fontSize: 20),)
                    , RaisedButton(onPressed: () {}, color: Colors.white, child: Text("EXPLANATION", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),)]
                    , mainAxisAlignment: MainAxisAlignment.spaceAround,),)],
            ),)],),
      ),),);
  }
}