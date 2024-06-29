import 'package:cloud_storo/firebase.dart';
import 'package:cloud_storo/modals/file_model.dart';
import 'package:cloud_storo/utils.dart';
import 'package:cloud_storo/widgets/audio_player_widget.dart';
import 'package:cloud_storo/widgets/pdf_viewer.dart';
import 'package:cloud_storo/widgets/video_Player_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewFilesScreen extends StatelessWidget {
  FileModel file;

  ViewFilesScreen(this.file);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            file.name,
            style: textStyle(18, Colors.white, FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              file.name,
                              style:
                                  textStyle(16, Colors.black, FontWeight.w500),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey, height: 3),
                        ListTile(
                          onTap: () {
                            FirebaseService()
                                .downloadFile(file);
                            Get.back();
                          },
                          leading: Icon(
                            Icons.file_download,
                            color: Colors.grey,
                          ),
                          title: Text(
                            "Download",
                            style: textStyle(16, Colors.black, FontWeight.w500),
                          ),
                          dense: true,
                          contentPadding:
                              EdgeInsets.only(bottom: 0, left: 16, top: 12),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                        ),
                        ListTile(
                          onTap: () {
                            FirebaseService()
                                .deleteFile(file);
                            Get.back();
                          },
                          leading: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                          title: Text(
                            "Remove",
                            style: textStyle(16, Colors.black, FontWeight.w500),
                          ),
                          dense: true,
                          contentPadding:
                              EdgeInsets.only(bottom: 0, left: 16, top: 12),
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      body: file.fileType == "image"
          ? showImage(file.url)
          : file.fileType == 'application'
              ? showFile(file, context)
              : file.fileType == 'video'
                  ? VideoPlayerWidget(
                      url: file.url,
                    )
                  : file.fileType == "audio"
                      ? AudioPlayerWidget(
                          url: file.url,
                        )
                      : showError(),
    );
  }
}

showError() {}

showFile(FileModel file, BuildContext context) {
  if (file.fileExtension == 'pdf') {
    return PdfViewer(
      file: file,
    );
  } else {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Unforunately this file cannot be openend",
            style: textStyle(18, textcolor, FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 36,
            child: TextButton(
                onPressed: () {
                  FirebaseService().downloadFile(file);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
                child: Text(
                  "Download",
                  style: textStyle(17, Colors.white, FontWeight.w600),
                )),
          )
        ],
      ),
    );
  }
}

showImage(String url) {
  return Center(
    child: Image(image: NetworkImage(url)),
  );
}
