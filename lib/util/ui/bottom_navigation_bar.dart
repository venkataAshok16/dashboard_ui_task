import 'package:flutter/material.dart';

import '../../dashboard.dart';
import 'text.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () {
                changeTabIndexOnTabEvent(0);
              },
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Center(
            child: UTILText(
              "Home",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomAppBar(
      clipBehavior: Clip.antiAlias,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
      // color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: kBottomNavigationBarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.blue.shade200,
            width: 3,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomIcon(1, Icons.shop, "Market"),
            bottomIcon(2, Icons.repeat, "Exchange"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
            ),
            bottomIcon(3, Icons.balance, "Network"),
            bottomIcon(4, Icons.wallet, "Wallet"),
          ],
        ),
      ),
    );
  }

  Widget bottomIcon(int index, IconData icon, String text) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => changeTabIndexOnTabEvent(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black38),
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: Colors.blue,
                size: 20,
              ),
            ),
          ),
          UTILText(
            text,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget body() {
    if (_currentIndex == 1) {
      return Container(
        alignment: Alignment.center,
        child: const UTILText("Market"),
      );
    } else if (_currentIndex == 2) {
      return Container(
        alignment: Alignment.center,
        child: const UTILText("Exchange"),
      );
    } else if (_currentIndex == 3) {
      return Container(
        alignment: Alignment.center,
        child: const UTILText("Network"),
      );
    } else if (_currentIndex == 4) {
      return Container(
        alignment: Alignment.center,
        child: const UTILText("Wallet"),
      );
    } else {
      return DashboardScreen();
    }
  }

  void changeTabIndexOnTabEvent(int index) {
    _currentIndex = index;

    setState(() {});
  }
}
