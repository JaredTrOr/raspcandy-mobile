class UserData{
  
  late String id = '';
  late String name = '';
  late String username = '';
  late String password = '';
  late String email = '';

  //Empty Constructor
  UserData();

  void setData(String id, String name, String username, String password, String email){
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
    this.email = email;
  }

  String getId(){return id;}
  String getName(){return name;}
  String getUsername(){return username;}
  String getPassword(){return password;}
  String getEmail(){return email;}

}

final userData = UserData();

//Create service flutter and global variables
