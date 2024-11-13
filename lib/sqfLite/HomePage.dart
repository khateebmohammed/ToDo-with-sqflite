import 'package:flutter/material.dart';
import 'package:sqf_lite/sqfLite/sqlDB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
                textColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  int response = await sqlDb.insertData('''
                  INSERT INTO notes(note,des)VALUES("HELLO4","Greeting")
                  ''');
                  print(response.toString());
                },
                color: Colors.green,
                child: const Text("Insert Data")),
            MaterialButton(
                textColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  List<Map<String, Object?>> response =
                      await sqlDb.readData('SELECT * FROM notes');
                  print(response);
                },
                color: Colors.blueAccent,
                child: const Text("Read Data")),
            MaterialButton(
                textColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  int response = await sqlDb.updateData('UPDATE notes SET note = "Welcome" WHERE id = 2');
                  print(response);
                },
                color: Colors.orange,
                child: const Text("Update Data")),
            MaterialButton(
                textColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  int response = await sqlDb.updateData('DELETE FROM notes WHERE ID =1');
                  print(response);
                },
                color: Colors.red,
                child: const Text("Delete Data")),
          ],
        ),
      )),
    );
  }
}
