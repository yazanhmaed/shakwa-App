import 'package:flutter/material.dart';

List<Widget> messege = [
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        'Welcome to Auto Reply App!',
        style: TextStyle(fontSize: 24),
      ),
      const SizedBox(height: 50),
      const Text(
        'Please choose one of the following options:',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          //sendMessege();
        },
        child: const Text('1'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          messege.add(const Text('data'));
          isSender.add(true);
          const Duration(seconds: 1);
           messege.add(const Text('Good'));
          isSender.add(false);
        },
        child: const Text('2'),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          print(messege.length);
        },
        child: const Text('3'),
      ),
    ],
  ),
  
  Column(
    children: const [Text('bubble normal '), Icon(Icons.title)],
  )
];
List<bool> isSender = [
  false,
  // true,
];
