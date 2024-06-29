import 'package:cloud_storo/controllers/files_controller.dart';
import 'package:cloud_storo/firebase.dart';
import 'package:cloud_storo/screens/view_file_screen.dart';
import 'package:cloud_storo/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DisplayFileScreen extends StatelessWidget {
  final String title;
  final String type;

  DisplayFileScreen({super.key, required this.title, required this.type});

  FilesController filesController = Get.find<FilesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: textcolor),
          ),
          title: Text(
            title,
            style: textStyle(18, textcolor, FontWeight.w600),
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => type == 'folder'
            ? FirebaseService().uploadFile(title)
            : FirebaseService().uploadFile(''),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.redAccent[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
      body: Obx(
        () => GridView.builder(
          itemCount: filesController.files.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.25),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Get.to(
                ViewFilesScreen(
                  filesController.files[index],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 10,
                  top: 15,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      filesController.files[index].fileType == 'image'
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: NetworkImage(
                                  filesController.files[index].url,
                                ),
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 75,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 75,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/${filesController.files[index].fileExtension}.png',
                                  ),
                                  height: 55,
                                  width: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 4, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                filesController.files[index].name,
                                style:
                                    textStyle(14, textcolor, FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              color: Colors.black,
                              iconSize: 20,
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
                                              filesController.files[index].name,
                                              style: textStyle(16, Colors.black,
                                                  FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Divider(color: Colors.grey, height: 3),
                                        ListTile(
                                          onTap: () {
                                            FirebaseService().downloadFile(
                                                filesController.files[index]);
                                            Get.back();
                                          },
                                          leading: Icon(
                                            Icons.file_download,
                                            color: Colors.grey,
                                          ),
                                          title: Text(
                                            "Download",
                                            style: textStyle(16, Colors.black,
                                                FontWeight.w500),
                                          ),
                                          dense: true,
                                          contentPadding: EdgeInsets.only(
                                              bottom: 0, left: 16, top: 12),
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            FirebaseService().deleteFile(
                                                filesController.files[index]);
                                            Get.back();
                                          },
                                          leading: Icon(
                                            Icons.delete,
                                            color: Colors.grey,
                                          ),
                                          title: Text(
                                            "Remove",
                                            style: textStyle(16, Colors.black,
                                                FontWeight.w500),
                                          ),
                                          dense: true,
                                          contentPadding: EdgeInsets.only(
                                              bottom: 0, left: 16, top: 12),
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
