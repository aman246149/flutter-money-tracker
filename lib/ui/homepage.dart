
import 'package:flutter/material.dart';
import 'package:moneysaving/model/Money.dart';
import 'package:moneysaving/ui/addmoneydaily.dart';
import 'package:moneysaving/utils/databasehelper.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Money> moneylist;
  int count=0;
  TextEditingController moneycontroller=TextEditingController();
  Money money=Money('','','');


  DatabaseHelper helper=DatabaseHelper();
  TextStyle ts=TextStyle(fontSize: 30,fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {

    if(moneylist==null)
      {
        moneylist=List<Money>();
        updateListView();
      }

    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text("MONEY TRACKER"),
      ),
      body: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async{
           bool result= await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDailyMoney()));
           if(result==true)
             {
               updateListView();
             }
        },
        child: Icon(
          Icons.add
        ),),
        body: Column(
        children: <Widget>[
          Container(height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("WELCOME YOU",style: ts,),
//              Text("500 rs",style: ts,)
            ],
          ),
          ),
      Expanded(
        child: Container(
          
          child:    ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(this.moneylist[index].amount),
                title: Text(this.moneylist[index].title),
                trailing: IconButton(icon: Icon(Icons.delete),onPressed: () {
                  setState(()  {
                    helper.deleteNote(this.moneylist[index].id);
                    updateListView();

                  });
                },)
              );
            },),
        ),
      )

        ],
          ),
      ),
    );
  }

  void updateListView() {

    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Money>> noteListFuture = helper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.moneylist = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void _onButtonPressed()
  {
    showModalBottomSheet(context: context, builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top:20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: moneycontroller,
                decoration: InputDecoration(
                  labelText: "add monthly money",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),

                ),
                onChanged: (value) {
                  updateMoney();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      onPressed: (){
                            helper.insertNote(money);
                            updateListView();
                      },
                      child: Text("save money"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },);
  }

  updateMoney()
  {
    money.monthlymoney=moneycontroller.text;
  }

}
