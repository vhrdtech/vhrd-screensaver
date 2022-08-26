import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  /// This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Text Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;
  int _tapCount = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      setState(() {
        _index = ++_index % _examples.length;
        _tapCount = 0;
      });
    });
    _examples = animatedTextExamples(onTap: () {
      print('Tap Event');
      setState(() {
        _tapCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final animatedTextExample = _examples[_index];

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     animatedTextExample.label,
      //     style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          SizedBox(
            // decoration: BoxDecoration(color: animatedTextExample.color),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              key: ValueKey(animatedTextExample.label),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: animatedTextExample.child
              ),
            ),
          ),
          // Expanded(
          //   child: Container(
          //     alignment: Alignment.center,
          //     child: Text('Taps: $_tapCount'),
          //   ),
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _index = ++_index % _examples.length;
      //       _tapCount = 0;
      //     });
      //   },
      //   tooltip: 'Next',
      //   child: const Icon(
      //     Icons.play_circle_filled,
      //     size: 50.0,
      //   ),
      // ),
    );
  }
}

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;

  const AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

// Colorize Text Style
const _colorizeTextStyle = TextStyle(
  fontSize: 70.0,
  fontFamily: 'Horizon',
);

// Colorize Colors
const _colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

List<AnimatedTextExample> animatedTextExamples({VoidCallback? onTap}) =>
    <AnimatedTextExample>[
      AnimatedTextExample(
        label: 'Rotate',
        color: Colors.orange[800],
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 20.0,
                  height: 100.0,
                ),
                const Text(
                  '>> ',
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Horizon'),
                ),
                const SizedBox(
                  width: 20.0,
                  height: 200.0,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 60.0,
                    fontFamily: 'Horizon',
                    color: Colors.red
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('vhrd.tech'),
                      RotateAnimatedText('veryhard.tech'),
                    ],
                    onTap: onTap,
                    isRepeatingAnimation: true,
                    totalRepeatCount: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      AnimatedTextExample(
        label: 'Fade',
        color: Colors.brown[600],
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontFamily: 'Horizon'
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText('vhrd.tech'),
              FadeAnimatedText('veryhard.tech'),
            ],
            onTap: onTap,
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Typewriter',
        color: Colors.red,
        child: SizedBox(
          width: 450.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 50.0,
              fontFamily: 'Horizon',
              color: Colors.red
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('vhrd.tech', cursor: '|'),
                TypewriterAnimatedText('veryhard.tech',
                    cursor: '#'),
              ],
              onTap: onTap,
            ),
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Scale',
        color: Colors.blue[700],
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 70.0,
            fontFamily: 'Horizon',
            color: Colors.red
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText('vhrd'),
              ScaleAnimatedText('.tech'),
            ],
            onTap: onTap,
          ),
        ),
      ),
      AnimatedTextExample(
        label: 'Colorize',
        color: Colors.red,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'vhrd.tech',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            ColorizeAnimatedText(
              'veryhard.tech',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
          ],
          onTap: onTap,
        ),
      ),
      AnimatedTextExample(
        label: 'TextLiquidFill',
        color: Colors.white,
        child: TextLiquidFill(
          text: 'vhrd.tech',
          waveColor: Colors.red,
          boxBackgroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
            fontFamily: 'Horizon',
          ),
          boxHeight: 300,
        ),
      ),
    ];

