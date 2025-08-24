import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../DataMaps/data_maps.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {

  final DatabaseReference db = FirebaseDatabase.instance.ref();
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
                decoration: const InputDecoration(hintText: "Enter your name"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _email,
                decoration: const InputDecoration(hintText: "Enter your email"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _age,
                decoration: const InputDecoration(hintText: "Enter your age"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: addUserData,
                child: const Text("Submit"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUserData,
                child: const Text("Update"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: deleteUserData,
                child: const Text("Delete"),
              ),
              const SizedBox(height: 20),
              Text(userdata),
            ],
          ),
        ),
      ),
    );
  }

  /// Read data from Realtime Database
  Future<void> readUserData() async {
    try {
      DatabaseEvent event =
      await db.child("currentUserData").child("123").once();

      if (event.snapshot.exists) {
        Map data = event.snapshot.value as Map;
        String name = data['name'] ?? 'N/A';
        String email = data['email'] ?? 'N/A';
        int age = data['age'] ?? 0;

        setState(() {
          userdata = "Name = $name\nEmail = $email\nAge = $age";
        });
      } else {
        setState(() {
          userdata = "User data not found.";
        });
      }
    } catch (e) {
      setState(() {
        userdata = "Error reading user data: $e";
      });
    }
  }

  /// Delete data from Realtime Database
  Future<void> deleteUserData() async {
    try {
      await db.child("currentUserData").child("123").remove();
      print("Data deleted successfully");
    } catch (e) {
      print("Exception occurred: $e");
    }
  }

  /// Update data in Realtime Database
  Future<void> updateUserData() async {
    int? age = int.tryParse(_age.text);
    if (age != null) {
      var userData = DataMaps().setUserInfo(
        "123",
        _name.text,
        _email.text,
        age,
      );

      try {
        await db.child("currentUserData").child("123").update(userData);
        print("Data updated successfully");
      } catch (e) {
        print("Exception occurred: $e");
      }
    }
  }

  /// Add data to Realtime Database
  Future<void> addUserData() async {
    int? age = int.tryParse(_age.text);
    if (age != null) {
      var userData = DataMaps().setUserInfo(
        "123",
        _name.text,
        _email.text,
        age,
      );

      try {
        await db.child("currentUserData").child("123").set(userData);
        print("Data added successfully");
      } catch (e) {
        print("Exception occurred: $e");
      }
    }
  }
}
