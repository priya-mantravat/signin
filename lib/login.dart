import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/signup.dart';
import '/authentication.dart';



class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //defining formkey
  final _formKey = GlobalKey<FormState>();

  //creating instance for auth controller
  AuthController controller = Get.put(AuthController());

  Map<String, String> userLoginData = {"email": "", "password": ""};
  //calling the login method here
  login() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      print('Data for login $userLoginData');
      controller.login(userLoginData['email'],userLoginData['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.brown[400],
      body: ListView(
        children:[
          Container(
              padding: const EdgeInsets.only(left: 35,top: 90),
              child: const Text('Welcome\nLogin Here',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),),
            ),

            Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *0.1,
                    right: 35,
                    left: 35),
                //
                child:  Form(
                  //  passing the key here
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:  InputDecoration(
                            prefixIcon: const Icon(Icons.mail,
                              color: Colors.brown,),
                            hintText: " Email",
                            hintStyle: const TextStyle(color: Colors.brown , ),
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.brown),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          // writing the conditions in validator
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if(value.length<3){
                              return 'email is less than 3 character';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userLoginData['email'] = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration:  InputDecoration(
                            prefixIcon: const Icon(Icons.lock,
                              color: Colors.brown,),
                            hintText: " Password",
                            hintStyle: const TextStyle(color: Colors.brown , ),
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.brown),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          // writing the conditions in validator
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userLoginData['password'] = value!;
                          },
                        ),
                        const SizedBox(height: 50),
                        //
                        Container(
                          child:  TextButton(
                              onPressed: login,
                              child: const Text('Sign In',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 27, fontWeight: FontWeight.w500, color: Colors.white
                                ),
                              )),
                        ),

                        Container(
                          child: const TextButton(
                              onPressed: null,
                              child: Text('Forgot Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        Container(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Do not have an account' ,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.brown,
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute
                                      (builder: (context)=> const UploadProfileImage(),));
                                  },
                                  child: const Text('SignUp'))
                            ],
                          ) ,
                        )
                      ],
                    )
                ),
              ),
      ]
            ),

      );
  }
}