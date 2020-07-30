import 'package:flutter/material.dart' ;
import 'package:intl/intl.dart';
import './transaction.dart' ;
import './chartbar.dart';

class Chart extends StatelessWidget
{
  List<Transaction> recentTransactions ;
  Chart(this.recentTransactions) ;
  List<Map<String, Object>> get groupedTransactionValues
  {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(Duration(days: index)) ;
      int totalSum = 0 ;
      for (int i = 0 ; i < recentTransactions.length ; i++)
        {
          if (recentTransactions[i].date.day == weekday.day
          && recentTransactions[i].date.month == weekday.month
          && recentTransactions[i].date.year == weekday.year)
            {
              totalSum += recentTransactions[i].amount ;
            }
        }
      return {'Day': DateFormat.E().format(weekday), 'AmountPerDay': totalSum};
    }).reversed.toList() ;
  }
  double get totalSpending
  {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['AmountPerDay'] ;
    }) ;
  }
  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    print(groupedTransactionValues) ;
    return Card(margin: EdgeInsets.all(20)
      , child: Container(padding: EdgeInsets.all(20)
        , child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: groupedTransactionValues.map((tx) {
        return ChartBar(label: tx['Day'], spentAmount: tx['AmountPerDay']
            , spot: totalSpending == 0 ? 0.0 : (tx['AmountPerDay'] as int)/ totalSpending ) ;
      }).toList(),),),) ;
  }
}