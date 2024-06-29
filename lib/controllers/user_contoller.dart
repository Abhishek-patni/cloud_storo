import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  var email = ''.obs;
  var photoURL = ''.obs;
  var name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        email.value = user.email ?? '';
        photoURL.value = user.photoURL ?? '';
        name.value = user.displayName ?? '';
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle the error appropriately (e.g., show a message to the user)
    }
  }
}
