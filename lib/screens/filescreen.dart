import 'package:cloud_storo/controllers/files_screen_controller.dart';
import 'package:cloud_storo/firebase.dart';
import 'package:cloud_storo/screens/nav_screen.dart';
import 'package:cloud_storo/utils.dart';
import 'package:cloud_storo/widgets/folder_sections.dart';
import 'package:cloud_storo/widgets/recent_files.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileScreen extends StatelessWidget {
  TextEditingController folderController = TextEditingController();
  FilesScreenContoller filesScreenContoller = Get.put(FilesScreenContoller());

  openAddFolderDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(right: 10, bottom: 10),
            title: Text(
              "New folder",
              style: textStyle(17, Colors.black, FontWeight.w600),
            ),
            content: TextFormField(
              controller: folderController,
              autofocus: true,
              style: textStyle(17, Colors.black, FontWeight.w600),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[50]!,
                  hintText: "Untitiled folder",
                  hintStyle: textStyle(16, Colors.grey, FontWeight.w500)),
            ),
            actions: [
              InkWell(
                  onTap: () => Get.back(),
                  child: Text(
                    "Cancel",
                    style: textStyle(16, textcolor, FontWeight.bold),
                  )),
              InkWell(
                  onTap: () {
                    userCollection
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('folders')
                        .add({
                      "name": folderController.text,
                      "time": DateTime.now(),
                    });
                    Get.offAll(Nav_Screen());
                  },
                  child: Text(
                    "Create",
                    style: textStyle(16, textcolor, FontWeight.bold),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecentFiles(),
                  FolderSections(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        builder: (context) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () => openAddFolderDialog(context),
                                    child: Row(
                                      children: [
                                        Icon(
                                          EvaIcons.folderAdd,
                                          color: Colors.grey,
                                          size: 32,
                                        ),
                                        Text(
                                          "Folder",
                                          style: textStyle(20, Colors.black,
                                              FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                    onTap: ()=>FirebaseService().uploadFile(''),
                                        child: Text(
                                          "Upload",
                                          style: textStyle(
                                              20, Colors.black, FontWeight.w600),
                                        ),
                                      ),
                                      Icon(
                                        EvaIcons.upload,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
