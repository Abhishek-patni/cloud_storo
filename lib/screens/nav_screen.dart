import 'package:cloud_storo/controllers/navigation_controller.dart';
import 'package:cloud_storo/screens/filescreen.dart';
import 'package:cloud_storo/screens/storage_screen.dart';
import 'package:cloud_storo/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Nav_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(25),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Header(),
          Obx(() => Get.find<NavigationController>().tab.value == "Storage"
                ? StorageScreen()
                : FileScreen(),
          ),
        ],
      ),
    );
  }
}
