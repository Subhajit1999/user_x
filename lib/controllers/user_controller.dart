import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_x/database/services.dart';
import 'package:user_x/main.dart';

import '../database/models.dart';

final UserController userController = Get.put(UserController());

class UserController extends GetxController {
  var usersList = [].obs;
  var editMode = false.obs;

  retrieveUsers() async {
    try{
      var data = await preferences.getString("USER_DATA");

      if(data != null) {
        List<User> users = List<User>.from(json.decode(data).map((e) => User.fromJson(e)).toList());
        usersList.value = users;
      }
    }catch(e) {
      debugPrint(e.toString());
    }
    fetchUsers();
  }

  Future fetchUsers() async {
    var result = await RemoteServices().fetchRandomUsers().catchError(print);

    if(result.isNotEmpty) {
      usersList.value = result;
      preferences.setString("USER_DATA", json.encode(List<dynamic>.from(result.map((e) => e.toJson()).toList())));
    }
  }

  void deleteUsers(List<User> users) {
    for(User u in users) {
      usersList.removeWhere((element) => element.name.first.toLowerCase() == u.name.first.toLowerCase());
    }
  }

  void setEditMode() {
    userController.editMode.value = !userController.editMode.value;
  }

  clearUsers() {
    usersList.value = [];
  }
}