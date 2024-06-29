import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storo/modals/file_model.dart';
import 'package:cloud_storo/modals/folder_model.dart';
import 'package:cloud_storo/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilesScreenContoller extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  RxList<Foldermodel> folderList = <Foldermodel>[].obs;
  RxList<FileModel> recentfilesList = <FileModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    recentfilesList.bindStream(userCollection
        .doc(uid)
        .collection('files')
        .orderBy('dateUploaded', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<FileModel> files = [];
      query.docs.forEach((element) {
        files.add(FileModel.fromDocumentSnapshot(element));
      });
      return files;
    }));
    folderList.bindStream(
      userCollection
          .doc(uid)
          .collection('folders')
          .orderBy('time', descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Foldermodel> folders = [];
        query.docs.forEach((element) {
          Foldermodel folder = Foldermodel.fromDocumenSnapshot(element);
          folders.add(folder);
        });
        return folders;
      }),
    );
  }
}
