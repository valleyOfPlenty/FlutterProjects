import 'package:flutter/material.dart';
import './transaction.dart';

class YearlyBarChart extends StatelessWidget
{
  final List<Transaction> recentTransactionYearly ;
  YearlyBarChart(this.recentTransactionYearly) ;

  final List year = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'] ;

  List<Map<String, Object>> get groupedYearTransactions
  {
    return List.generate(12, (index)
    {

      int totalSum = 0 ;
      for (int i = 0 ; i < recentTransactionYearly.length ; i++)
      {
        if (recentTransactionYearly[i].date.month == (index+1))
        {
          totalSum = totalSum + recentTransactionYearly[i].amount ;
        }
      }
      return {'Month': year[index], 'AmountPerMonth': totalSum};
    }).toList() ;
  }
  double get totalAmountInYear
  {
    return groupedYearTransactions.fold(0.0, (sum, item) {
      return sum + item['AmountPerMonth'] ;
    }) ;
  }
  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("Yearly Expense Details"),)
        , body: Container(margin: EdgeInsets.all(30), color: Colors.grey[300], padding: EdgeInsets.all(10)
    , child: Column(children: <Widget>[Text("THE SUM OF YOUR TOTAL EXPENSES FROM THIS YEAR IS:"
    , style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor),), SizedBox(width: double.infinity, height: 20,)
    , Text(totalAmountInYear.toString()
    , style: TextStyle(fontWeight: FontWeight.w400, fontStyle: FontStyle.italic
    , fontSize: 30, color: Theme.of(context).accentColor),)
          , Container(margin: EdgeInsets.all(20), height: MediaQuery.of(context).size.height*0.5,
            child: ListView.builder(itemBuilder: (context, index){
              return Container(height: 75, child: Card(color: Colors.amber[200]
                , child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround
                , children: <Widget>[Text(groupedYearTransactions[index]['Month']
                , style: TextStyle(color: Theme.of(context).primaryColor, fontStyle: FontStyle.italic, fontSize: 22),)
              , Text(groupedYearTransactions[index]['AmountPerMonth'].toString()
                  , style: TextStyle(color: Theme.of(context).primaryColor
                      , fontStyle: FontStyle.italic, fontSize: 22),)],),),) ;
            }, itemCount: groupedYearTransactions.length,),)],),),) ;
  }

}