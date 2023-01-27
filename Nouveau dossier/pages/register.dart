import 'package:flutter/material.dart';
import 'package:frontend/models/register_request_model.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter/gestures.dart';

import '../config.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: HexColor("#283B71"),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: _registerUI(context),
        ),
        inAsyncCall: isAPIcallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),

    ));
  }
  Widget _registerUI(BuildContext context){
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
            child: Text("Register",style: TextStyle(
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

          Padding(padding: EdgeInsets.only(top: 10),
           child: FormHelper.inputFieldWidget(context,"email", "Email", (onValidateVal){
              if(onValidateVal.isEmpty){
                return "Email can\'t be Empty";
              }
              return null;
            }, (onSavedVal){
              email = onSavedVal;
            },
                borderColor: Colors.white,
                prefixIconColor: Colors.white,
                borderFocusColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                textColor: Colors.white,
                borderRadius: 10,
                suffixIcon: Icon(Icons.mail_outline, color: Colors.white,)
            ),
          ),


          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(
                  child: FormHelper.submitButton(
                      "Register", (){
    if(validateAndSave()){
    setState(() {
    isAPIcallProcess = true;
    });
    RegisterRequestModel model = RegisterRequestModel(username: username!, password: password!,email: email!,);

    APIService.register(model).then((response) => {
    setState(() {
    isAPIcallProcess = true;
    }),
    if(response.data != null){
      FormHelper.showSimpleAlertDialog(
          context, Config.appName, "Registeration Successfull. Please login to the account.",
          "OK",
              (){
            Navigator.pushNamedAndRemoveUntil(context, '/login',
                  (route) => false,
            );
          }
      ),
    } else{
    FormHelper.showSimpleAlertDialog(
    context, Config.appName,response.message,
    "OK",
    (){
    Navigator.pop(context);}
    )}
    });
    }
                  },
                      btnColor:  HexColor("#283B71"),
                      borderColor: Colors.white,
                      txtColor: Colors.white,
                      borderRadius: 20
                  )),
            ],
          )
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

