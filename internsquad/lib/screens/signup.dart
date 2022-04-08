import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internsquad/models/intern.dart';
import 'package:internsquad/providers/intern_provider.dart';
import 'package:internsquad/screens/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _internSignupkey = GlobalKey<FormState>();
  String fullName = '';
  String email = '';
  String address = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  final _passwordController = TextEditingController();
  var _isLoading = false;

  Future<bool> registerIntern(Intern intern) {
    var res = InternProvider().registerIntern(intern, Client());
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: height,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                const Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Sign up to get started',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Form(
                  key: _internSignupkey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            fullName = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(Icons.person),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Full Name',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter your full name',
                            hintStyle: const TextStyle(
                              fontSize: 16,
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            email = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "*Required field"),
                            EmailValidator(
                                errorText:
                                    "Please enter a valid email address"),
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
                            hintStyle: const TextStyle(
                              fontSize: 16,
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            address = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          onSaved: (value) {
                            password = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: "*Required field"),
                            MinLengthValidator(6,
                                errorText:
                                    "Password must contain atleast 6 characters"),
                            MaxLengthValidator(15,
                                errorText:
                                    "Password cannot be more 15 characters"),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                errorText:
                                    "Password must have atleast one special character"),
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_outlined),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter your password',
                            hintStyle: const TextStyle(
                              fontSize: 16,
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
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "*Required field";
                            }
                            return MatchValidator(
                                    errorText: "Passwords don't match")
                                .validateMatch(val, _passwordController.text);
                          },
                          onSaved: (value) {
                            confirmPassword = value!;
                          },
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon:
                                const Icon(Icons.remove_red_eye_outlined),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Re-enter your password',
                            hintStyle: const TextStyle(
                              fontSize: 16,
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
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          width: width * 0.6,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_internSignupkey.currentState!.validate()) {
                                _internSignupkey.currentState!.save();

                                Intern intern = Intern(
                                  fullName: fullName,
                                  email: email,
                                  address: address,
                                  phone: phone,
                                  password: password,
                                );

                                // print(intern.fullName);
                                // print(intern.email);
                                // print(intern.address);
                                // print(intern.phone);

                                bool isCreated = await registerIntern(intern);

                                if (isCreated) {
                                  Navigator.of(context).pushReplacementNamed(
                                      LoginScreen.routeName);
                                  MotionToast.success(
                                          description: const Text(
                                              'Intern registered successfully'))
                                      .show(context);
                                } else {
                                  MotionToast.error(
                                          description: const Text(
                                              'Failed to create account'))
                                      .show(context);
                                }
                              }
                            },
                            child: const Center(
                              child: Text(
                                'SignUp',
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
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Already registered? ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
