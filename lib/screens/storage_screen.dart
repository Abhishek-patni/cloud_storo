import 'package:cloud_storo/widgets/storage_container.dart';
import 'package:cloud_storo/widgets/upload_options.dart';
import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 40,),
          StorageContainer(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: UploadOptions(),
          ),
        ],
      ),
    );
  }
}
