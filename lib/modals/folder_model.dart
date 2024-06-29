import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Foldermodel {
  late String id;
  late String name;
  late Timestamp dateCreated;
  late int items;

  Foldermodel(this.id, this.dateCreated, this.items, this.name,);


 Foldermodel.fromDocumenSnapshot(QueryDocumentSnapshot <Object?> doc){
   id = doc.id;
   name=doc['name'];
   dateCreated=doc['time'];
 }


}