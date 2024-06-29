import 'package:cloud_storo/controllers/files_screen_controller.dart';
import 'package:cloud_storo/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Recent Files",
            style: textStyle(20, textcolor, FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
       GetX<FilesScreenContoller>(
          builder: (FilesScreenContoller controller) {
            return Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recentfilesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: Container(
                        height: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.recentfilesList[index].fileType=="image"?ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image(
                                height: 60,
                                width: 65,
                                image: NetworkImage(
                                    controller.recentfilesList[index].url),
                                fit: BoxFit.cover,
                              ),
                            ):Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 0.15),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Image(width: 42,height: 42,image:AssetImage('assets/${controller.recentfilesList[index].fileExtension}.png') ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              controller.recentfilesList[index].name,
                              style: textStyle(13, textcolor, FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        ),
      ],
    );
  }
}
