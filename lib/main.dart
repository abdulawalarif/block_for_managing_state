import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

/// Chapter 4 - InheritedNotifier and ChangeNotifier - Flutter State Management Course 💙
///
void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required SliderData sliderData,
    required Widget child,
  }) : super(
          key: key,
          notifier: sliderData,
          child: child,
        );

  static double of(BuildContext context) =>
      context
            .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
            ?.notifier
            ?.value ??
        0.0;

}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: SliderInheritedNotifier(
          sliderData: sliderData,
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  Slider(
                    value: SliderInheritedNotifier.of(context),
                    onChanged: (value) {
                      sliderData.value = value;
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Opacity(
                        opacity: SliderInheritedNotifier.of(context),
                        child: Container(
                          height: 200,
                          color: Colors.yellow,
                        ),
                      ),
                      Opacity(
                        opacity: SliderInheritedNotifier.of(context),
                        child: Container(
                          height: 200,
                          color: Colors.blue,
                        ),
                      ),
                    ].expandEqually().toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map(
        (w) => Expanded(
          child: w,
        ),
      );
}
