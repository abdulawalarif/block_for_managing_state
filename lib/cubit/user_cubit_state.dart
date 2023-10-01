import 'package:block_for_managing_state/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserCubitState extends Equatable {
  const UserCubitState();
}

class UserCubitInit extends UserCubitState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserCubitLoading extends UserCubitState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserCubitDataLoaded extends UserCubitState {
  List<UserModel> userList;
  UserCubitDataLoaded({required this.userList});
  @override
  // TODO: implement props
  List<Object?> get props => [userList];
}

class UserCubitDataFetchingError extends UserCubitState {
  String errorMessage;
  UserCubitDataFetchingError({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
