// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riseup_task/shared/cubit/states.dart';
import 'package:riseup_task/shared/network/remote/dio_helper.dart';

import '../../models/UserModel.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());
  static UserCubit get(context) => BlocProvider.of(context);
  List<dynamic> userModel = [];
  late String msgError;
  void getUserData() {
    userModel = [];
    DioHelper.getData(url: 'users').then((value) {
      userModel = value.data;

      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      msgError = error.toString();
      emit(GetUserErrorState());
    });
  }

  void deleteUser({required int id}) {
    DioHelper.deleteData(url: 'users/$id').then((value) {
      print(value.statusCode);
      emit(DeleteUserSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(DeleteUserErrorState());
    });
  }

  void getSelectedUser({required String id}) {
    DioHelper.getData(url: 'users/$id').then((value) {
      print(value.statusCode);
      print(value.data.toString());
      emit(GetSelectedUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      msgError = error.toString();

      emit(GetSelectedUserErrorState());
    });
  }

  void createUser(
      {required String email,
      required String gender,
      required String name,
      required String status}) {
    emit(CreateUserLoadingState());
    DioHelper.postData(url: 'users', data: {
      "name": name,
      "email": email,
      "gender": gender,
      "status": status,
    }).then((value) {
      print(value.statusCode);
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      msgError = error.toString();

      emit(CreateUserErrorState(error.toString()));
    });
  }

  void updateUser(
      {required String id,
      required String email,
      required String gender,
      required String name,
      required String status}) {
    emit(UpdateUserLoadingState());

    DioHelper.putData(url: 'users/$id', data: {
      "name": name,
      "email": email,
      "gender": gender,
      "status": status,
    }).then((value) {
      print(value.statusCode);
      emit(UpdateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      msgError = error.toString();

      emit(UpdateUserErrorState());
    });
  }

  int selectedValue = 1;

  void selectGender(int value) {
    selectedValue = value;
    emit(SelectUserGenderState());
  }
}
