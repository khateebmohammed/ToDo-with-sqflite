import 'package:flutter/material.dart';

import '../../sqfLite/sqlDB.dart';
import '../EditNote.dart';

class CustomNote extends StatefulWidget {
  final String type;

  const CustomNote({Key? key, required this.type}) : super(key: key);

  @override
  State<CustomNote> createState() => _CustomNoteState();
}

class _CustomNoteState extends State<CustomNote> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb
        .readData("SELECT * FROM notes WHERE type = '${widget.type}'");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                //reverse: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color:
                              ([...Colors.primaries]..shuffle()).first.shade100,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push((MaterialPageRoute(
                                builder: (context) => EditNote(
                                  type: snapshot.data![i]["type"],
                                  title: snapshot.data![i]["note"],
                                  subtitle: snapshot.data![i]["des"],
                                  id: "${snapshot.data![i]["id"]}",
                                ),
                              )));
                            },
                            tileColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.all(8),
                            isThreeLine: true,
                            title: Text("${snapshot.data![i]["note"]}",
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle: Text("${snapshot.data![i]["des"]}",
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "${snapshot.data![i]['date'].split(" ").first}",
                                    style: const TextStyle(
                                        color: Colors.blueGrey)),
                              ),
                            ],
                          )
                        ],
                      ));
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return const CircularProgressIndicator();
        },
        initialData: const []);
  }
}
