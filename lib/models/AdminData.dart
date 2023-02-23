class AdminData {

  late String id;
  late String name;
  late String username;
  late String password;
  late String email;
  //Admin Address
  late String street;
  late String number;
  late String place;

  //Empty Constructor
  AdminData();

  void setData(
    String id, String name, String username, String password, String email,
    String street, String number, String place
  ){
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
    this.street = street;
    this.number = number;
    this.place = place;
  }

  String getId(){return id;}
  String getName(){return name;}
  String getUsername(){return username;}
  String getPassword(){return password;}
  String getEmail(){return email;}
}

final adminData = AdminData();