import 'package:block_for_managing_state/cubit/user_cubit.dart';
import 'package:block_for_managing_state/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserCubit(apiService: ApiService()))
        ], 
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, );
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getAllUserList();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text("Hello world",style: textStyle,),),
    );
  }
}
