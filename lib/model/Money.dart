class Money
{
  int id;
  String amount;
  String title;
  String monthlymoney;

  Money(this.amount, this.title,[this.monthlymoney]);
  Money.withId(this.id, this.amount, this.title,[this.monthlymoney]);



  Map<String,dynamic> toMap()
  {
    var map=Map<String,dynamic>();
    map['id']=id;
    map['amount']=amount;
    map['title']=title;
    map['monthlymoney']=monthlymoney;
    return map;
  }


  Money.fromMapObject(Map<String,dynamic> map)

  {
    this.id=map['id'];
    this.amount=map['amount'];
    this.title=map['title'];
    this.monthlymoney=map['monthlymoney'];

  }




}