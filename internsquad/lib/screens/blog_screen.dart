import 'package:flutter/material.dart';
import 'package:internsquad/models/blog.dart';
import 'package:internsquad/providers/blog_provider.dart';
import 'package:internsquad/screens/individual_blog.dart';
import 'package:internsquad/widgets/appbar.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class BlogScreen extends StatefulWidget {
  static const routeName = '/blog';
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  late Future<List<Blog>> blog;
  // String imageUrl = 'http://10.0.2.2:90/';
  String imageUrl = 'http://192.168.1.68:90/';

  @override
  void initState() {
    super.initState();
    blog = BlogProvider().getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: 'Blogs',
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
                          fontSize: 22,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
