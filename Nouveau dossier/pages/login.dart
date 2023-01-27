import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/login_request_model.dart';
import 'package:frontend/services/api_service.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../config.dart';
class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: HexColor("#283B71"),
      body: ProgressHUD(
      child: Form(
        key: globalFormKey,
        child: _loginUI(context),
      ),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),

    ));
  }
  Widget _loginUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height /3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ]
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("images/three.png",
                  width: 250,
                  fit: BoxFit.contain,),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,bottom: 30, top: 50),
            child: Text("Login",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white
            ),),
          ),
          FormHelper.inputFieldWidget(context,"username", "Username", (onValidateVal){
            if(onValidateVal.isEmpty){
              return "Username can\'t be Empty";
            }
            return null;
          }, (onSavedVal){
            username = onSavedVal;
          },
          borderColor: Colors.white,
          prefixIconColor: Colors.white,
          borderFocusColor: Colors.white,
          hintColor: Colors.white.withOpacity(0.7),
          textColor: Colors.white,
            borderRadius: 10,
            suffixIcon: Icon(Icons.person, color: Colors.white,)
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(context,"password", "Password", (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Password can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              password = onSavedVal;
            },
                borderColor: Colors.white,
                prefixIconColor: Colors.white,
                borderFocusColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                textColor: Colors.white,
                borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  hidePassword = !hidePassword;
                });
              }, icon: Icon(hidePassword? Icons.visibility_off:Icons.visibility)),
                backgroundColor: Colors.white.withOpacity(0.7)
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 25, top: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    children: [
                      TextSpan(
                        text: 'Forget Password ?',
                        style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          print("Forget Password");
                        }
                      )
                    ]
                  ),
                ),
              ),
          ),
          SizedBox(height: 20,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Center(
                 child: FormHelper.submitButton(
                     "Login", (){
                       if(validateAndSave()){
                         setState(() {
                           isAPIcallProcess = true;
                         });
                         LoginRequestModel model = LoginRequestModel(username: username!, password: password!);

                         APIService.login(model).then((response) => {
                         setState(() {
                         isAPIcallProcess = false;
                         }),
                           if(response){
                             Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,)
                           } else{
                         FormHelper.showSimpleAlertDialog(
                             context, Config.appName, "Invalide Username/Password",
                             "OK",
                             (){
                               Navigator.pop(context);
                             }
                         )
                       }
                         });
                       }

                 },
                     btnColor:  HexColor("#283B71"),
                     borderColor: Colors.white,
                     txtColor: Colors.white,
                     borderRadius: 20
                 )),
             Center(
                 child: FormHelper.submitButton(
                     "Register", (){
                       Navigator.pushNamed(context,"/register");
                 },
                     btnColor:  HexColor("#283B71"),
                     borderColor: Colors.white,
                     txtColor: Colors.white,
                     borderRadius: 20
                 )),
           ],
         )
          // SizedBox(height: 20,),
          // Center(
          //   child: Text(
          //     "OR",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 18,
          //       fontStyle: FontStyle.italic,
          //       color: Colors.white
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20,),
          // Align(
          //   alignment: Alignment.center,
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 25, top: 5),
          //     child: RichText(
          //       text: TextSpan(
          //           style: TextStyle(color: Colors.grey, fontSize: 14.0),
          //           children: [
          //             TextSpan(text: "Don't you have an account?  "),
          //             TextSpan(
          //                 text: 'Sign up',
          //                 style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
          //                 recognizer: TapGestureRecognizer()..onTap = (){
          //                   print("Forget Password");
          //                 }
          //             )
          //           ]
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  bool validateAndSave(){
    final form = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else{return false;}
  }
}
