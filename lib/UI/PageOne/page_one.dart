import 'package:flutter/material.dart';
import 'package:flutter_firebase/DataMaps/data_maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  var db = FirebaseFirestore.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _age = TextEditingController();

  String userdata = " ";

  @override
  void initState() {
    super.initState();

    readUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _name,
                decoration: InputDecoration(hintText: "Enter your name"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _email,
                decoration: InputDecoration(hintText: "Enter your email"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _age,
                decoration: InputDecoration(hintText: "Enter your age"),
                keyboardType: TextInputType.number, // Suggest numeric keyboard
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addUserData();
                },
                child: Text("Submit"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  updateUserData();
                },
                child: Text("Update"),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  deleteUserData();
                },
                child: Text("Delete"),
              ),
              SizedBox(height: 20),
              Text(userdata),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> readUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDataSnapshot = await db
          .collection("currentUserData")
          .doc("123")
          .get();

      if (userDataSnapshot.exists) {
        String name = userDataSnapshot.data()?['name'] ?? 'N/A';
        String email = userDataSnapshot.data()?['email'] ?? 'N/A';
        int age = userDataSnapshot.data()?['age'] as int? ?? 0;

        setState(() {
          userdata = "Name = $name\nEmail = $email\nAge = $age";
        });
      } else {
        print("Document does not exist");
        setState(() {
          userdata = "User data not found.";
        });
      }
    } catch (e) {
      print("Exception occurred while reading data: $e");
      // Return an error message in case of an exception
      setState(() {
        userdata = "Error reading user data: ${e.toString()}";
      });
    }
  }

  Future<void> deleteUserData() async {
    try {
      await db.collection("currentUserData").doc("123").delete();
      print("Data deleted successfully");
    } catch (e) {
      print("Exception occurred ${e}");
    }
  }

  Future<void> updateUserData() async {
    String ageString = _age.text;
    int? age = int.tryParse(ageString);

    if (age != null) {
      var userData = DataMaps().setUserInfo(
        "123",
        _name.text,
        _email.text,
        age!,
      );

      try {
        await db.collection("currentUserData").doc("123").update(userData);
        print("Data added successfully");
      } catch (e) {
        print("Exception occur: ${e}");
      }
    }
  }

  Future<void> addUserData() async {
    String ageString = _age.text;
    int? age = int.tryParse(ageString);

    if (age != null) {
      var userData = DataMaps().setUserInfo(
        "123",
        _name.text,
        _email.text,
        age!,
      );

      try {
        await db.collection("currentUserData").doc("123").set(userData);
        print("Data updated successfully");
      } catch (e) {
        print("Exception occur: ${e}");
      }
    }
  }
}
