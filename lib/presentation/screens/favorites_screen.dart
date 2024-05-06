import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CA using separeted folders 🧐',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                child: const Text('Show Pokemon Detail 🐡',
                    style: TextStyle(fontSize: 21)),
                onPressed: () => Navigator.of(context).pushNamed('/pokemon'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
