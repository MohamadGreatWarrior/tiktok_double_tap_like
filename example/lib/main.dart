import 'package:flutter/material.dart';
import 'package:tiktok_double_tap_like/tiktok_double_tap_like.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Double Tap Like',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DoubleTapLikeWidget(
      onLike: () {
        //Do something when the user double taps
      },
      likeWidget: const Image(image: AssetImage('assets/icons/heart.png')),
      likeWidth: 200,
      likeHeight: 200,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TikTok Double Tap Like'),
        ),
      ),
    );
  }
}
