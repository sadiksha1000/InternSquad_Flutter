import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:internsquad/widgets/appbar.dart';

class FeedbackScreen extends StatelessWidget {
  static const routeName = '/feedback';
  FeedbackScreen({Key? key}) : super(key: key);
  final _feedbackkey = GlobalKey<FormState>();
  String feedback = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;

    return Scaffold(
      appBar: MyAppBar(title: 'Feedbacks'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            Form(
              key: _feedbackkey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    TextFormField(
                      key: Key('feedback'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      onSaved: (value) {
                        feedback = value!;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: '* Required'),
                        MinLengthValidator(50,
                            errorText: 'At least 50 characters required'),
                      ]),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        hintText: 'Share your feedbacks',
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
                    SizedBox(height: height * 0.50),
                    Container(
                      width: width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_feedbackkey.currentState!.validate()) {
                            _feedbackkey.currentState!.save();
                          }
                        },
                        child: const Center(
                          child: Text(
                            'Submit',
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
          ],
        ),
      ),
    );
  }
}
