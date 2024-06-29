import 'package:cloud_storo/controllers/authentication_controller.dart';
import 'package:cloud_storo/screens/nav_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Root(),
    );
  }
}

class Root extends StatelessWidget {
  Authcontroller authcontroller=Get.put(Authcontroller());

  Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return authcontroller.user.value == null ? Login_Screen():Nav_Screen();
    });
  }
}

