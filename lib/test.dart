import 'package:cloud_storo/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'screens/login_screen.dart';

class FetchUserData extends StatefulWidget {
  @override
  _FetchUserDataState createState() => _FetchUserDataState();
}

class _FetchUserDataState extends State<FetchUserData> {
  String email = '';
  String photoURL = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Function to fetch user data
  void fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is signed in
      setState(() {
        email = user.email ?? '';
        photoURL = user.photoURL ?? '';
        name = user.displayName ?? '';
      });
    }
  }

  // Function to handle logout
  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.to(Login_Screen());
    } catch (e) {
      print('Error signing out: $e');
      // Show error message or handle error as per your application requirements
    }
  }

  // Function to handle account deletion
  void _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        Get.to(Login_Screen());
      }
    } catch (e) {
      print('Error deleting account: $e');
      // Show error message or handle error as per your application requirements
    }
  }

  // Function to show confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete your account?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: _deleteAccount,
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              photoURL.isNotEmpty
                  ? CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(photoURL),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                child: Text(
                  '$name',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      Padding(

                        padding: const EdgeInsets.only(top: 100),
                        child: Text(
                          'Email: $email',
                          style: textStyle(20, Colors.black, FontWeight.w700),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      ElevatedButton(
                        onPressed: _showConfirmationDialog,
                        child: Text("Delete Account",style: TextStyle(fontSize: 20),),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signOut,
                        child: Text("LOG OUT",style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
