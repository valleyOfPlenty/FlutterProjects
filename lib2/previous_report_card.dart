import './specific_report_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviousReports extends StatelessWidget
{

  void reportReview(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {return SpecificReportCard() ;})) ;
  }
  List monthList = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'] ;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(body: ListView.builder(itemBuilder: (context, index)
    {
      return InkWell(onTap: () {reportReview(context) ;},
          child: Container(alignment: Alignment.center, width: double.infinity, margin: EdgeInsets.all(10), padding: EdgeInsets.all(10), height: 80
        , color: Colors.yellow[200], child: Text(monthList[index]
          , style: TextStyle(fontSize: 20, color: Colors.purple, fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),),)) ;
    }, itemCount: 12,)) ;
  }

}