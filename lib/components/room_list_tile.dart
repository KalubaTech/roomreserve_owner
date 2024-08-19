import 'package:flutter/material.dart';

import '../models/room_model.dart';

class RoomListTile extends StatelessWidget {
  RoomModel roomModel;
  RoomListTile({required this.roomModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/lodge.jpg')
                )
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Room: ${roomModel.roomNumber}', style: TextStyle(fontWeight: FontWeight.w600),),
                      Text('${roomModel.description}'),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
