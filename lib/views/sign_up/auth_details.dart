import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_reserve_owner/components/kalutext.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';

class AuthDetails extends StatefulWidget {
    AuthDetails({super.key});

  @override
  State<AuthDetails> createState() => _AuthDetailsState();
}

class _AuthDetailsState extends State<AuthDetails> {

    LodgeController _lodgeController = Get.find();

    TextEditingController _emailController = TextEditingController();

    TextEditingController _passwordController = TextEditingController();

    TextEditingController _repeatController = TextEditingController();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController.addListener((){
      _lodgeController.lodge.value.email = _emailController.text;
    });

    _passwordController.addListener((){
      _lodgeController.lodge.value.password = _passwordController.text;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 400,
            child: Column(
              children: [
                SizedBox(height: 40,),
                Kalutext(
                    controller: _emailController,
                    labelText: 'Email Address',
                    hintText: 'Enter email address',
                    labelTextStyle: TextStyle(),
                ),
                SizedBox(height: 20,),
                Kalutext(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter password',
                  labelTextStyle: TextStyle(),
                ),
                SizedBox(height: 20,),
                Kalutext(
                  controller: _passwordController,
                  labelText: 'Repeat password',
                  hintText: 'Repeat password',
                  labelTextStyle: TextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
