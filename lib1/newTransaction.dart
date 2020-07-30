import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart' ;
import './transactionList.dart';
class NewTransactions extends StatefulWidget
{
  Function addtrx ;
  NewTransactions(this.addtrx) ;

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final inputTitle = TextEditingController() ;
  DateTime selectDate ;
  final inputAmount = TextEditingController() ;
  TypeOfExpenses type ;
  int radioValue ;

  @override
  void initState() {
    // TODO: implement initState
    radioValue = 0 ;
    super.initState();
  }

  void submitData()
  {
    if (inputTitle.text.isEmpty || int.parse(inputAmount.text) <= 0 || inputAmount.text.isEmpty || selectDate == null || radioValue == 0)
      {
        inputAmount.clear() ;
        inputTitle.clear() ;
        return ;
      }
    else
      {
        widget.addtrx(inputTitle.text, int.parse(inputAmount.text), selectDate, type).catchError((error){
          showDialog(context: context, builder: (_) => AlertDialog(title: Text("An error occurred"), content: Text("Something went wrong")
            , actions: <Widget>[FlatButton(child: Text("Okay"), onPressed: () {Navigator.of(context).pop() ;},)],)) ;
        }) ;
        inputAmount.clear() ;
        inputTitle.clear() ;
      }
  }
  void presentDatePicker()
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019)
        , lastDate: DateTime.now()).then((pickedDate){
          if (pickedDate == null)
            {
              return ;
            }
          setState(() {
            selectDate = pickedDate ;
          });
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Card(child: Column(children: [TextField(decoration: InputDecoration(labelText: "TITLE: ")
      , controller: inputTitle,)
      ,TextField(decoration: InputDecoration(labelText: "AMOUNT: "), controller: inputAmount, keyboardType: TextInputType.number,)
      , Container(padding: EdgeInsets.all(10), height: 40
          , child: Row(children: [Text(selectDate == null ? "No Date Chosen" : DateFormat.yMMMd().format(selectDate))
        , FlatButton(child: Text("Choose Date", style: TextStyle(color: Theme.of(context).primaryColor),)
          , onPressed: presentDatePicker,)], mainAxisAlignment: MainAxisAlignment.spaceBetween,))
      , RaisedButton(child: Text("Add Transaction",style: TextStyle(color: Colors.white),), color: Theme.of(context).primaryColor
          , onPressed: () {
        submitData() ;
          }, textColor: Colors.purpleAccent)
    , Container(height: 40,
      child: Row(children: <Widget>[Container(margin: EdgeInsets.symmetric(horizontal: 5)
      , child: Row(children: [Text("Electricity"), Radio(value: 1, groupValue: radioValue
            , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
              radioValue = val ;
              type = TypeOfExpenses.Electricity ;
            }),),],),)
          , Container(margin: EdgeInsets.symmetric(horizontal: 5)
        , child: Row(children: <Widget>[Text("House  Items"), Radio(value: 2, groupValue: radioValue
              , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
                radioValue = val ;
                type = TypeOfExpenses.HouseItems ;
              }),),],),)
          , Container(margin: EdgeInsets.symmetric(horizontal: 5)
        , child: Row(children: [Text("Food"), Radio(value: 3, groupValue: radioValue
              , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
                radioValue = val ;
                type = TypeOfExpenses.Food ;
              }),),],),),],),
    )
      , Container(height: 40, margin: EdgeInsets.symmetric(horizontal: 5),
        child: Row(children: <Widget>[Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround
            , children: [Text("Transport")
          , Radio(value: 4, groupValue: radioValue
            , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
              radioValue = val ;
              type = TypeOfExpenses.Transportation ;
            }),),],),)
            , Container(margin: EdgeInsets.symmetric(horizontal: 5)
            , child: Row(children: [Text("Entertainment"), Radio(value: 5, groupValue: radioValue
              , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
                radioValue = val ;
                type = TypeOfExpenses.Entertainment ;
              }),),],),)
            , Container(child: Row(children: [Text("Meds"), Radio(value: 6, groupValue: radioValue
              , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
                radioValue = val ;
                type = TypeOfExpenses.Medical ;
              }),)],),
      ),],),)
      , Container(height: 40, margin: EdgeInsets.symmetric(horizontal: 7),
        child: Row(children: <Widget>[Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround
          , children: [Text("Shopping")
            , Radio(value: 7, groupValue: radioValue
              , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
                radioValue = val ;
                type = TypeOfExpenses.Shopping ;
              }),),],),)
          , Container(margin: EdgeInsets.symmetric(horizontal: 15)
            , child: Row(children: [Text("Education"), Radio(value: 8, groupValue: radioValue
              , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
                radioValue = val ;
                type = TypeOfExpenses.Education ;
              }),),],),)
          , Container(child: Row(children: [Text("Others"), Radio(value: 9, groupValue: radioValue
            , activeColor: Theme.of(context).accentColor, onChanged: (val) => setState(() {
              radioValue = val ;
              type = TypeOfExpenses.Others ;
            }),)],),
          ),],),)], crossAxisAlignment: CrossAxisAlignment.end,),)
      , padding: EdgeInsets.all(10), margin: EdgeInsets.all(10),);
  }
}