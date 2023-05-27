// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riseup_task/pages/createUserPage.dart';
import 'package:riseup_task/pages/userdetailedPage.dart';
import 'package:riseup_task/shared/component/reusableComponent.dart';
import 'package:riseup_task/shared/cubit/cubit.dart';
import 'package:riseup_task/shared/cubit/states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white12,
            title: const Text(
              "Home Page",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View All Users",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                        condition: cubit.userModel.length > 0,
                        builder: (context) =>
                            UserList(cubit.userModel, cubit.userModel.length),
                        fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            )),
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, CreateUserPage());
            },
            child: Icon(
              FontAwesomeIcons.plus,
              size: 30,
            ),
          ),
        );
      },
    );
  }

  Widget Item(user, context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(50)),
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        user['gender'] == 'female'
                            ? 'assets/img/girl.jpg'
                            : 'assets/img/boy.jpg',
                      ),
                    ))),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 160,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${user['name']}",
                    style: TextStyle(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${user['email']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            IconButton(
                onPressed: () {
                  UserCubit.get(context).deleteUser(id: user['id']);
                  UserCubit.get(context).getUserData();
                },
                icon: Icon(
                  Icons.delete,
                  size: 20,
                )),
            IconButton(
                onPressed: () {
                  navigateTo(
                      context,
                      UserDetail(
                        id: user['id'],
                        email: user['email'],
                        gender: user['gender'],
                        name: user['name'],
                        status: user['status'],
                      ));
                },
                icon: Icon(
                  FontAwesomeIcons.arrowRight,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }

  Widget UserList(user, int length) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemBuilder: (context, index) => Item(user[index], context),
        separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 20,
            ),
        itemCount: length);
  }
}
