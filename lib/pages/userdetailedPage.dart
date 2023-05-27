// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riseup_task/shared/cubit/cubit.dart';
import 'package:riseup_task/shared/cubit/states.dart';

class UserDetail extends StatelessWidget {
  UserDetail(
      {required this.id,
      required this.gender,
      required this.email,
      required this.name,
      required this.status});
  int id;
  String name;
  String gender;
  String email;
  String status;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  var statusController = TextEditingController();
  var idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = email;
    nameController.text = name;
    genderController.text = gender;
    statusController.text = status;
    idController.text = id.toString();
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccessState) {
          Fluttertoast.showToast(
              msg: "User Updated Successfuly",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is UpdateUserErrorState) {
          Fluttertoast.showToast(
              msg: UserCubit.get(context).msgError,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white10,
            elevation: 0,
            title: const Text(
              "User details and Update",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                TextFormField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  enabled: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  enabled: false,
                  controller: statusController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.verified),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text('Male'),
                  leading: Radio(
                    value: 1,
                    onChanged: (int? value) {
                      UserCubit.get(context).selectGender(value!);
                    },
                    groupValue: UserCubit.get(context).selectedValue,
                  ),
                ),
                ListTile(
                  title: const Text('Female'),
                  leading: Radio(
                    value: 2,
                    onChanged: (int? value) {
                      UserCubit.get(context).selectGender(value!);
                    },
                    groupValue: UserCubit.get(context).selectedValue,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ConditionalBuilder(
                  condition: state is! UpdateUserLoadingState,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (UserCubit.get(context).selectedValue == 1) {
                            genderController.text = "male";
                          } else {
                            genderController.text = "female";
                          }
                          UserCubit.get(context).updateUser(
                              id: idController.text,
                              email: emailController.text,
                              gender: genderController.text,
                              name: nameController.text,
                              status: statusController.text);
                        },
                        child: const Text(
                          "Update ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
