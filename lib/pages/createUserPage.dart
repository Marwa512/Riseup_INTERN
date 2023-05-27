// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riseup_task/shared/cubit/cubit.dart';
import 'package:riseup_task/shared/cubit/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateUserPage extends StatelessWidget {
  CreateUserPage({super.key});
  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  var statusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          Fluttertoast.showToast(
              msg: "User Created Successfuly",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is CreateUserErrorState) {
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
            elevation: 0,
            backgroundColor: Colors.white10,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New User!",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: ((String? value) {
                        if (value!.isEmpty) {
                          return ("Name cant be empty");
                        }
                      }),
                      decoration: InputDecoration(
                        labelText: "User name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: ((String? value) {
                        if (value!.isEmpty) {
                          return ("Email cant be empty");
                        }
                      }),
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text("Gender"),
                    ListTile(
                      title: Text('Male'),
                      leading: Radio(
                        value: 1,
                        onChanged: (int? value) {
                          UserCubit.get(context).selectGender(value!);
                        },
                        groupValue: UserCubit.get(context).selectedValue,
                      ),
                    ),
                    ListTile(
                      title: Text('Female'),
                      leading: Radio(
                        value: 2,
                        onChanged: (int? value) {
                          UserCubit.get(context).selectGender(value!);
                        },
                        groupValue: UserCubit.get(context).selectedValue,
                      ),
                    ),
                    SizedBox(height: 40),
                    ConditionalBuilder(
                      condition: state is! CreateUserLoadingState,
                      builder: (context) => Container(
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
                            if (formkey.currentState!.validate()) {
                              if (UserCubit.get(context).selectedValue == 1) {
                                genderController.text = "Male";
                              } else {
                                genderController.text = "Female";
                              }
                              UserCubit.get(context).createUser(
                                  email: emailController.text,
                                  gender: genderController.text,
                                  name: nameController.text,
                                  status: "inactive");

                              print(genderController.text);
                            }
                          },
                          child: Text(
                            "Create User",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      fallback: (Context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
