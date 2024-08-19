import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';

import '../../components/kalutext.dart';


class LocationPicker extends StatefulWidget {
  LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LodgeController _lodgeController = Get.find();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _districtController = TextEditingController();

  TextEditingController _provinceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController.addListener((){
      _lodgeController.lodge.value.address = _addressController.text;
    });
    _districtController.addListener((){
      _lodgeController.lodge.value.district = _districtController.text;
    });
    _provinceController.addListener((){
      _lodgeController.lodge.value.province = _provinceController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 400,
            child: GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(-15.3875, 28.3228),zoom: 12)
            ),
          ),
          SizedBox(width: 40,),
          Expanded(
              child: Container(
                child: Column(
                  children: [
                    Kalutext(
                      controller: _addressController,
                      labelText: 'Address: ',
                      hintText: 'Enter address',
                      labelTextStyle: TextStyle(

                      ),
                    ),
                    SizedBox(height: 20,),
                    Kalutext(
                      controller: _districtController,
                      labelText: 'District: ',
                      hintText: 'Enter district',
                      labelTextStyle: TextStyle(

                      ),
                    ),
                    SizedBox(height: 20,),
                    Kalutext(
                      controller: _provinceController,
                      labelText: 'Province: ',
                      hintText: 'Enter province',
                      labelTextStyle: TextStyle(

                      ),
                    ),
                  ]
                )
              )
          )
        ],
      ),
    );
  }
}
