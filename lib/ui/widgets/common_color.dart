import 'package:flutter/material.dart';


//Here we are creating a flutter widget fo the common color theme of the app.
class CommonColor extends StatelessWidget {
    CommonColor({Key? key,this.child}) : super(key: key);//widget is named child and is called inside constructor[this.child].

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 8, 0, 11),
              Color.fromARGB(255, 16, 3, 89),
              Color.fromARGB(255, 103, 24, 46)
            ])),
        child: child,
      ),
    );
  }
}

