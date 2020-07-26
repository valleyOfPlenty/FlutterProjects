
import 'package:flutter/material.dart';

class PasswordsModalBottomSheet extends StatefulWidget
{
  final Function addEl ;
  PasswordsModalBottomSheet(this.addEl) ;

  @override
  _PasswordsModalBottomSheetState createState() => _PasswordsModalBottomSheetState();
}

class _PasswordsModalBottomSheetState extends State<PasswordsModalBottomSheet> {
  final id = TextEditingController() ;

  final pass = TextEditingController() ;

  void submit()
  {
    if (id == null || pass == null)
      {
        id.clear() ;
        pass.clear() ;
        return ;
      }
    else
      {
        return widget.addEl(id.text, pass.text) ;
      }
  }

  bool _showPassword = false ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Card(child: Padding(child: Column(children: <Widget>[
      TextField(controller: id, cursorColor: Colors.black, cursorRadius: Radius.circular(5.0)
      , decoration: InputDecoration(labelText: 'ID', prefixIcon: Icon(Icons.bookmark)
      , labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 20.0)),)
    , TextField(controller: pass, cursorColor: Colors.black, cursorRadius: Radius.circular(5.0), obscureText: !this._showPassword
        , decoration: InputDecoration(labelText: 'PASSWORD', prefixIcon: Icon(Icons.security)
          , suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), color: this._showPassword ? Colors.blue : Colors.grey
              , onPressed: () {setState(() {
                this._showPassword = !this._showPassword ;
              });})
          , labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 20.0),),)
      , RaisedButton(child: Text('ADD INFO', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),)
        , onPressed: () {submit() ;}, color: Colors.black, padding: EdgeInsets.all(15),),]
      , crossAxisAlignment: CrossAxisAlignment.end,)
      , padding: EdgeInsets.all(15),),),) ;
  }
}