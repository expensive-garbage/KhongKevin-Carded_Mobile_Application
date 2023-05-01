import 'package:flutter/material.dart';
import 'card_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card_display.dart';

class WalletDisplayScreen extends StatefulWidget {
  @override
  _WalletDisplayScreenState createState() => _WalletDisplayScreenState();
}

class _WalletDisplayScreenState extends State<WalletDisplayScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isFlipped = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  void _slideCardsBackDown() {
    _controller.reverse();
  }

  //https://stackoverflow.com/questions/68119285/the-body-might-complete-normally-causing-null-to-be-returned-but-the-return

  Future<List<CardDisplay>> _fetchCards(String userId) async {
    List<CardDisplay> cardList = [];

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      List<dynamic> walletArray = userSnapshot['wallet'];

      for (var cardId in walletArray) {
        DocumentSnapshot cardSnapshot = await FirebaseFirestore.instance.collection('cards').doc(cardId).get();
        Map<String, dynamic> bioPage = cardSnapshot['biopage'];
        Map<String, dynamic> contactPage = cardSnapshot['contact'];

        cardList.add(
          CardDisplay(
            firstName: contactPage['fname'],
            lastName: contactPage['Lname'],
            email: contactPage['email'],
            linkedin: contactPage['Linkedin'],
            website: contactPage['Website'],
            // Add more fields if necessary
          ),
        );
      }
    } catch (e) {
      print("Error fetching cards: $e");
      return [];
    }

    return cardList;
  }


  List<Widget> _buildCardList(List<CardDisplay> cards) {
    List<Widget> cardList = [];
    for (CardDisplay card in cards) {
      cardList.add(SizedBox(height: 20));
      cardList.add(card);
    }
    cardList.add(SizedBox(height: 20));
    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wallet")),
      body: FractionallySizedBox(
        heightFactor: 1.0,
        child: Center(
          child: FutureBuilder<List<CardDisplay>>(
            future: _fetchCards('mJVpc2oJuHu0wi73sOIo'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: ListView(
                    children: _buildCardList(snapshot.data!),
                  ),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        alignment: Alignment.bottomCenter,
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          onTap: () {
            if (_isFlipped) {
              _slideCardsBackDown();
            } else {
              _controller.forward();
            }
            _toggleFlip();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15),
              ),
            ), height: 60, width: 300,
            alignment: Alignment.center,
            child: Text(
              _isFlipped ? 'Hide Wallet' : 'Show Wallet',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}