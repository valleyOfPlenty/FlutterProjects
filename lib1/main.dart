import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './http_delete_exception.dart';
import './total_bar_chart.dart';
import './total_pie_chart.dart';
import './newTransaction.dart';
import './transactionList.dart';
import './transaction.dart';
import './chart.dart' ;
import 'dart:convert';
import 'package:http/http.dart' as http ;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Proper App", theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.amber), home: MyHomePage());
  }
}
class MyHomePage extends StatefulWidget
{  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  List<Transaction> trx = [] ;
  Future<void> addNewElement(String t, int a, DateTime chosenDate, TypeOfExpenses toe)
  {
    Transaction newtrx2 ;
    Transaction newtrx = new Transaction(id: (DateTime.now()).toString(), title: t, amount: a, date: chosenDate, typeOfExpense: toe) ;
    const url = "https://expense-tracker-b42ce.firebaseio.com/items.json" ;
    return http.post(url, body: json.encode({
      'Title': newtrx.title,
      'Amount': newtrx.amount,
      'Date': newtrx.date.toString(),
      'Type': newtrx.typeOfExpense.toString()
    })).then((response){
      print(json.decode(response.body)['name']) ;
      Transaction newtrx2 = new Transaction(id: json.decode(response.body)['name'], title: t, amount: a, date: chosenDate, typeOfExpense: toe) ;
      print(newtrx2.id) ;
      setState(() {
        trx.add(newtrx2) ;
      });
    }).catchError((error){
      throw error ;
    }) ;
  }
  List<Transaction> get recTrans
  {
    return trx.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))) ;
    }).toList() ;
  }
  List<Transaction> get recTransMonth
  {
    return trx.where((tx) {
      return tx.date.month == DateTime.now().month ;
    }).toList() ;
  }
  List<Transaction> get recTransYear
  {
    return trx.where((tx) {
      //return tx.date.isAfter(DateTime.now().subtract(Duration(days: 30))) ;
      return tx.date.year == DateTime.now().year ;
    }).toList() ;
  }
 void startNewTransaction(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (bctx) {
      return GestureDetector(child: NewTransactions(addNewElement), onTap: () {}, behavior: HitTestBehavior.opaque);
    }) ;
  }
  Future<void> deleteTrans(String id)
  {
      String urlDel = "https://expense-tracker-b42ce.firebaseio.com/items/$id.json" ;
      return http.delete(urlDel).then((response){
        if (response.statusCode >= 400)
          {
            throw HttpDelException("Deletion not possible") ;
          }
        else
          {
            setState(() {
              trx.removeWhere((tx) {
                return tx.id == id ;
              }) ;
            });
          }
      }) ;
  }

  void navigatePie(context)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PieChartOfExpenses(recTransMonth))) ;
  }
  void navigateBar(context)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => YearlyBarChart(recTransYear))) ;
  }
  var isInit = true ;
 Future<void> didChangeDependencies() async
 {
   try
   {
     const url = "https://expense-tracker-b42ce.firebaseio.com/items.json";
     if (isInit)
     {
       final response = await http.get(url);
       Map<String, dynamic> extractedData = json.decode(response.body);
       List<Transaction> loadtrx = [];
       extractedData.forEach((prodId, prodData) {
         loadtrx.add(Transaction(
             id: prodId,
             title: prodData['Title'],
             amount: prodData['Amount'],
             date: DateTime.parse(prodData['Date']),
             typeOfExpense: TypeOfExpenses.values.firstWhere((element) => element.toString() == prodData['Type'])));
       });
       setState(() {
         trx = loadtrx;
       });
       print(trx) ;
     }
     isInit = false;
   }
   catch (error)
   {
     throw error ;
   }
   super.didChangeDependencies() ;
 }
  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("व्यय  विवरण", style: TextStyle(fontSize: 26, fontStyle: FontStyle.italic),)
      , actions: <Widget>[IconButton(icon: Icon(Icons.list), onPressed: () {navigateBar(context) ;},)
        , IconButton(icon: Icon(Icons.pie_chart),onPressed: () {navigatePie(context) ;},),],)
      ,body: SingleChildScrollView(child: Column(children: [Chart(recTrans), TransactionList(trans: trx, deleteTx: deleteTrans)],),),
    floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {startNewTransaction(context) ;}, )
      , floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,);
  }
}