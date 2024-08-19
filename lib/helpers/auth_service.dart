import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';
import 'package:room_reserve_owner/controllers/rooms_controller.dart';
import 'package:room_reserve_owner/models/lodge_model.dart';
import 'package:room_reserve_owner/views/sign_in/sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  LodgeController _lodgeController = Get.find();
  RoomsController _roomsController = Get.find();

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Map<String,dynamic>data = {
        'uid': userCredential.user!.uid,
        'email':email,
        'name':name,
        'phone': _lodgeController.lodge.value.phone,
        'logo': _lodgeController.lodge.value.logo,
        'district':_lodgeController.lodge.value.district,
        'province':_lodgeController.lodge.value.province,
        'address':_lodgeController.lodge.value.address,
        'latlng':_lodgeController.lodge.value.latlng,
        'status':'pending',
        'datetime':'${DateTime.now()}'
      };

      _firebaseFirestore.collection('lodge').add(data).then((value){
        _lodgeController.lodge.value.uid = value.id;
      });

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var lodgeData = await _firebaseFirestore.collection('lodge').where('uid',isEqualTo: userCredential.user!.uid).get();
      var doc = lodgeData.docs.first.data();
      LodgeModel _lodge = LodgeModel(
          uid: '${userCredential.user!.uid}',
          name: '${doc['name']}',
          email: email,
          phone: '${doc['phone']}',
          address: '${doc['address']}',
          district: '${doc['district']}',
          province: '${doc['province']}',
          latlng: '${doc['latlng']}',
          datetime: '${doc['datetime']}',
          password: password
      );

      _lodgeController.lodge.value = _lodge;

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAll(()=>SignIn(), transition: Transition.fadeIn);
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
