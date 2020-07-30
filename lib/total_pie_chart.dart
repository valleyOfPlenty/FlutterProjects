import 'package:flutter/material.dart';
import './transaction.dart';

import 'package:pie_chart/pie_chart.dart';

class PieChartOfExpenses extends StatelessWidget
{
  List<Transaction> recentTransactionMonth ;
  PieChartOfExpenses(this.recentTransactionMonth) ;

  List<Map<String, Object>> get groupedTypeTV
  {

    return List.generate(9, (index) {
      List typo = [TypeOfExpenses.Medical, TypeOfExpenses.Entertainment, TypeOfExpenses.Transportation
        , TypeOfExpenses.Food, TypeOfExpenses.HouseItems, TypeOfExpenses.Electricity
        , TypeOfExpenses.Shopping, TypeOfExpenses.Education, TypeOfExpenses.Others] ;
      int totalSum = 0 ;
      for (int i = 0 ; i < recentTransactionMonth.length ; i++)
      {
        if (recentTransactionMonth[i].typeOfExpense == typo[index])
          {
            totalSum = totalSum + recentTransactionMonth[i].amount ;
          }
      }
      return {'Type': typo[index], 'Amount': totalSum};
    }).toList() ;
  }

  double get totalAmount
  {
    return groupedTypeTV.fold(0.0, (sum, item) {
      return sum + item['Amount'] ;
    }) ;
  }

  @override
  Widget build(BuildContext context)
  {
    print(groupedTypeTV) ;
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("Monthly  Expense  Details"),)
      , body: Container(margin: EdgeInsets.all(30)
        , child: Column(children: <Widget>[Text("THE SUM OF YOUR TOTAL EXPENSES FROM THIS MONTH IS:"
          , style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor),), SizedBox(width: double.infinity, height: 40,)
          , Text(totalAmount.toString()
          , style: TextStyle(fontWeight: FontWeight.w400, fontStyle: FontStyle.italic
                , fontSize: 30, color: Theme.of(context).accentColor),), SizedBox(width: double.infinity, height: 60,)
          , PieChart(dataMap: {"Medical": int.parse(groupedTypeTV[0]['Amount'].toString()).toDouble()
          , "Entertainment": int.parse(groupedTypeTV[1]['Amount'].toString()).toDouble()
          , "Transportation": int.parse(groupedTypeTV[2]['Amount'].toString()).toDouble()
          , "Food": int.parse(groupedTypeTV[3]['Amount'].toString()).toDouble()
          , "House Items": int.parse(groupedTypeTV[4]['Amount'].toString()).toDouble()
          , "Electricity": int.parse(groupedTypeTV[5]['Amount'].toString()).toDouble()
          , "Shopping": int.parse(groupedTypeTV[6]['Amount'].toString()).toDouble()
          ,  "Education": int.parse(groupedTypeTV[7]['Amount'].toString()).toDouble()
          , "Others": int.parse(groupedTypeTV[8]['Amount'].toString()).toDouble()},colorList: [
            Colors.purple,
            Colors.amber,
            Colors.grey,
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.pinkAccent,
            Colors.yellow,
            Colors.black
          ],)],),),
      ) ;
  }
}