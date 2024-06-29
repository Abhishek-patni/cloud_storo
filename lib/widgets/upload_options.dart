import 'package:cloud_storo/controllers/files_controller.dart';
import 'package:cloud_storo/screens/display_file_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadOptions extends StatelessWidget {
  Widget colouredContainer(
      Color bgcolor, Icon icon, String option, String title) {
    return InkWell(
      onTap: () => Get.to(() => DisplayFileScreen(title: title, type: 'files'),
          binding: FilesBinding("files", '', option)),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bgcolor,
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        colouredContainer(
          Colors.lightBlue.withOpacity(0.2),
          Icon(
            Icons.image,
            color: Colors.cyan,
            size: 30,
          ),
          "image",
          "images",
        ),
        colouredContainer(
          Colors.pink.withOpacity(0.3),
          Icon(
            Icons.play_arrow,
            color: Colors.pink.withOpacity(0.5),
            size: 42,
          ),
          "video",
          "Videos",
        ),
        colouredContainer(
          Colors.blue.withOpacity(0.4),
          Icon(
            EvaIcons.fileText,
            color: Colors.indigoAccent.withOpacity(0.5),
            size: 30,
          ),
          "application",
          "Documents",
        ),
        colouredContainer(
          Colors.purple.withOpacity(0.2),
          Icon(
            EvaIcons.music,
            color: Colors.pink.withOpacity(0.3),
            size: 30,
          ),
          "audio",
          "Audios",
        ),
      ],
    );
  }
}
