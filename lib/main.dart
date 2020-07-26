
import './password_items.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHAMBER OF SECRETS',
      home: MyHomePage()
    );
  }
}
class MyHomePage extends StatelessWidget {

  Widget createSlabs(String id, Function func)
  {
    return InkWell(onTap: func ,splashColor: Colors.blueGrey, borderRadius: BorderRadius.circular(65)
      , child: Container(child: Text(id, style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),)
        , padding: EdgeInsets.all(20), alignment: Alignment.center
        , decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.lightBlueAccent, Colors.lightGreenAccent]
            , begin: Alignment.topLeft, end: Alignment.bottomRight)
            , borderRadius: BorderRadius.circular(65)),),);
  }

  void enterPassword(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => PasswordItems())) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Contraseña", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 24)
          ,), backgroundColor: Colors.black, centerTitle: true,)
      , body: createSlabs("Chamber of Secrets", () => enterPassword(context))) ;
  }
}