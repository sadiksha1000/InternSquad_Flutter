import 'package:flutter/material.dart';
import 'package:internsquademployer/models/employer.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/screens/tabscreen.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _profilekey = GlobalKey<FormState>();
  File? _image;
  String companyName = '';
  String email = '';
  String address = '';
  String phone = '';
  String companyProfile = '';

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  @override
  void didChangeDependencies() {
    var employerData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    companyName = employerData['companyName'];
    // companyProfile = employerData['companyProfile'];
    email = employerData['email'];
    address = employerData['address'];
    phone = employerData['phone'];
    companyProfile = employerData['companyProfile'];
    super.didChangeDependencies();
  }

  //method to open image from camera

  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  //method to open image from gallery

  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;

    return Scaffold(
        appBar: MyAppBar(title: 'Profile Page'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _profilekey,
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _image == null
                          ? const AssetImage('assets/images/user.png')
                              as ImageProvider
                          : FileImage(_image!),
                    ),
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) => bottomSheet());
                      },
                      child: Text(
                        'Choose profile picture',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      initialValue: companyName,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        companyName = value!;
                      },
                      validator: MultiValidator(
                          [RequiredValidator(errorText: '* Required field')]),
                      decoration: InputDecoration(
                        suffixIconColor: Theme.of(context).primaryColor,
                        suffixIcon: const Icon(Icons.business_rounded),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        labelText: 'Company Name',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                        hintText: 'Enter the name of your company',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                        errorStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        // enabledBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.grey,
                        //   ),
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      initialValue: companyProfile,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      onSaved: (value) {
                        companyProfile = value!;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: '* Required'),
                        MinLengthValidator(50,
                            errorText: 'At least 50 characters required'),
                      ]),
                      decoration: InputDecoration(
                        suffixIconColor: Theme.of(context).primaryColor,
                        suffixIcon: const Icon(Icons.business_rounded),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        hintText: 'Say about your company',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                        labelText: 'Company Profile',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                        errorStyle: const TextStyle(fontSize: 15),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    TextFormField(
                      initialValue: email,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        email = value!;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: "*Required field"),
                        EmailValidator(
                            errorText: "Please enter a valid email address"),
                      ]),
                      decoration: InputDecoration(
                        suffixIconColor: Theme.of(context).primaryColor,
                        suffixIcon: const Icon(Icons.email),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                        hintText: 'Enter your email address',
                        errorStyle: const TextStyle(fontSize: 15),
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                        // enabledBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.grey,
                        //   ),
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      initialValue: address,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        address = value!;
                      },
                      validator: MultiValidator(
                          [RequiredValidator(errorText: '* Required field')]),
                      decoration: InputDecoration(
                        suffixIconColor: Theme.of(context).primaryColor,
                        suffixIcon: const Icon(Icons.location_on_outlined),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        labelText: 'Address',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                        hintText: 'Enter your home address',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                        errorStyle: const TextStyle(fontSize: 15),
                        // enabledBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.grey,
                        //   ),
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    TextFormField(
                      initialValue: phone,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        phone = value!;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: '* Required field'),
                        MinLengthValidator(10,
                            errorText: 'At least 10 characters required')
                      ]),
                      decoration: InputDecoration(
                        suffixIconColor: Theme.of(context).primaryColor,
                        suffixIcon: const Icon(Icons.phone),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontFamily: 'Roboto',
                        ),
                        hintText: 'Enter your phone number',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                        errorStyle: const TextStyle(fontSize: 15),
                        // enabledBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.grey,
                        //   ),
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      width: width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_profilekey.currentState!.validate()) {
                            _profilekey.currentState!.save();

                            Employer emp = Employer(
                              companyName: companyName,
                              address: address,
                              companyProfile: companyProfile,
                              email: email,
                              phone: phone,
                            );

                            EmployerProvider().updateEmployer(emp, _image);
                            // if (isUpdated) {
                            //   Navigator.of(context)
                            //       .pushReplacementNamed(TabScreen.routeName);
                            //   MotionToast.success(
                            //           description: const Text(
                            //               'Employer profile updated successfully'))
                            //       .show(context);
                            // } else {
                            //   MotionToast.error(
                            //           description: const Text(
                            //               'Could not update account'))
                            //       .show(context);
                            // }
                          }
                        },
                        child: const Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: Size(
                            double.infinity,
                            height * 0.07,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Choose profile photo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
