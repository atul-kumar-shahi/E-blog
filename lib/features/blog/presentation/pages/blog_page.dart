import 'package:blog/core/common/widgets/custom_loader.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/add_new_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/show_snackbar.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => BlogPage());


  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blog App'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, AddNewPage.route());
            }, icon: Icon(CupertinoIcons.add_circled))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if(state is BlogFailure){
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if(state is BlogLoading){
              return CustomLoader();
            }
            if(state is BlogDisplaySuccess){
              return ListView.builder(
                  itemCount:state.blogs.length,
                  itemBuilder: (context, index){
                   final blog=state.blogs[index];
                   return BlogCard(blog: blog,color: index%3==0?AppPallete.gradient1:index%3==1?AppPallete.gradient2:AppPallete.gradient3,);
                  });
            }
            return SizedBox(
              child: Text('No Blogs to display'),
            );

          },
        )


    );
  }
}
