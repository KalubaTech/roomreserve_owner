import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:room_reserve_owner/components/kalubtn.dart';
import 'package:room_reserve_owner/components/kalutext.dart';
import 'package:room_reserve_owner/helpers/auth_service.dart';
import 'package:room_reserve_owner/styles/colors.dart';
import 'package:get/get.dart';
import 'package:room_reserve_owner/views/dashboard/dashboard.dart';
import 'package:room_reserve_owner/views/sign_up/sign_up.dart';


class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/lodge.jpg'), fit: BoxFit.cover)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Room Reserve', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                      Text('Your Best Comfort', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
              ),
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Image.asset('assets/roomreservelogo.png', width: 200,),
                  SizedBox(height: 10,),
                  Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  SizedBox(height: 20,),
                  Kalutext(
                    controller: _emailController,
                    hintText: 'Enter email',
                    labelText: '     Email Address',
                    labelTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  SizedBox(height: 10,),
                  Kalutext(
                    controller: _passwordController,
                    hintText: 'Enter Password',
                    labelText: '     Password',
                      labelTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    borderRadius: BorderRadius.circular(60),
                    isObscured: true,
                    showEye: true,
                  ),
                  SizedBox(height: 20,),
                  isLoading?Container(
                    width: 20,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballTrianglePathColored,
                       colors: [
                         Karas.primary,
                         Karas.action,
                         Colors.green,
                       ],
                       strokeWidth: 4,
                    ),
                  ):
                  Kalubtn(
                      borderRadius: 40,
                      label: 'LOGIN',
                      onclick: ()async{
                        setState(() {
                          isLoading=!isLoading;
                        });

                        var response = await _authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                        if(response!=null){
                          Get.offAll(()=>Dashboard());
                        }else{
                          setState(() {
                            isLoading=!isLoading;
                          });
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an Account? '),
                      TextButton(
                          onPressed: (){
                            Get.to(()=>SignUp(), transition: Transition.fadeIn);
                          },
                          child: Text('Sign up',
                            style: TextStyle(color: Karas.action),
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text('UNILUS - ${DateTime.now().year}',style: TextStyle(fontSize: 12, color: Colors.grey),),
                  SizedBox(height: 10,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
