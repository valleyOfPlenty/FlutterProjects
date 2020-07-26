
import './dummy_password.dart';

import './password_modal.dart';
import 'package:flutter/material.dart';

class PasswordItems extends StatefulWidget
{
  @override
  _PasswordItemsState createState() => _PasswordItemsState();
}

class _PasswordItemsState extends State<PasswordItems> {

  void startNewAddElement(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (bctx) {
      return GestureDetector(child: PasswordsModalBottomSheet(addNewElement) , onTap: () {}, behavior: HitTestBehavior.opaque);
    }) ;
  }


  List<DummyPassword> lipid = [] ;

  void addNewElement(String iD, String password)
  {
    DummyPassword sp = new DummyPassword(id: iD, pass: password) ;
    setState(() {
      lipid.add(sp) ;
    });
  }

  void deleteElement(String iD)
  {
    setState(() {
      lipid.removeWhere((passId) => passId.id == iD ) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("Chamber of Secrets"
      , style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 24)
      ,), backgroundColor: Colors.black, centerTitle: true,)
      , floatingActionButton: FloatingActionButton(child: Icon(Icons.add)
        , onPressed: () {startNewAddElement(context) ;}
        , backgroundColor: Colors.lightGreenAccent, foregroundColor: Colors.lightBlueAccent,)
      , floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      , body: Container(height: MediaQuery.of(context).size.height*0.8,
        child: lipid.isEmpty ? Image.network('https://images.theconversation.com/files/186076/original/file-20170914-8971-1bvg0di.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip'
          , height: 550, width: 450,)
        : ListView.builder(itemBuilder: (context, index)
    {
    return Card(child: Column(children: [Container(child: Row(children: [Icon(Icons.bookmark), Container(child: Text(lipid[index].id
    , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),)
    , decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.lightGreenAccent,),),padding: EdgeInsets.all(15)
    , margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),),],),padding: EdgeInsets.symmetric(horizontal: 12),)
      , Container(child: IconButton(icon: Icon(Icons.delete), onPressed: () => deleteElement(lipid[index].id), color: Colors.red,)
        , alignment: Alignment.topLeft,)
      , Container(child: Row(children: [Icon(Icons.security), Container(child: Text(lipid[index].pass
        , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.lightBlueAccent, fontStyle: FontStyle.italic),)
        , decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.lightGreenAccent),),padding: EdgeInsets.all(15)
        , margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),),],),padding: EdgeInsets.symmetric(horizontal: 12),),],),);}
        , itemCount: lipid.length),),);}

}