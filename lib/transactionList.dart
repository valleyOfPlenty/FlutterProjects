import 'package:flutter/material.dart' ;
import './transaction.dart' ;
import 'package:intl/intl.dart' ;
class TransactionList extends StatelessWidget
{
  final List<Transaction> trans ;
  final Function deleteTx ;
  TransactionList({this.trans, this.deleteTx}) ;

  String expenseType(TypeOfExpenses typeOfExpense)
  {
    if (typeOfExpense == TypeOfExpenses.Electricity)
      {
        return "Electricity" ;
      }
    if (typeOfExpense == TypeOfExpenses.HouseItems)
      {
        return "House Items" ;
      }
    if (typeOfExpense == TypeOfExpenses.Food)
      {
        return "Food" ;
      }
    if (typeOfExpense == TypeOfExpenses.Transportation)
      {
        return "Transport" ;
      }
    if (typeOfExpense == TypeOfExpenses.Entertainment)
      {
        return "Entertainment" ;
      }
    if (typeOfExpense == TypeOfExpenses.Medical)
      {
        return "Meds" ;
      }
    if (typeOfExpense == TypeOfExpenses.Shopping)
      {
        return "Shopping" ;
      }
    if (typeOfExpense == TypeOfExpenses.Education)
      {
        return "Education" ;
      }
    else
      {
        return "Others" ;
      }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(height: MediaQuery.of(context).size.height*0.5
      , child: trans.isEmpty ? Image.network('https://cdn5.vectorstock.com/i/1000x1000/85/24/monthly-expenses-template-vector-4988524.jpg') : ListView.builder(itemBuilder: (context, index)
    {
      return Card(child: Row(children: <Widget>[Container(child: Row(children: [Container(child: Text('Rs. '+(trans[index].amount).toString()
              , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple, fontStyle: FontStyle.italic),)
              , decoration: BoxDecoration(border: Border.all(width: 2, color: Theme.of(context).primaryColor,),),padding: EdgeInsets.all(10)
              , margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),)
              , Column(children: [Text(trans[index].title, style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),)
                , Text(DateFormat.yMMMd().format(trans[index].date), style: TextStyle(color: Colors.grey),)
                , IconButton(icon: Icon(Icons.delete), color: Colors.red, onPressed: () {deleteTx(trans[index].id).catchError((error){
                  showDialog(context: context, builder: (_) => AlertDialog(title: Text("An error occurred"), content: Text("Something went wrong")
            , actions: <Widget>[FlatButton(child: Text("Okay"), onPressed: () {Navigator.of(context).pop() ;},)],)) ;
          }) ;},)]
                , crossAxisAlignment: CrossAxisAlignment.start,)],),
          )
          , Container(margin: EdgeInsets.all(20.0), child: Text(expenseType(trans[index].typeOfExpense)
          , style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic
              , fontWeight: FontWeight.w400, color: Theme.of(context).accentColor),),),]
        , mainAxisAlignment: MainAxisAlignment.spaceBetween,),);
    }, itemCount: trans.length,),) ;
  }
}