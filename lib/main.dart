import 'package:block_for_managing_state/cubit/counter_cubit.dart';
import 'package:block_for_managing_state/cubit/counter_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});
 final textStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => CounterCubit())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: Scaffold(
              body: BlocBuilder<CounterCubit, CounterCubitState>(
                builder: (contex, state){
                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: () {
                            contex.read<CounterCubit>().counterDecrement();
                          }, icon: Icon(Icons.remove)),
                          (state is CounterValueUpdated) ?Text(state.counter.toString(), style: textStyle,):Text("0", style: textStyle),
                          IconButton(onPressed: () {
                            contex.read<CounterCubit>().counterIncrement();
                          }, icon: Icon(Icons.add)),
                        ],
                      )
                    ],
                  );
                }
              )


          ),
        ));
  }
}
