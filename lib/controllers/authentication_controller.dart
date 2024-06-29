
import 'package:cloud_storo/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authcontroller extends GetxController{
  FirebaseAuth auth=FirebaseAuth.instance;
  GoogleSignIn googleSignIn=GoogleSignIn();
  Rx<User?> user=Rx<User?>(FirebaseAuth.instance.currentUser);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user.bindStream(auth.authStateChanges());
  }
  login()async{
    GoogleSignInAccount ? googleuser=await googleSignIn.signIn();
    if (googleuser != null){
    GoogleSignInAuthentication  googleauth=await googleuser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleauth.idToken,accessToken: googleauth.accessToken,
    );
    print("user successfull");
    UserCredential userCredential=await auth.signInWithCredential(credential);
    User ? user=userCredential.user!;
    userCollection.doc(user.uid).set({
      "username":user.displayName,
      "profileURL":user.photoURL,
      "email":user.email,
      "uid":user.uid,
      "userCreated":DateTime.now(),
    });
    }

  }
}