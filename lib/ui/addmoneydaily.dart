import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneysaving/model/Money.dart';
import 'package:moneysaving/utils/databasehelper.dart';

class AddDailyMoney extends StatefulWidget {
  @override
  _AddDailyMoneyState createState() => _AddDailyMoneyState();
}

class _AddDailyMoneyState extends State<AddDailyMoney> {
  TextEditingController moneycontroller=new TextEditingController();
  TextEditingController titlecontroller=new TextEditingController();
  DatabaseHelper helper=DatabaseHelper();

  Money money=Money('','','');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ADD TODAY EXPENDITURE"),),
      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    debugPrint("moneycontroller working");
                    updateAmount();
                  },
                  autofocus: true,
                  controller: moneycontroller,
                  decoration: InputDecoration(
                    labelText: "Enter money",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                ),
              ),
            ),


            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  autofocus: true,
                  controller: titlecontroller,
                  onChanged: (value) {
                    debugPrint("title is working");
                    updatetitle();
                  },
                  decoration: InputDecoration(

                      labelText: "Enter Description for money",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: RaisedButton(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: (){

                        setState(() {
                          _save();
                        });
                        debugPrint("save called");

                  },child: Text("save"))),
                  SizedBox(width: 5,),
                  Expanded(child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                      ,onPressed: (){

                  },child: Text("delete"))),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  updateAmount()
  {
    money.amount=moneycontroller.text;
  }

  updatetitle()
  {
    money.title=titlecontroller.text;
  }

  void _save() async
  {
    Navigator.pop(context,true) ;
    int result=await helper.insertNote(money);
    print(result);

  }
}
