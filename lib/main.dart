import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'dart:developer' as devtools show log;

/// Chapter 3 - InheritedModel - Flutter State Management Course 💙
///
void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var color1 = Colors.yellow;
  var color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: AvailableColorsWidget(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change color1'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      color2 = colors.getRandomElement();
                    });
                  },
                  child: const Text('Change color2'),
                ),
              ],
            ),
            const ColorWidget(
              color: AvailableColors.one,
            ),
            const SizedBox(
              height: 10,
            ),
            const ColorWidget(
              color: AvailableColors.two,
            ),
          ],
        ),
      ),
    );
  }
}

enum AvailableColors { one, two }

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;
  const AvailableColorsWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required Widget child,
  }) : super(key: key, child: child);

  static AvailableColorsWidget of(
    BuildContext context,
    AvailableColors aspect,
  ) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    devtools.log('updateShouldNotify');
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set<AvailableColors> dependencies,
  ) {
    devtools.log('updateShouldNotifyDependent');
    if (dependencies.contains(AvailableColors.one) &&
        color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.two) &&
        color2 != oldWidget.color2) {
      return true;
    }

    return false;
  }
}

final colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.indigo,
  Colors.cyan,
  Colors.amber,
  Colors.lime,
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        Random().nextInt(length),
      );
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;
  const ColorWidget({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.one:
        devtools.log('Color1 widget got rebuild');
        break;
      case AvailableColors.two:
        devtools.log('Color2 widget got rebuild');
        break;
    }
    final provider = AvailableColorsWidget.of(
      context,
      color,
    );
    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}
