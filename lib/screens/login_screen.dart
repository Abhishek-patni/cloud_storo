import 'package:cloud_storo/controllers/authentication_controller.dart';
import 'package:cloud_storo/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_Screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        gradient:LinearGradient(
            begin:Alignment.topCenter,
            end:Alignment.bottomLeft,
            colors:[Colors.deepPurpleAccent,Colors.purpleAccent]),
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewInsets.top + 52),
              child: Image.asset(
                'assets/File manager.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 30, right: 30, bottom: 35,left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(top:25,bottom:25,left:30,right:30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Simplify your",
                      style: textStyle(25, Color(0xff635c98), FontWeight.bold),
                    ),
                    Text(
                      "Keeping your files ",
                      style: textStyle(20, textcolor, FontWeight.w600),
                    ),
                    Text(
                      "Filling system",
                      style: textStyle(25, Color(0xff635c98), FontWeight.bold),
                    ),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: (){
                        Get.find<Authcontroller>().login();
                      },
                      child: Container(
                        width:MediaQuery.of(context).size.width/1.7,
                        height:50,
                        decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(20),
                          color:Colors.deepOrangeAccent.withOpacity(0.8)
                        ),
                        child:Center(
                          child:Text("Lets goo",style:textStyle(23,Colors.white,FontWeight.w700),)
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
