import 'package:flutter/material.dart' ;

enum TypeOfExpenses
{
  Electricity,
  Food,
  Entertainment,
  HouseItems,
  Medical,
  Transportation,
  Education,
  Shopping,
  Others

}
class Transaction
{
  String id;
  int amount;
  DateTime date;
  String title;
  TypeOfExpenses typeOfExpense;

  Transaction({this.id, this.title, this.amount, this.date, this.typeOfExpense}) ;
}