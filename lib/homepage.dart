import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:french/component/item.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();

  List<Widget> francois = [];

  @override
  void initState() {
    super.initState();

    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text("Hello comerades! ",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w100)),
                const SizedBox(height: 10),
                const Text(
                    "It's an application for listing people who are French! If you think you're French, add yourself to the list!"),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                        textAlign: TextAlign.left,
                        controller: _nameController,
                        decoration:
                            const InputDecoration(hintText: "Your Full Name")),
                    TextField(
                        textAlign: TextAlign.left,
                        controller: _cityController,
                        decoration: const InputDecoration(
                            hintText: "Your Home Town Name")),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              insertStuff();
                              fetchData();
                              setState(() {});
                              setState(() {});
                            },
                            child: Text("Register")),
                        SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {
                              fetchData();
                              setState(() {});
                              setState(() {});
                            },
                            child: Text("Refresh"))
                      ],
                    )
                  ],
                ),
              ]),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                "List of fellow frenchman",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: francois),
            ],
          ),
        ),
      )),
      appBar: AppBar(
        title: Text('The tricolor 🇫🇷 App'),
      ),
    );
  }

  void insertStuff() {
    if (_nameController.value != "" || _cityController != "") {
      var db = FirebaseFirestore.instance;
      db.collection("people").add({
        "name": _nameController.text,
        "city": _cityController.text
      }).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
    }
  }

  void fetchData() {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    var db = FirebaseFirestore.instance;
    var ppl = db.collection("people");

    setState(() {
      ppl.get().then((QuerySnapshot qs) {
        qs.docs.forEach((doc) {
          Widget plchld = ItemCard(doc["name"], doc["city"], doc.id);
          if (!francois.contains(plchld)) {
            francois.add(plchld);
          }
        });
      });
    });
  }
}
