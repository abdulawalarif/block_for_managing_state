import 'package:block_for_managing_state/cubit/user_cubit_state.dart';
import 'package:block_for_managing_state/model/user_model.dart';
import 'package:block_for_managing_state/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserCubitState>{
  List<UserModel> userList=[];
  ApiService apiService;
  UserCubit({required this.apiService}):super(UserCubitInit());

  void getAllUserList() async{
    try{
      emit(UserCubitLoading());
      userList = await apiService.getData();
      emit(UserCubitDataLoaded(userList: userList));
    }catch(e){
      emit(UserCubitDataFetchingError(errorMessage: e.toString()));
    }
  }

}