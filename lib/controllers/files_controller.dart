import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storo/modals/file_model.dart';
import 'package:cloud_storo/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FilesController extends GetxController {
  final String type; // Type of files (e.g., "files" or "folders")
  final String foldername; // Folder name (if type is "folders")
  final String fileType; // File type (if type is "files")

  FilesController(this.type, this.foldername, this.fileType);

  late  String uid = FirebaseAuth.instance.currentUser?.uid ?? ''; // Initialize uid with empty string if user is not logged in

  RxList<FileModel> files = <FileModel>[].obs; // Observable list of FileModel objects

  @override
  void onInit() {
    super.onInit();

    if (type == "files") {
      print(fileType);
      files.bindStream(
        userCollection // Assuming userCollection is a reference to the Firestore collection
            .doc(uid)
            .collection('files')
            .where('fileType', isEqualTo: fileType)
            .snapshots()
            .map((QuerySnapshot query) {
          List<FileModel> tempFiles = [];
          query.docs.forEach((element) {
            tempFiles.add(FileModel.fromDocumentSnapshot(element));
          });
          return tempFiles;
        }),
      );
    } else {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        uid = currentUser.uid;
        files.bindStream(
          userCollection
              .doc(uid)
              .collection('files')
              .where('folder', isEqualTo: foldername)
              .snapshots()
              .map((QuerySnapshot query) {
            List<FileModel> tempFiles = [];
            query.docs.forEach((element) {
              tempFiles.add(FileModel.fromDocumentSnapshot(element));
            });
            return tempFiles;
          }),
        );
      } else {
        Get.snackbar(
          'Authentication Error',
          'Please login to access this feature',
          duration: Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // Or you can navigate to the login screen
        Get.offNamed('/Login_Screen'); // Assuming '/login' is your login screen route
      }
    }
  }
}

class FilesBinding implements Bindings {
  final String type;
  final String foldername;
  final String fileType;

  FilesBinding(this.type, this.foldername, this.fileType);

  @override
  void dependencies() {
    Get.lazyPut<FilesController>(
            () => FilesController(type, foldername, fileType));
  }
}
