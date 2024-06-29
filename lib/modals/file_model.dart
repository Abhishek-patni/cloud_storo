import 'package:cloud_firestore/cloud_firestore.dart';

class FileModel {
  late String id;
  late String url;
  late String name;
  late Timestamp dateUploaded;
  late String fileType;
  late String fileExtension;
  late String folderName;
  late int size;

  FileModel(this.id, this.url, this.name, this.dateUploaded, this.fileType,
      this.fileExtension, this.folderName, this.size);

  FileModel.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {
    id = doc.id;
    url = doc['fileUrl'];
    name = doc['fileName'];
    dateUploaded = doc['dateUploaded'];
    fileType = doc['fileType'];
    fileExtension = doc['fileExtension'];
    folderName = doc['folder'];
    size = doc['size'];
  }
}
