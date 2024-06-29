import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storo/controllers/files_controller.dart';
import 'package:cloud_storo/controllers/files_screen_controller.dart';
import 'package:cloud_storo/screens/display_file_screen.dart';
import 'package:cloud_storo/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderSections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<FilesScreenContoller>(
        builder: (FilesScreenContoller foldersContoller) {
      if (foldersContoller != null && foldersContoller.folderList != null) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: foldersContoller.folderList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Get.to(
                () => DisplayFileScreen(
                  title: foldersContoller.folderList[index].name,
                  type: "folder",
                ),
                binding: FilesBinding(
                  "folders",
                  foldersContoller.folderList[index].name,
                  foldersContoller.folderList[index].name,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.00001),
                        offset: Offset(10, 10),
                        blurRadius: 5,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Folder.png',
                      height: 82,
                      width: 82,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      foldersContoller.folderList[index].name,
                      style: textStyle(18, textcolor, FontWeight.bold),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: userCollection
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('files')
                            .where('folder',
                                isEqualTo:
                                    foldersContoller.folderList[index].name)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          return Text(
                            "${snapshot.data!.docs.length} items",
                            style: textStyle(
                                14, Colors.grey[400]!, FontWeight.bold),
                          );
                        }),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
