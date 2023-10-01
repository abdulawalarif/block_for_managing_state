import 'package:block_for_managing_state/cubit/user_cubit.dart';
import 'package:block_for_managing_state/cubit/user_cubit_state.dart';
import 'package:block_for_managing_state/model/user_model.dart';
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
      appBar: AppBar(
        title: Text("Cubit API Calling"),
      ),
      body: BlocBuilder<UserCubit, UserCubitState>(
        builder: (context, state){
          if(state is UserCubitLoading){
            return Center(child: CircularProgressIndicator(),);
          } else if(state is UserCubitDataFetchingError){
            return Center(child: Text(state.errorMessage.toString()),);
          } else if(state is UserCubitDataLoaded){
            return ListView.builder(
                itemCount: state.userList.length,
                itemBuilder: (context, index){
                  UserModel userModel = state.userList[index];
              return ListTile(
                leading: Text(userModel.id.toString()),
                title: Text(userModel.name.toString()),
              );
            });
          }else{
            return Text("Unknown error occured");
          }
        },
      )
    );
  }
}
