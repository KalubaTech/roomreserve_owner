import 'dart:html' as html;
import 'dart:io';


import 'package:dotted_border/dotted_border.dart';
import 'package:drop_zone/drop_zone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_reserve_owner/components/kalutext.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';

class LodgeSetup extends StatefulWidget {
  LodgeSetup({super.key});

  @override
  State<LodgeSetup> createState() => _LodgeSetupState();
}

class _LodgeSetupState extends State<LodgeSetup> {

  LodgeController _lodgeController = Get.find();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


  bool isDragIn = false;
  List<html.File> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.addListener((){
      _lodgeController.lodge.value.name = _nameController.text;
    });
    _phoneController.addListener((){
      _lodgeController.lodge.value.phone = _phoneController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 400,
                        child: Kalutext(
                          controller: _nameController,
                          hintText: 'Enter Lodge Name ',
                          labelText: 'Lodge Name: ',
                          labelTextStyle: TextStyle(),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        child: Kalutext(
                          controller: _phoneController,
                          hintText: 'Enter phone number ',
                          labelText: 'Phone Number: ',
                          labelTextStyle: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Container(
                width: 200,
                height: 160,
                child: DropZone(
                  onDragEnter: () {
                    setState(() {
                      isDragIn = true;
                    });
                  },
                  onDragExit: () {
                    setState(() {
                      isDragIn = false;
                    });
                  },
                  onDrop: (List<html.File>? files) {
                    if (files != null && files.isNotEmpty) {
                      setState(() {
                        images.addAll(files);
                        _lodgeController.lodge.value.logo = files.first.relativePath;
                      });
                    }
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    color: Colors.black,
                    strokeWidth: 1,
                    dashPattern: [4, 4],
                    child: InkWell(
                      onTap: () async {
                        //Uint8List? imageFile = await ImagePickerWeb!.getImageAsBytes();
                        setState(() {
                        //  _imageData = imageFile;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDragIn ? Colors.grey : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/upload.png', width: 60),
                            SizedBox(height: 20),
                            Text('Drop images here to upload', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
