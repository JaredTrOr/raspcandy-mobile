import 'package:http/http.dart';

class UserRequests{

  void register(String name, String username, String email, String password) async{
    try{
      Response response = await post(
        Uri.parse('http://localhost:3000/user/register'),
        body: {
          'name': name,
          'username': username,
          'email': email,
          'password': password
        }
      );

      print(response);
    }catch(e){
      print(e.toString());
    }
  }
}