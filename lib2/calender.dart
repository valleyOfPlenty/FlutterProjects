/*

def heapDeletion(A) :
    c = A[1]
    A[1] = A[len(A) - 1]
    A[len(A) - 1] = c
    A.pop()
    min = 1
    while (A[min] <= A[min*2] or A[min] <= A[min*2 + 1]) :
        if min*2 < len(A) :
            if A[min*2] > A[min*2 + 1] :
                c = A[min]
                A[min] = A[min*2]
                A[min*2] = c
                min = min*2
            else :
                c = A[min]
                A[min] = A[min*2 + 1]
                A[min*2 + 1] = c
                min = min*2 + 1
        else :
            break
    return A

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class KushCalendar extends StatefulWidget
{
  @override
  _KushCalendarState createState() => _KushCalendarState();
}

class _KushCalendarState extends State<KushCalendar> {
  Map<DateTime, List> eventsMap = {} ;
  void addNewElement(String achievement, DateTime date)
  {
    int flag = 0 ;
    eventsMap.forEach((key, value) {
      if (date == key)
        {
          flag =  1 ;
          setState(() {
            eventsMap[date].add(achievement) ;
          });
        }
    }) ;
    if (flag == 0)
      {
        setState(() {
          eventsMap[date] = [] ;
          eventsMap[date].add(achievement) ;
        });
      }
    print(date) ;
    print(achievement) ;
  }

  CalendarController cc = CalendarController() ;

  void startNewAchievement(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(child: NewAchievement(addNewElement), onTap: () {}, behavior: HitTestBehavior.opaque);
    }) ;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TableCalendar(calendarController: cc, events: eventsMap
            , calendarStyle: CalendarStyle(outsideDaysVisible: false, selectedColor: Colors.purple, todayColor: Colors.purple[300]
              , weekendStyle: TextStyle().copyWith(color: Colors.amber),)
            , daysOfWeekStyle: DaysOfWeekStyle(weekendStyle: TextStyle().copyWith(color: Colors.amber)),),
        ],
      ),
    )
      , floatingActionButton: FloatingActionButton(backgroundColor: Colors.purple, child: Icon(Icons.add), onPressed: () {startNewAchievement(context) ;}, )
        , floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,) ;
  }
}

class NewAchievement extends StatefulWidget
{
  final Function addTrx ;
  NewAchievement(this.addTrx) ;
  @override
  _NewAchievementState createState() => _NewAchievementState();
}

class _NewAchievementState extends State<NewAchievement>
{
  final eventTitle = TextEditingController() ;

  void submitData()
  {
    if (eventTitle.text.isEmpty || selectDate == null)
    {
      eventTitle.clear() ;
      return ;
    }
    else
    {
      widget.addTrx(eventTitle.text, selectDate) ;
      eventTitle.clear() ;
    }
  }

  DateTime selectDate ;
  void presentDatePicker()
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019, DateTime.now().month)
        , lastDate: DateTime.now()).then((pickedDate){
      if (pickedDate == null)
      {
        return ;
      }
      setState(() {
        selectDate = pickedDate ;
      });
      print(selectDate) ;
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Card(child: SingleChildScrollView(child: Column(children: <Widget>[TextField(decoration: InputDecoration(labelText: "EVENT: ")
      , controller: eventTitle,)
      , Container(padding: EdgeInsets.all(10), height: 40
          , child: Row(children: [Text(selectDate == null ? "No Date Chosen" : DateFormat.yMMMd().format(selectDate))
            , FlatButton(child: Text("Choose Date", style: TextStyle(color: Colors.purple),)
              , onPressed: presentDatePicker,)], mainAxisAlignment: MainAxisAlignment.spaceBetween,))
      , RaisedButton(child: Text("ADD",style: TextStyle(color: Colors.white),), color: Colors.purple
          , onPressed: () {submitData() ;}
          , textColor: Colors.purpleAccent)],),),));
  }
}

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Example holidays




class KushCalendar extends StatefulWidget {
  KushCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KushCalendarState createState() => _KushCalendarState();
}

class _KushCalendarState extends State<KushCalendar> with TickerProviderStateMixin {
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();



    _selectedEvents = eventsMap[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }
  Map<DateTime, List> eventsMap = {} ;
  Future<void> addNewElement(String achievement, DateTime date)
  {
    int flag = 0 ;
    eventsMap.forEach((key, value) {
      if (date == key)
      {
        flag =  1 ;
        setState(() {
          eventsMap[date].add(achievement) ;
        });
      }
    }) ;
    if (flag == 0)
    {
      setState(() {
        eventsMap[date] = [] ;
        eventsMap[date].add(achievement) ;
      });
    }
    const url = "https://expense-tracker-b42ce.firebaseio.com/events.json" ;
    return http.post(url, body: json.encode({
      "Date" : date.toString(),
      "Achievement" : achievement
    })) ;

  }

  var isInit = true ;
  Future<void> didChangeDependencies() async
  {
    const url = "https://expense-tracker-b42ce.firebaseio.com/events.json" ;
    if (isInit)
      {
        final response = await http.get(url) ;
        Map<String, dynamic> extractedData = json.decode(response.body) ;
        Map<DateTime, List> loadEvents = {} ;
        extractedData.forEach((eveId, eveData){
          int flag = 0 ;
          loadEvents.forEach((key, value) {
            if (key == DateTime.parse(eveData['Date']))
              {
                flag = 1 ;
                loadEvents[DateTime.parse(eveData['Date'])].add(eveData["Achievement"]) ;
              }
          }) ;
          if (flag == 0)
            {
              loadEvents[DateTime.parse(eveData['Date'])] = [] ;
              loadEvents[DateTime.parse(eveData['Date'])].add(eveData["Achievement"]) ;
            }
        }) ;
        setState(() {
          eventsMap = loadEvents ;
        });
      }
    isInit = false ;
    super.didChangeDependencies() ;
  }
  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  void startNewAchievement(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(child: NewAchievement(addNewElement), onTap: () {}, behavior: HitTestBehavior.opaque);
    }) ;
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.purple), height: 50, width: 50
              , child: IconButton(icon: Icon(Icons.add), onPressed: () {startNewAchievement(context) ;}, color: Colors.white,)),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: eventsMap,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.purple,
        todayColor: Colors.purple[200],
        markersColor: Colors.amber,
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.amber),)
      , daysOfWeekStyle: DaysOfWeekStyle(weekendStyle: TextStyle().copyWith(color: Colors.amber)),

      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

}
class NewAchievement extends StatefulWidget
{
  final Function addTrx ;
  NewAchievement(this.addTrx) ;
  @override
  _NewAchievementState createState() => _NewAchievementState();
}

class _NewAchievementState extends State<NewAchievement>
{
  final eventTitle = TextEditingController() ;

  void submitData()
  {
    if (eventTitle.text.isEmpty || selectDate == null)
    {
      eventTitle.clear() ;
      return ;
    }
    else
    {
      widget.addTrx(eventTitle.text, selectDate) ;
      eventTitle.clear() ;
    }
  }

  DateTime selectDate ;
  void presentDatePicker()
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019, DateTime.now().month)
        , lastDate: DateTime.now()).then((pickedDate){
      if (pickedDate == null)
      {
        return ;
      }
      setState(() {
        selectDate = pickedDate ;
      });
      print(selectDate) ;
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Card(child: SingleChildScrollView(child: Column(children: <Widget>[TextField(decoration: InputDecoration(labelText: "EVENT: ")
      , controller: eventTitle,)
      , Container(padding: EdgeInsets.all(10), height: 40
          , child: Row(children: [Text(selectDate == null ? "No Date Chosen" : DateFormat.yMMMd().format(selectDate))
            , FlatButton(child: Text("Choose Date", style: TextStyle(color: Colors.purple),)
              , onPressed: presentDatePicker,)], mainAxisAlignment: MainAxisAlignment.spaceBetween,))
      , RaisedButton(child: Text("ADD",style: TextStyle(color: Colors.white),), color: Colors.purple
          , onPressed: () {submitData() ;}
          , textColor: Colors.purpleAccent)],),),));
  }
}

