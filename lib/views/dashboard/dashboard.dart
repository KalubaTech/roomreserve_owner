import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_reserve_owner/components/kalubtn.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';
import 'package:room_reserve_owner/helpers/auth_service.dart';
import 'package:room_reserve_owner/styles/colors.dart';
import 'package:room_reserve_owner/application/config.dart';
import '../Rooms/rooms_view.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  LodgeController _lodgeController = Get.find();

  AuthService _authService = AuthService();

  String selectedItem = 'dashboard';

  Config _config = Config();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage('assets/lodge.jpg')
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.black87,
                          Colors.black38
                        ]
                    )
                ),
                child: Row(
                  children: [
                    Text('${_lodgeController.lodge.value.name}', style: TextStyle(color: Colors.white, fontSize: 18),)
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: BorderDirectional(end: BorderSide(color: Colors.grey))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                   fit: BoxFit.cover,
                                    image: AssetImage('assets/lodge.jpg')
                                ),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight:  Radius.circular(20))
                              ),
                              width: double.infinity,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                     borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black87,
                                          Colors.black38
                                        ]
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  selectedItem = 'dashboard';
                                });
                              },
                              title: Text('Dashboard'),
                              leading: Icon(Icons.dashboard, color: Colors.orange,),
                              trailing: selectedItem=='dashboard'?Icon(Icons.arrow_right, color: Colors.orange,):Icon(Icons.circle_outlined, color: Colors.transparent),
                            ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  selectedItem = 'clients';
                                });
                              },
                              title: Text('Clients'),
                              leading: Icon(Icons.group, color: Colors.orange,),
                              trailing: selectedItem=='clients'?Icon(Icons.arrow_right, color: Colors.orange,):Icon(Icons.circle_outlined, color: Colors.transparent),
                            ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  selectedItem = 'rooms';
                                });
                              },
                              title: Text('Rooms'),
                              leading: Icon(Icons.bed_rounded, color: Colors.orange,),
                              trailing: selectedItem=='rooms'?Icon(Icons.arrow_right, color: Colors.orange,):Icon(Icons.circle_outlined, color: Colors.transparent),
                            ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  selectedItem = 'bookings';
                                });
                              },
                              title: Text('Bookings'),
                              leading: Icon(Icons.local_convenience_store_sharp, color: Colors.orange,),
                              trailing: selectedItem=='bookings'?Icon(Icons.arrow_right, color: Colors.orange,):Icon(Icons.circle_outlined, color: Colors.transparent),
                            ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  selectedItem = 'history';
                                });
                              },
                              title: Text('History'),
                              leading: Icon(Icons.history, color: Colors.orange,),
                              trailing: selectedItem=='history'?Icon(Icons.arrow_right, color: Colors.orange,):Icon(Icons.circle_outlined, color: Colors.transparent),
                            ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  selectedItem = 'settings';
                                });
                              },
                              title: Text('Settings'),
                              leading: Icon(Icons.settings, color: Colors.orange,),
                              trailing: selectedItem=='settings'?Icon(Icons.arrow_right, color: Colors.orange,):Icon(Icons.circle_outlined, color: Colors.transparent,),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Kalubtn(
                                backgroundColor: Karas.action,
                                borderRadius: 40,
                                width: 100,
                                  label: 'Log out',
                                  onclick: (){
                                    _authService.signOut();
                                  }
                              ),
                            ),
                            SizedBox(height: 20,)
                          ],
                        )
                      ),
                      Expanded(
                          child: Container(
                            child: _config.getRoute(selectedItem),
                          )
                      )
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
