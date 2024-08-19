import 'package:flutter/material.dart';
import 'package:room_reserve_owner/views/Rooms/rooms_view.dart';

class Config {
  Widget getRoute(String route){
    switch(route){
      case 'dashboard':
        return Container();
      case 'clients':
        return Container();
      case 'rooms':
        return RoomsView();
      case 'bookings':
        return Container();
      case 'history':
        return Container();
      case 'settings':
        return Container();
      default:
        return Container();

    }
  }
}