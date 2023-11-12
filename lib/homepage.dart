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

  List<Widget> francois = [
    Center(
      child: Text("This view is empty"),
    )
  ];

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
                Text("Hello comrade! ",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w100)),
                SizedBox(height: 10),
                Text(
                    "C'est une application pour lister les personnes qui sont françaises ! si vous pensez que vous êtes français, ajoutez vous à la liste !."),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                        textAlign: TextAlign.left,
                        controller: _nameController,
                        decoration:
                            InputDecoration(hintText: "votre nom complet")),
                    TextField(
                        textAlign: TextAlign.left,
                        controller: _cityController,
                        decoration: InputDecoration(
                            hintText: "Nom de la ville d'où vous venez")),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              insertStuff();
                              fetchData();
                              setState(() {});
                              setState(() {});
                            },
                            child: Text("Registre")),
                        SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {
                              fetchData();
                              setState(() {});
                              setState(() {});
                            },
                            child: Text("Réactualiser"))
                      ],
                    )
                  ],
                ),
              ]),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 20),
              Text(
                "liste des camarades",
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
        title: Text('l\'application tricolore 🇫🇷'),
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
