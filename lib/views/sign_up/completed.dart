import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:progress_bar_steppers/steppers.dart';
import 'package:room_reserve_owner/components/kalubtn.dart';
import 'package:room_reserve_owner/controllers/lodge_controller.dart';
import 'package:room_reserve_owner/helpers/auth_service.dart';
import 'package:room_reserve_owner/views/dashboard/dashboard.dart';

class Completed extends StatefulWidget {
  Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  AuthService _authService = AuthService();

  LodgeController _lodgeController = Get.find();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('CONGRATUTIONS!', style: GoogleFonts.agbalumo(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green),),
          Text('Your online lodge is now ready',style: TextStyle(color: StepperColors.grey300, fontWeight: FontWeight.w500),),
          SizedBox(height: 40,),
          _loading?
              Container(
                width: 30,
                child: LoadingIndicator(indicatorType: Indicator.ballTrianglePathColored),
              ):
          Kalubtn(
            borderRadius: 40,
            width: 200,
              label: 'Go to Dashboard',
              onclick: ()async{
                await _authService.signUpWithEmailAndPassword(
                    _lodgeController.lodge.value.email,
                    _lodgeController.lodge.value.password,
                    _lodgeController.lodge.value.name);
                
                    Get.offAll(()=>Dashboard(), transition: Transition.fadeIn);
              }
          )
        ],
      ),
    );
  }
}
