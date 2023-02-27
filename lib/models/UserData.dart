class UserData{
  
  String id = '';
  String name = '';
  String username = '';
  String password = '';
  String email = '';
  String purchases= '';
  String amountOfPurchases = '';
  String favoriteCandy = '';

  //Empty Constructor
  UserData();

  void setData(String id, String name, String username, String password, String email){
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
  }

  set setPurchases (String purchases) {this.purchases = purchases;}
  set setFavoriteCandy (String favoriteCandy) {this.favoriteCandy = purchases;}
  set setAmountOfPurchases (String amountOfPurchases) {this.amountOfPurchases = amountOfPurchases;}

  String getId(){return id;}
  String getName(){return name;}
  String getUsername(){return username;}
  String getPassword(){return password;}
  String getEmail(){return email;}

}

final userData = UserData();

//Create service flutter and global variables
