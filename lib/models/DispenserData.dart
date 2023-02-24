class Dispenser {
  late String id;
  late String position;
  late String candyName;
  late double amount;

  Dispenser();

  void setData(String id, String position, String candyName, double amount){
    this.id = id;
    this.position = position;
    this.candyName = candyName;
    this.amount = amount;
  }

  String getId() {return id;}
  String getPositon() {return position;}
  String getCandyName() {return candyName;}
  double getAmount() {return amount;}
}