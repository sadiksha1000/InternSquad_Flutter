import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:internsquademployer/models/blog.dart';
import 'package:internsquademployer/provider/blog_provider.dart';
import 'package:internsquademployer/screens/blogs.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class UpdateBlog extends StatefulWidget {
  static const routeName = '/update-blog';
  const UpdateBlog({Key? key}) : super(key: key);

  @override
  _UpdateBlogState createState() => _UpdateBlogState();
}

class _UpdateBlogState extends State<UpdateBlog> {
  final _blogKey = GlobalKey<FormState>();
  String title = '';
  DateTime uploadDate = DateTime.now();
  String description = '';

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as String;
    print("BlogId${id}");
    Blog blog = Provider.of<BlogProvider>(context).findById(id);
    print("Blog${blog}");
    title = blog.title!;
    description = blog.description!;
    print(title);
    print(description);
  }

  Future<Null> selectUploadDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: uploadDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != uploadDate) {
      setState(() {
        uploadDate = picked;
        // print(startDate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    var id = ModalRoute.of(context)!.settings.arguments as String;

    Future<bool> updateBlog(Blog blog, String id) {
      var res = BlogProvider().updateBlog(blog, id);
      // print("PostBlogRes${res}");
      return res;
    }

    return Scaffold(
      appBar: MyAppBar(
        title: 'Update Blog Posts',
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Form(
                key: _blogKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: title,
                        onSaved: (value) {
                          title = value!;
                        },
                        validator: MultiValidator(
                            [RequiredValidator(errorText: '* Required field')]),
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
                          hintText: 'Enter the title of blog',
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
                        keyboardType: TextInputType.multiline,
                        initialValue: description,
                        maxLines: 10,
                        onSaved: (value) {
                          description = value!;
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: '* Required'),
                          MinLengthValidator(50,
                              errorText: 'At least 50 characters required'),
                        ]),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          hintText: 'Enter the description of blog',
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
                        height: height * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upload Date',
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
                                uploadDate.year.toString(),
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
                                uploadDate.month.toString(),
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
                                uploadDate.day.toString(),
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
                              selectUploadDate(context);
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
                        height: height * 0.03,
                      ),
                      Container(
                        width: width * 0.6,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_blogKey.currentState!.validate()) {
                              _blogKey.currentState!.save();

                              Blog blog = Blog(
                                title: title,
                                description: description,
                                uploadDate: uploadDate.toString(),
                              );

                              bool isUpdated = await updateBlog(blog, id);
                              print("isPosted${isUpdated}");
                              if (isUpdated) {
                                Navigator.of(context)
                                    .pushNamed(BlogScreen.routeName);
                                MotionToast.success(
                                        description: const Text(
                                            'Blog updated successfully'))
                                    .show(context);
                              } else {
                                MotionToast.error(
                                        description:
                                            const Text('Failed to update blog'))
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
      ),
    );
  }
}
