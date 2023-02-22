import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/login.dart';


class UploadProfileImage extends StatefulWidget {
  const UploadProfileImage({Key? key}) : super(key: key);

  @override
  State<UploadProfileImage> createState() => _UploadProfileImageState();
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  File? pickedImage;
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Map<String, String> userSignupData = {
    "firstname": "",
    "lastname":"",
    "email": "",
    "password": "",
    "pnonenumber":"",
    "address":""

  };
  AuthController controller = Get.find();
  signUp() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
      _formKey.currentState!.save();
      print('User Sign Up Data $userSignupData');
      controller.signUp(userSignupData['email'], userSignupData['password'],userSignupData['firstname'],
          userSignupData['lastname'],userSignupData['phonenumber'],userSignupData['address']);
    }
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // centerTitle: true,
          // title: const Text('IMAGE PICKER'),
        ),
        backgroundColor: Colors.brown[400],
        body:ListView(
            children:
            [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(
                  //   height: 50,
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown, width: 5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: ClipOval(
                            child:pickedImage!=null ? Image.file(pickedImage!,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ):
                            Image.asset(
                              'asset/jenny.jpg',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: IconButton(
                            onPressed: imagePickerOption,
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: ElevatedButton.icon(
                  //       onPressed: imagePickerOption,
                  //       icon: const Icon(Icons.add_a_photo_sharp),
                  //       label: const Text('UPLOAD IMAGE')),
                  // )
                ],
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height *0.05,
                      right: 35,
                      left: 35),
                  child: Form(
                    //  passing the key here
                    key: _formKey,
                    child: Column(
                        children: [

                          TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                color: Colors.brown,),
                              hintText: "First Name",
                              hintStyle: TextStyle(color: Colors.brown),
                              labelText: "First Name",
                              labelStyle: TextStyle(color: Colors.brown),
                              filled: true,
                              fillColor: Colors.white,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   borderSide: const BorderSide(),
                              //
                              // )
                            ),
                            // writing the conditions in validator
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First Name Required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userSignupData['firstname'] = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person,
                                color: Colors.brown,),
                              hintText: " Last Name",
                              hintStyle: TextStyle(color: Colors.brown),
                              labelText: "Last Name",
                              labelStyle: TextStyle(color: Colors.brown),
                              filled: true,
                              fillColor: Colors.white,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              //   borderSide: const BorderSide(),
                              //
                              // )
                            ),
                            // writing the conditions in validator
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last Name Required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userSignupData['lastname'] = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.mail,
                                    color: Colors.brown,),
                                  labelText: "Email",
                                  hintText: "Enter Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  )
                              ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userSignupData['email'] = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Password",
                                  prefixIcon: const Icon(Icons.lock,
                                    color: Colors.brown,),
                                  hintText: "Enter Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  )
                              ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userSignupData['password'] = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Phone Number",
                                  prefixIcon: const Icon(Icons.add_call,
                                    color: Colors.brown,),
                                  hintText: "Enter Phone Number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  )
                              ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone Number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userSignupData['phonenumber'] = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                              minLines: 2,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Address",
                                  prefixIcon: const Icon(Icons.home,
                                    color: Colors.brown,),
                                  hintText: "Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(),
                                  )
                              ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address Required';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userSignupData['address'] = value!;
                            },
                          ),
                          Container(
                            child:  TextButton(
                                onPressed: signUp,
                                child: const Text('Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 27, fontWeight: FontWeight.w500, color: Colors.white
                                  ),
                                )),
                          ),
                          Container(
                            child:  TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute
                                    (builder: (context)=> const MyLogin(),));
                                },
                                child: const Text('Sign In',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        ]
                    ),
                  )
              )
            ])
    );
  }
}
