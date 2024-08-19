import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';
import 'package:room_reserve_owner/controllers/rooms_controller.dart';
import 'package:room_reserve_owner/styles/colors.dart';
import 'package:room_reserve_owner/views/dashboard/dashboard.dart';
import 'package:room_reserve_owner/views/sign_in/sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyB-EnYxDMUfZpAR0QM44O2WTFJ7Lf9zrKc",
        authDomain: "roomreserve-a4f27.firebaseapp.com",
        projectId: "roomreserve-a4f27",
        storageBucket: "roomreserve-a4f27.appspot.com",
        messagingSenderId: "422634939506",
        appId: "1:422634939506:web:72d56e7687da2ffc474eeb",
        measurementId: "G-SBE3STZZQX"
    )
  );
  Get.put(RoomsController());
  Get.put(LodgeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lodge Owner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.teal
      ),
      home: SignIn(),
    );
  }
}
