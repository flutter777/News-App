import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_aggregator/Seems/Home_Screen.dart';

void main(){
  runApp(MaterialApp(home: SplashScreen(),debugShowCheckedModeBanner: false,));
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context)=>Homescreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height *1;
    final width =  MediaQuery.sizeOf(context).width *1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(bottom: 108),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img.png',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            height: height *.5,
            width: width * 9,),
            SizedBox(height: height*0.01,),
            Text("Today's Top Stories",style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800
            ),
            ),
            SizedBox(height: 20,),
            SpinKitThreeBounce(
              color: Colors.deepPurpleAccent,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
