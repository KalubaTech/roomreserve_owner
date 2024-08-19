import 'package:flutter/material.dart';
import 'package:progress_bar_steppers/stepper_data.dart';
import 'package:progress_bar_steppers/stepper_style.dart';
import 'package:progress_bar_steppers/steppers_widget.dart';
import 'package:room_reserve_owner/components/kalubtn.dart';
import 'package:room_reserve_owner/views/Rooms/room_record_form.dart';
import 'package:room_reserve_owner/styles/colors.dart';
import 'package:room_reserve_owner/views/sign_up/auth_details.dart';
import 'package:room_reserve_owner/views/sign_up/completed.dart';
import 'package:room_reserve_owner/views/sign_up/location_picker.dart';
import 'package:room_reserve_owner/views/sign_up/lodge_setup.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var currentStep = 0;
  var totalSteps = 4;
  final stepsData = [
    StepperData(
      label: 'Lodge Setup',
    ),
    StepperData(
      label: 'Location',
    ),
    StepperData(
      label: 'Rooms',
    ),
    StepperData(
      label: 'Auth Details',
    ),
  ];

  List<Widget> _pages = [
    LodgeSetup(),
    LocationPicker(),
    Container(
       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: RoomRecordForm()
    ),
    AuthDetails(),
    Completed()
  ];

  PageController _pageController = PageController();

  @override
  void initState() {
    totalSteps = stepsData.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                     fit: BoxFit.cover,
                    image: AssetImage('assets/lodge.jpg')
                )
              ),
              height: 100,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.2),
                      ]
                  )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),
                        Text('Register Your Lodge with few steps', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all((currentStep<5&&currentStep!=0)?Karas.primary:Colors.grey)
                          ),
                          color: Colors.white,
                            onPressed: (){
                            if(currentStep<5&&currentStep!=0){
                              setState(() {
                                currentStep--;
                                _pageController.animateToPage(currentStep, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                              });
                            }

                        }, icon: Icon(Icons.chevron_left)),
                        SizedBox(width: 20,),
                        IconButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all((currentStep<4)?Karas.primary:Colors.grey)
                            ),
                            color: Colors.white,
                            onPressed: (){
                            if(currentStep<4){
                              setState(() {
                                currentStep++;
                                _pageController.animateToPage(currentStep, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                              });
                            }
                        }, icon: Icon(Icons.chevron_right)),
                      ],
                    )
                  ],
                ),
              )
            ),
            SizedBox(height: 20,),
            Container(
              child: Steppers(
                direction: StepperDirection.horizontal,
                labels: stepsData,
                currentStep: currentStep+1,
                stepBarStyle: StepperStyle(
                  activeColor: Karas.primary,
                  maxLineLabel: 2,
                  // inactiveColor: StepperColors.ink200s
                ),
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: PageView(
                      children: _pages,
                      pageSnapping: false,
                      controller: _pageController,
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
