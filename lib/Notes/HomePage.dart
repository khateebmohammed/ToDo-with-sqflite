import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqf_lite/Auth/Login.dart';
import 'package:sqf_lite/Notes/widgets/custom_note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../main.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, "AddNote");
            },
            shape: CircleBorder(
                side: BorderSide(color: Colors.green.shade900, width: 2)),
            foregroundColor: Colors.green.shade900,
            child: const Icon(
              Icons.add,
            )),
        drawer: Drawer(
          child: SafeArea(
              minimum: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: const Icon(
                        Icons.account_circle_outlined,
                        size: 60,
                        color: Colors.white70),
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                    ),
                    accountName: Text(sharedPref.getString("email").toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    accountEmail: Text(sharedPref.getString("name").toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: ListTile(
                      trailing: const Icon(Icons.logout, color: Colors.red),
                      onTap: () async {
                        sharedPref.clear();
                        Get.offAll(() => const Login());
                      },
                      title: const Text("Log Out"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      trailing: const Icon(Icons.delete_forever_outlined,
                          color: Colors.red),
                      onTap: () async {
                        String dataBasePath = await getDatabasesPath();
                        String path = join(dataBasePath, 'Mohammed_Ali.db');
                        await deleteDatabase(path);
                      },
                      title: const Text("Delete The DataBase"),
                    ),
                  )
                ],
              )),
        ),
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text("Notes",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'High'),
                Tab(text: 'Med'),
                Tab(text: 'Low'),
              ],
            )),
        body: const TabBarView(
          children: [
            CustomNote(type: 'high'),
            CustomNote(type: 'med'),
            CustomNote(type: 'low'),
          ],
        ),
      ),
    );
  }
}
