class LodgeModel {
  String uid;
  String name;
  String email;
  String phone;
  String address;
  String district;
  String province;
  String latlng;
  String? logo;
  String datetime;
  String password;


  LodgeModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.district,
    required this.province,
    required this.latlng,
    this.logo,
    required this.datetime,
    required this.password
  });
}