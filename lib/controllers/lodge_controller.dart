import 'package:get/get.dart';
import 'package:room_reserve_owner/models/lodge_model.dart';

class LodgeController extends GetxController{
  var lodge = LodgeModel(
      uid: '',
      name: '',
      email: '',
      phone: '',
      address: '',
      district: '',
      province: '',
      latlng: '',
      datetime: '',
      password: ''
  ).obs;
}