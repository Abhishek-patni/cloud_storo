import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


TextStyle  textStyle(double fontSize,Color color,FontWeight fw){
  return GoogleFonts.montserrat(
    fontSize: fontSize,
    color:color,
    fontWeight: fw,
  );
}

Color textcolor=Color(0xffa69cb7);

CollectionReference <Map<String,dynamic>> userCollection=FirebaseFirestore.instance.collection('users');