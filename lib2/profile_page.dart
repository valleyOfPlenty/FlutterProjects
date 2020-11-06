import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget
{
  List deadlineList = ['None', 'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'] ;

  Widget createDeadline(BuildContext ctx, String status, String type, String name)
  {
    return InkWell(onTap: () {}, child: Container(height: 200, padding: EdgeInsets.all(10), margin: EdgeInsets.all(10)
      , color: status == "Completed" ? Colors.yellow[200] : Colors.purple[200]
      , width: MediaQuery.of(ctx).size.width*0.8, child: Column(children: <Widget>[Container(margin: EdgeInsets.all(10), alignment: Alignment.topCenter
          , child: Text(name, style: TextStyle(fontSize: 24, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)))
        , Container(margin: EdgeInsets.all(10)
          , child: Text("Type :  "+type.toUpperCase(), style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))
          , alignment: Alignment.topLeft,)
        , Container(margin: EdgeInsets.all(10)
          , child: Text("Status :  "+status.toUpperCase(), style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))
          , alignment: Alignment.topLeft,)
        , Container(margin: EdgeInsets.all(10)
          , child: Text("Deadline :  END OF "+ deadlineList[DateTime.now().month]
              , style: TextStyle(fontSize: 18, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400))
          , alignment: Alignment.topLeft,)],),)) ;
  }
  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(
      child: Column(children: <Widget>[Container(child: Image.network("https://scontent.fdel1-1.fna.fbcdn.net/v/t1.0-9/109489550_161223528802123_3238691200619610269_n.jpg?_nc_cat=109&_nc_sid=09cbfe&_nc_ohc=i4SG7h5puXQAX9EEnMG&_nc_ht=scontent.fdel1-1.fna&oh=284d31ce2cd31ef9ef158342d5c4f65c&oe=5F57F9DE",)
        , width: double.infinity, height: 200, alignment: Alignment.topCenter, padding: EdgeInsets.all(10), margin: EdgeInsets.all(10),)
        , Text("Name: Arnav Rastogi", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 22),)
        , createDeadline(context, "Completed", "iq", "BITT")
        , createDeadline(context, "Completed", "iq", "Sherlock's Quest")
        , createDeadline(context, "Uncompleted", "comprehensive ability", "Brain Storm")
        , createDeadline(context, "Completed", "comprehensive ability", "Answer Hunt")
        , createDeadline(context, "Uncompleted", "memorization", "Mind It")
        , createDeadline(context, "Completed", "memorization", "Hocus Focus")
        , createDeadline(context, "Uncompleted", "puzzles", "Puzzles Nuzzles")
        , createDeadline(context, "Completed", "puzzles", "Plazzale X")
        , createDeadline(context, "Uncompleted", "psychic", "Think Over It")
        , createDeadline(context, "Completed", "psychic", "Know Yourself")],),
    ));
  }
}