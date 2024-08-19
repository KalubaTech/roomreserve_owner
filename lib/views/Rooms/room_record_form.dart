import 'dart:html' as html;
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:drop_zone/drop_zone.dart';
import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:room_reserve_owner/components/kalubtn.dart';
import 'package:room_reserve_owner/controllers/rooms_controller.dart';
import 'package:room_reserve_owner/models/room_model.dart';
import 'package:simple_chips_input/simple_chips_input.dart';

class RoomRecordForm extends StatefulWidget {
  RoomRecordForm({super.key});

  @override
  State<RoomRecordForm> createState() => _RoomRecordFormState();
}

class _RoomRecordFormState extends State<RoomRecordForm> {
  RoomsController _roomsController = Get.find();

  int roomnum = 0;
  TextEditingController _description = TextEditingController();
  List<String> amenities = [];
  List<dynamic> _rooms = List.generate(20, (index) => index + 1);
  bool isDragIn = false;
  List<html.File> images = [];
  Uint8List? _imageData;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  Future<Uint8List> _readFileAsBytes(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;
    return reader.result as Uint8List;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5)
        )
      ),
      width: 500,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text('Room Number: '),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: DropdownFlutter(
                          hintText: 'Select room number',
                          items: _rooms,
                          initialItem: _rooms[0],
                          onChanged: (value) {},
                          canCloseOutsideBounds: true,
                          closedHeaderPadding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: CustomDropdownDecoration(
                            expandedBorder: Border.all(
                              color: Colors.grey
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Description: '),
                      TextField(
                        controller: _description,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter room description',
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('Amenities: '),
                      SimpleChipsInput(
                          separatorCharacter: ' ',
                          deleteIcon: Icon(Icons.remove_circle, color: Colors.red,size: 18,),
                        textFormFieldStyle: TextFormFieldStyle(
                          decoration: InputDecoration(
                            border: OutlineInputBorder()
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Kalubtn(
                    width: 100,
                    borderRadius: 40,
                    label: 'Add',
                    onclick: (){
                      RoomModel room = RoomModel(
                          uid: '',
                          roomNumber: roomnum.toString(),
                          images: images.map((f)=>f.relativePath!).toList(),
                          description: _description.text,
                          amenities: amenities
                      );

                      _roomsController.rooms.value.add(room);

                    }
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upload images:', style: TextStyle()),
              SizedBox(height: 4),
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
                        Uint8List? imageFile = await ImagePickerWeb.getImageAsBytes();
                        setState(() {
                          _imageData = imageFile;
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
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  width: 200,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final file = images[index];
                      return FutureBuilder<Uint8List>(
                        future: _readFileAsBytes(file),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return Stack(
                              children: [
                                Image.memory(
                                  height: double.infinity,
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        images.removeWhere((f)=>f==file);
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
