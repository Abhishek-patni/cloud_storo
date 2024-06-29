import 'dart:io';
import 'package:cloud_storo/modals/file_model.dart';
import 'package:cloud_storo/utils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class FirebaseService {
  final Uuid uuid = Uuid();

  Future<File> compressFile(File file, String fileType) async {
    try {
      if (fileType == "image") {
        Directory directory = await getTemporaryDirectory();
        String targetPath =
            directory.path + "/${uuid.v4().substring(0, 8)}.jpg";
        XFile? result = await FlutterImageCompress.compressAndGetFile(
            file.path, targetPath,
            quality: 75);
        return File(result!.path);
      } else if (fileType == "video") {
        MediaInfo? info = await VideoCompress.compressVideo(file.path,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true);
        return File(info!.path!);
      } else {
        return file;
      }
    } catch (e) {
      // Handle compression errors
      print("Compression Error: $e");
      throw e;
    }
  }

  Future<void> uploadFile(String folderName) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        for (File file in files) {
          String? fileType = lookupMimeType(file.path);
          if (fileType == null) {
            print("Unknown file type: ${file.path}");
            continue; // Skip file if type is unknown
          }
          String end = '/';
          int endIndex = fileType.indexOf(end);
          String filteredFileType = fileType.substring(0, endIndex);
          String fileName = file.path.split('/').last;
          String fileExtension = fileName.substring(fileName.indexOf('.') + 1);

          // Get compressed file
          File compressedFile = await compressFile(file, filteredFileType);

          // Get length of file collection
          int length = await userCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('files')
              .get()
              .then((value) => value.docs.length);

          // Upload file to storage
          UploadTask uploadTask = FirebaseStorage.instance
              .ref()
              .child('files')
              .child('File $length')
              .putFile(compressedFile);
          TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
          String fileUrl = await snapshot.ref.getDownloadURL();

          // Save data in Firestore
          await userCollection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('files')
              .add({
            "fileName": fileName,
            "fileUrl": fileUrl,
            "fileType": filteredFileType,
            "fileExtension": fileExtension,
            "folder": folderName,
            "size": (compressedFile.lengthSync() / 1024).round(),
            "dateUploaded": DateTime.now(),
          });
        }
        if (folderName.isEmpty) {
          Get.back();
        } else {
          print("Operation is cancelled");
        }
      }
    } catch (e) {
      // Handle upload errors
      print("Upload Error: $e");
    }
  }

  deleteFile(FileModel file) async {
    await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('files')
        .doc(file.id)
        .delete();
  }

  downloadFile(FileModel file) async {
    try {
      Directory? downloadDirectory = await getDownloadsDirectory();
      if (downloadDirectory == null) {
        print("Could not find the downloads directory.");
        return;
      }

      String filePath =
          "${downloadDirectory.path}/${file.name.replaceAll(" ", "")}";

      // Check and request storage permission if not granted
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        var permissionStatus = await Permission.storage.request();
        if (permissionStatus.isGranted) {
          // If permission is granted after request, proceed with download
          await _startDownload(file.url, filePath);
        } else {
          print("Permission denied to access storage.");
        }
      } else {
        // If permission is already granted, proceed with download
        await _startDownload(file.url, filePath);
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  _startDownload(String url, String filePath) async {
    try {
      // Download the file
      await Dio().download(url, filePath);
      print("File downloaded successfully to: $filePath");
    } catch (e) {
      print("Error downloading file: $e");
    }
  }
}
