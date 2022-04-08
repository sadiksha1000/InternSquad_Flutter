import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/screens/forgotpassword.dart';
import 'package:internsquademployer/screens/internship_posting.dart';
import 'package:internsquademployer/screens/signup.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import './tabscreen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginEmployerkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<bool> loginEmployer(String email, String password) {
    var res = EmployerProvider().loginEmployer(email, password, Client());
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
            color: Colors.white,
            width: double.infinity,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Login',
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
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                Container(
                  height: height * 0.45,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage('assets/images/interns.jpg'),
                  ),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                Form(
                  key: _loginEmployerkey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextFormField(
                          key: Key('email'),
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
                            suffixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter your email address',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          key: Key('password'),
                          obscureText: true,
                          keyboardType: TextInputType.text,
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
                            suffixIcon: Icon(Icons.remove_red_eye_outlined),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.routeName);
                          },
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Container(
                          width: width * 0.6,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_loginEmployerkey.currentState!.validate()) {
                                _loginEmployerkey.currentState!.save();
                                var res = await loginEmployer(email, password);
                                if (res) {
                                  // SharedPreferences preferences =
                                  //     await SharedPreferences.getInstance();
                                  // var pref =
                                  //     preferences.setString('email', email);

                                  // print("Preferences${pref}");
                                  Navigator.of(context).pushReplacementNamed(
                                      TabScreen.routeName);
                                  MotionToast.success(
                                    description: Text('Login Successful'),
                                    toastDuration: const Duration(seconds: 1),
                                  ).show(context);
                                } else {
                                  MotionToast.error(
                                    description: Text('Login Failed'),
                                    toastDuration: const Duration(seconds: 1),
                                  ).show(context);
                                }
                              }
                            },
                            child: Center(
                              child: Text(
                                'Login',
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
                              'Not registered yet? ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    SignUpEmployerScreen.routeName);
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
