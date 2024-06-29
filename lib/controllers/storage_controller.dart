import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storo/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  RxInt size = 0.obs;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStorage();
  }

  getStorage() {
    size.bindStream(userCollection
        .doc(uid)
        .collection('files')
        .snapshots()
        .map((QuerySnapshot query) {
      int size = 0;
      query.docs.forEach((element) {
        size += extractSize(element);
      });
      return size;
    }));
  }

  int extractSize(QueryDocumentSnapshot<Object?> element) {
    return element['size'];
  }
}
