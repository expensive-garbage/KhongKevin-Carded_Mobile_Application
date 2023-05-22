/*refactor into mvvm*/

class UserModel {
  late String refId;
  late String email;
  late String card;
  List<String> wallet = [];

  UserModel(String r, String e, String c, List<dynamic> w){
    refId = r;
    email = e;
    card = c;
    wallet = List<String>.from(w);
  }

  @override
  String toString(){
    return("${refId}, ${email}, ${card}, ${wallet}");
  }
}