import 'package:flutter/material.dart' ;
class ChartBar extends StatelessWidget
{
  int spentAmount ;
  double spot ;
  String label ;
  ChartBar({this.label, this.spentAmount, this.spot}) ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[Text(spentAmount.toString()),SizedBox(height: 4,)
      , Container(height: 60, width: 10
        , child: Stack(children: <Widget>[Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1.0)
            , borderRadius: BorderRadius.circular(10)
      , color: Color.fromRGBO(220, 220, 220, 1),),), FractionallySizedBox(heightFactor: spot
        , child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor
        , borderRadius: BorderRadius.circular(10)),),)],),)
      , SizedBox(height: 4,), Text(label)],);
  }
}