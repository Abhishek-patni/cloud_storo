import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storo/controllers/navigation_controller.dart';
import 'package:cloud_storo/controllers/user_contoller.dart';
import 'package:cloud_storo/test.dart';
import 'package:cloud_storo/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  NavigationController navController = Get.put(NavigationController());
  UserDataController userDataController = Get.put(UserDataController());
  Widget tabCell(String text, BuildContext context, bool selected) {
    return selected
        ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45 - 5,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selected ? Colors.deepOrangeAccent : Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(10, 10),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(-10, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                  child: Text(
                text,
                style: textStyle(23, Colors.white, FontWeight.bold),
              )),
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.45 - 10,
            height: 60,
            child: Center(
                child: Text(
              text,
              style: textStyle(23, textcolor, FontWeight.bold),
            )),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "STORO",
                  style: textStyle(28, textcolor, FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FetchUserData()));
                    print("Tapped on user photo.");
                  },
                  child: Obx(
                    () {
                      if (userDataController.photoURL.value.isNotEmpty) {
                        print("Photo URL: ${userDataController.photoURL.value}");
                        return CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              NetworkImage(userDataController.photoURL.value),
                        );
                      } else {
                        print("Photo URL is empty.");
                        return Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [

                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: Offset(10, 10),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: Offset(-10, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Obx(
              () => Row(
                children: [
                  InkWell(
                      onTap: () => navController.changeTab("Storage"),
                      child: tabCell("Storage", context,
                          navController.tab.value == "Storage")),
                  InkWell(
                      onTap: () => navController.changeTab("Files"),
                      child: tabCell(
                          "File", context, navController.tab.value == "Files"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
