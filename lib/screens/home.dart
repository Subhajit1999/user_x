import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:user_x/controllers/user_controller.dart';
import 'package:user_x/utils.dart';

import '../database/models.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> _removeUsers = [];
  bool _editMode = false, _youngest = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await userController.retrieveUsers().catchError(debugPrint);
    });
  }

  _sortUsers() {
    userController.usersList.sort((a, b) {
      return a.name.first.toLowerCase().compareTo(b.name.first.toLowerCase());
    });
  }

  _editUsers() {
    setState(() {
      _editMode = !_editMode;
    });
  }

  _onSelectUsers(User u) {
    if(_removeUsers.any((element) => element.name.first.toLowerCase() == u.name.first.toLowerCase())) {
      _removeUsers.removeWhere((element) => element.name.first.toLowerCase() == u.name.first.toLowerCase());
    }else {
      _removeUsers.add(u);
    }
    setState(() {});
  }

  _deleteUsers() {
    userController.deleteUsers(_removeUsers);
    setState(() {
      _removeUsers = [];
    });
  }

  _showYoungestUsers() {
    if(_youngest) {
      userController.usersList.sort((a, b) {
      return a.dob.age.compareTo(b.dob.age);
    });
    }else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          "User X",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              tooltip: "Edit Users",
              onPressed: _editUsers,
              icon: const Icon(Icons.edit_rounded)),
          IconButton(
              tooltip: 'Show Youngest Users',
              onPressed: () {
                _youngest = !_youngest;
                _showYoungestUsers();
              },
              icon: const Icon(Icons.person_rounded)),
          IconButton(
              tooltip: "Sort Alphabetically",
              onPressed: _sortUsers,
              icon: const Icon(Icons.sort_by_alpha_rounded)),
          if (_editMode)
            IconButton(
                tooltip: "Delete Selected Users",
                onPressed: _deleteUsers,
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.redAccent,
                )),
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: _youngest? 2 : userController.usersList.length,
            itemBuilder: (context, index) {
              String fullName =
                  "${userController.usersList[index].name.first} ${userController.usersList[index].name.last}";
              return Card(
                child: ListTile(
                  leading: _editMode
                      ? SizedBox(
                          width: 10,
                          child: Checkbox(
                              value: _removeUsers.any((element) =>
                                  element.name.first.toLowerCase() ==
                                  userController.usersList[index].name.first
                                      .toLowerCase()),
                              onChanged: (v) => _onSelectUsers(userController.usersList[index])),
                        )
                      : null,
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            userController.usersList[index].picture),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Age: ${userController.usersList[index].dob.age.toString()}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
