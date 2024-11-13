import 'package:flutter/material.dart';

import '../sqfLite/sqlDB.dart';

class EditNote extends StatefulWidget {
  final String title, subtitle, id, type;

  const EditNote(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.id,
      required this.type})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  String? groupValue;

  @override
  void initState() {
    title.text = widget.title;
    subTitle.text = widget.subtitle;
    groupValue = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0,
        title: const Text("Edit Notes"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                int response = await sqlDb
                    .deleteData("DELETE FROM notes WHERE ID =${widget.id}");
                if (response != 0) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "NotePage", (route) => false);
                }
              },
              icon: const Icon(size: 22, color: Colors.black, Icons.delete)),
          IconButton(
            onPressed: () async {
              int response = await sqlDb.updateData(
                  "UPDATE notes SET note = '${title.text}',des = '${subTitle.text}',type = '$groupValue' WHERE id = ${widget.id}");

              if (response != 0) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Edited Successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.edit_note_outlined,
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
                    value: "very high",
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
                      hintText: "SubTitle",
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
