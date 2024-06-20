import 'package:flutter/material.dart';

class Reglage extends StatelessWidget {
  const Reglage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff496a81),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Réglage'),
        backgroundColor: Color(0xff2b3a67),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Changer le mot de passe",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
