import 'package:flutter/material.dart';
import 'package:room_reserve_owner/components/kalubtn.dart';
import 'package:room_reserve_owner/components/kalutext.dart';
import 'package:room_reserve_owner/components/room_list_tile.dart';
import 'package:room_reserve_owner/models/room_model.dart';
import 'package:room_reserve_owner/views/Rooms/room_record_form.dart';

class RoomsView extends StatelessWidget {
  const RoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text('Rooms', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Kalubtn(
                         width: 80,
                          borderRadius: 20,
                          label: 'New *',
                          onclick: (){

                          }
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                      child: Container(
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RoomRecordForm(),
                            SizedBox(width: 20,),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: true,
                                    itemBuilder: (context,index){
                                      RoomModel _room = RoomModel(uid: '$index', roomNumber: '$index', images: [], description: 'Description $index', amenities: []);

                                      return RoomListTile(roomModel: _room);
                                    }
                                )
                            )
                          ],
                        ),
                      )
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
