import 'package:flutter/material.dart';

///2:21:25 / 11:29:38

void main() {
  runApp(
    const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home page',
        ),
      ),
      body: const Center(
        child: Text(
          'Hello world!',
        ),
      ),
    );
  }
}
