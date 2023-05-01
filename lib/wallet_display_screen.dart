import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Wallet")),
    body: FractionallySizedBox(
    heightFactor: 0.9,
    child: Center(
    child: AnimatedBuilder(
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
      CardDisplay(firstName: "Ayush", lastName: "Nair", email: "Aniar@gmail.com", website: "ayush-projects.com",),
      SizedBox(width: 50, height: 20),
    ],
    ),
    ),
    ),
    ),
      bottomNavigationBar: Container(
        height: 30,
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
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            height: 30,
            width: 300,
            alignment: Alignment.center,
            child: Text(
              _isFlipped ? 'Hide Wallet' : 'Show Wallet',
              style: TextStyle(
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

