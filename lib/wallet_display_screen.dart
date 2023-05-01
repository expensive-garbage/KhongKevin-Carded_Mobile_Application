import 'package:flutter/material.dart';
import 'card_display.dart';

class WalletDisplayScreen extends StatelessWidget {
  // required this.firstName,
  // required this.lastName,
  // required this.email,
  // this.linkedin,
  // this.website,

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text("Wallet")),
        body: FractionallySizedBox(
            heightFactor: 0.9,
            child: Center(
                child:ListView(

                  children: [
                    SizedBox(width: 50, height: 20),
                    CardDisplay(firstName: "Kevin", lastName: "Khong", email: "kevin79ers@gmail.com", linkedin: "linkedin.com/kevin-khong", website: "kevinkhong-portfolio.com",),
                    SizedBox(width: 50, height: 20),
                    CardDisplay(firstName: "Castel", lastName: "Vilallobos", email: "cvbos19@yahoo.com", linkedin: "linkedin.com/castel-vil",),
                    SizedBox(width: 50, height: 20),
                    CardDisplay(firstName: "Ayush", lastName: "Nair", email: "Aniar@gmail.com", website: "ayush-projects.com",),
                    SizedBox(width: 50, height: 20),
                    CardDisplay(firstName: "Kevin", lastName: "Khong", email: "kevin79ers@gmail.com", linkedin: "linkedin.com/kevin-khong", website: "kevinkhong-portfolio.com",),
                    SizedBox(width: 50, height: 20),
                    CardDisplay(firstName: "Castel", lastName: "Vilallobos", email: "cvbos19@yahoo.com", linkedin: "linkedin.com/castel-vil",),
                    SizedBox(width: 50, height: 20),
                    CardDisplay(firstName: "Ayush", lastName: "Nair", email: "Aniar@gmail.com", website: "ayush-projects.com",)]

                )
            )
        )

    );
  }

}
