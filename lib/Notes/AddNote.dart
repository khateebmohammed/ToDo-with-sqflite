import 'package:flutter/material.dart';
import '../sqfLite/sqlDB.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  String groupValue = "low";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Add Notes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              int response = await sqlDb.insertData('''
                INSERT INTO notes(note,des,date,type)VALUES("${title.text}","${subTitle.text}","${DateTime.now().toString()}","$groupValue")
                ''');
              if (response != 0) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Added Successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.verified_outlined,
                          color: Colors.white,
                        )
                      ],
                    )));

                Navigator.pushNamedAndRemoveUntil(
                    context, "NotePage", (route) => false);
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 7,
          ),
        ],
      ),
      body: ListView(children: [
        Row(
          children: [
            Expanded(
                child: RadioListTile(
                    title: const Text("Low"),
                    value: "low",
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
            Expanded(
                child: RadioListTile(
                    title: const Text("Med"),
                    value: "med",
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
            Expanded(
                child: RadioListTile(
                    title: const Text("High"),
                    value: "high",
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    })),
          ],
        ),
        Form(
          key: formState,
          child: Container(
            height: 2000,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
                border: Border(
                    right: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                        style: BorderStyle.solid),
                    left: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                        style: BorderStyle.solid),
                    top: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                        style: BorderStyle.solid),
                    bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                        style: BorderStyle.solid))),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: title,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      )),
                      hintText: "Title",
                      focusColor: Colors.green),
                ),
                const Divider(thickness: 1, indent: 8, endIndent: 8),
                TextFormField(
                  controller: subTitle,
                  minLines: 1,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        style: BorderStyle.none,
                        width: 0,
                      )),
                      hintText: "Description",
                      focusColor: Colors.green),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
