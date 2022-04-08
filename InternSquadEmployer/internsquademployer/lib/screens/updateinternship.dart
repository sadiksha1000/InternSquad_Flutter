import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/screens/myinternships.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class UpdateInternshipPost extends StatefulWidget {
  static const routeName = '/updateinternship';
  const UpdateInternshipPost({Key? key}) : super(key: key);

  @override
  _UpdateInternshipPostState createState() => _UpdateInternshipPostState();
}

class _UpdateInternshipPostState extends State<UpdateInternshipPost> {
  final _internshipkey = GlobalKey<FormState>();
  List<String> _workEnvironment = ['Work from Home', 'Office'];
  List<String> _internshipType = [
    'Full Time',
    'Part Time',
    'Summertime Internship'
  ];

  String department = '';
  String title = '';
  DateTime startDate = DateTime.now();
  DateTime deadline = DateTime.now();
  int duration = 0;
  int stipend = 0;
  String internshipDetails = '';
  String workEnvironment = '';
  String internshipType = '';
  String skills = '';
  String whoCanApply = '';
  String perks = '';
  int numberOfOpening = 0;

  // @override
  // void initState() {
  //   final internshipData = Provider.of<InternshipProvider>(context);
  //   // internshipData.getInternships();
  // }

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as String;
    print("InternshipIdUpdate${id}");
    Internship internship =
        Provider.of<InternshipProvider>(context).findById(id);
    print("Internship${internship}");
    title = internship.title!;
    department = internship.department!;
    duration = int.parse(internship.duration!);
    stipend = int.parse(internship.stipend!);
    internshipDetails = internship.internshipDetails!;
    workEnvironment = internship.workEnvironment!;
    internshipType = internship.internshipType!;
    skills = internship.skills!;
    whoCanApply = internship.whoCanApply!;
    perks = internship.perks!;
    numberOfOpening = int.parse(internship.numberOfOpenings!);
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            item,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
      );

  // DateTime startDate = DateTime.now();
  Future<Null> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        // print(startDate.toString());
      });
    }
  }

  Future<Null> selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: deadline,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != deadline) {
      setState(() {
        deadline = picked;
        // print(deadline.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    var id = ModalRoute.of(context)!.settings.arguments as String;

    Future<bool> updateInternship(Internship internship, String id) {
      var res = InternshipProvider().updateInternship(internship, id);
      return res;
    }

    return Scaffold(
        appBar: MyAppBar(title: 'Edit Internship Post'),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            // height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: height * 0.03,
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 20),
                //   child: Text(
                //     'Post your internship details here',
                //     style: TextStyle(
                //       fontSize: 23,
                //       fontWeight: FontWeight.w600,
                //       fontFamily: 'Roboto',
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: height * 0.015,
                // ),
                Form(
                  key: _internshipkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: title,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            title = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(Icons.topic_outlined),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Title',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter the title of internship',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              // alignment: AlignmentDirectional.bottomEnd,
                              hint: Text('Set the work environment preference'),
                              value: _workEnvironment[0],
                              isExpanded: true,
                              // items: workEnvironment.map((work) {
                              //   return DropdownMenuItem(
                              //       child: Text(work), value: work);
                              // }).toList(),
                              items:
                                  _workEnvironment.map(buildMenuItem).toList(),
                              onChanged: (value) => setState(() {
                                workEnvironment = value as String;
                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: department,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            department = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon:
                                const Icon(Icons.corporate_fare_rounded),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Department',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText:
                                'Enter the department internship belongs to',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              // alignment: AlignmentDirectional.bottomEnd,
                              hint: Text('Set the internship type'),
                              value: _internshipType[0],
                              isExpanded: true,
                              // items: workEnvironment.map((work) {
                              //   return DropdownMenuItem(
                              //       child: Text(work), value: work);
                              // }).toList(),
                              items:
                                  _internshipType.map(buildMenuItem).toList(),
                              onChanged: (value) => setState(() {
                                internshipType = value as String;
                              }),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Start Date',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  startDate.year.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  '/',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  startDate.month.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  '/',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  startDate.day.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                              onPressed: () {
                                selectStartDate(context);
                              },
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Select Date',
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: duration.toString(),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            duration = int.parse(value!);
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon:
                                const Icon(Icons.access_time_filled_outlined),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Duration',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter the duration of internship',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: stipend.toString(),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            stipend = int.parse(value!);
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(TablerIcons.report_money),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Stipend',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText:
                                'Enter the estimated stipend for internship',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deadline',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  deadline.year.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const Text(
                                  '/',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  deadline.month.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const Text(
                                  '/',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  deadline.day.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                              onPressed: () {
                                selectDeadline(context);
                              },
                              style: OutlinedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                              child: const Text(
                                'Select Date',
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: internshipDetails,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          onSaved: (value) {
                            internshipDetails = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field'),
                            MinLengthValidator(50,
                                errorText: 'At least 50 characters required'),
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(Icons.business_rounded),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 10),
                            labelText: 'Internship Details',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter internship details',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: skills,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          onSaved: (value) {
                            skills = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field'),
                            MinLengthValidator(50,
                                errorText: 'At least 50 characters required'),
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(Icons.local_activity),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 10),
                            labelText: 'Skills Required',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Enter skills required for internship',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: whoCanApply,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          onSaved: (value) {
                            whoCanApply = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field'),
                            MinLengthValidator(50,
                                errorText: 'At least 50 characters required'),
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(TablerIcons.question_mark),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            labelText: 'Who can Apply',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText:
                                'Enter credentials required for interns to apply',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: perks,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          onSaved: (value) {
                            perks = value!;
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field'),
                            MinLengthValidator(50,
                                errorText: 'At least 50 characters required'),
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(TablerIcons.award),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            labelText: 'Perks',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText: 'Perks of joining the internship',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                          height: height * 0.015,
                        ),
                        TextFormField(
                          initialValue: numberOfOpening.toString(),
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            numberOfOpening = int.parse(value!);
                          },
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required field')
                          ]),
                          decoration: InputDecoration(
                            suffixIconColor: Theme.of(context).primaryColor,
                            suffixIcon: const Icon(TablerIcons.users),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            labelText: 'Number of openings',
                            labelStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontFamily: 'Roboto',
                            ),
                            hintText:
                                'Enter the number of openings for internship',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 15,
                            ),
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
                        Container(
                          width: width * 0.6,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_internshipkey.currentState!.validate()) {
                                _internshipkey.currentState!.save();

                                Internship internshipdata = Internship(
                                  title: title,
                                  workEnvironment: workEnvironment,
                                  department: department,
                                  internshipType: internshipType,
                                  startDate: startDate.toString(),
                                  duration: duration.toString(),
                                  stipend: stipend.toString(),
                                  deadline: deadline.toString(),
                                  internshipDetails: internshipDetails,
                                  skills: skills,
                                  whoCanApply: whoCanApply,
                                  perks: perks,
                                  numberOfOpenings: numberOfOpening.toString(),
                                );

                                // print(internship);
                                bool isUpdated =
                                    await updateInternship(internshipdata, id);
                                print("Response$isUpdated");
                                if (isUpdated) {
                                  Navigator.of(context).pushNamed(
                                      MyInternshipPostings.routeName);
                                  MotionToast.success(
                                          description: const Text(
                                              'Internship updated successfully'))
                                      .show(context);
                                } else {
                                  MotionToast.error(
                                          description: const Text(
                                              'Failed to update internship'))
                                      .show(context);
                                }
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
              ],
            ),
          ),
        ));
  }
}
