import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internsquademployer/models/blog.dart';
import 'package:internsquademployer/provider/blog_provider.dart';
import 'package:internsquademployer/screens/individual_blog.dart';
import 'package:internsquademployer/screens/updateBlog.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  static const routeName = '/blog';
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  late Future<List<Blog>> blog;
  // String imageUrl = 'http://10.0.2.2:90/';
  String imageUrl = 'http://192.168.1.73:90/';

  String formater(String url) {
    return imageUrl + url;
  }

  @override
  void initState() {
    super.initState();
    blog = BlogProvider().getBlogs();
    print(blog);
    final blogData = Provider.of<BlogProvider>(context, listen: false);
    blogData.setBlogs();
    // blogData.setBlogs();
  }

  Future<bool> deleteBlog(id) {
    var res = BlogProvider().deleteBlog(id, Client());
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final blogData = Provider.of<BlogProvider>(context, listen: false);
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: 'Published Blogs',
        ),
        body: FutureBuilder<List<Blog>>(
          future: blog,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child:
                          MyCardBuilder(snapshot.data![index], height, width),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }

  Widget MyCardBuilder(Blog blog, height, width) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Map<String, dynamic> blogData = {
            'title': blog.title,
            'description': blog.description,
            'uploadDate': blog.uploadDate,
          };
          Navigator.of(context)
              .pushNamed(BlogDetailsScreen.routeName, arguments: blogData);
        },
        child: Container(
          height: height * 0.42,
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  fit: StackFit.passthrough,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        // 'http://10.0.2.2:90/blogDocuments/1644243994803happy-successful-businessman.jpg',
                        'http://192.168.1.73:90/blogDocuments/1644243994803happy-successful-businessman.jpg',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    UpdateBlog.routeName,
                                    arguments: blog.id);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: 25,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                bool isDeleted = await deleteBlog(blog.id);
                                // print(blog.title);
                                print(isDeleted);
                                if (isDeleted) {
                                  Navigator.of(context).pushReplacementNamed(
                                      BlogScreen.routeName);
                                  MotionToast.success(
                                          description: const Text(
                                              'Blog deleted successfully'))
                                      .show(context);
                                }
                              },
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                                size: 25,
                              ),
                            )
                          ]),
                    )
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    height: height * 0.05,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        blog.title as String,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
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
