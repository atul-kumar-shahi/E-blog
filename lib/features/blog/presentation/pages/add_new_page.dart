import 'dart:io';

import 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog/core/common/widgets/custom_loader.dart';
import 'package:blog/core/constants/constants.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utils/pick_image.dart';
import 'package:blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/show_snackbar.dart';

class AddNewPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewPage());

  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopic = [];
  File? image;


  void uploadBlog(){
    if (formKey.currentState!.validate() &&
        image != null &&
        selectedTopic.isNotEmpty) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserSignedIn)
              .user
              .id;
      context.read<BlogBloc>().add(
        BlogUpload(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          posterId: posterId,
          topics: selectedTopic,
          image: image!,
        ),
      );
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: uploadBlog,
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),

      body: BlocConsumer<BlogBloc, BlogState>(
  listener: (context, state) {
    if(state is BlogFailure){
      showSnackBar(context, state.error);
    }else if(state is BlogUploadSuccess){
      Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route)=>false);
    }
  },
  builder: (context, state) {
    if(state is BlogLoading){
      return const CustomLoader();

    }
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: selectImage,
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          image != null
                              ? Image.file(image!, fit: BoxFit.cover)
                              : GestureDetector(
                                onTap: () {
                                  selectImage();
                                },
                                child: DottedBorder(
                                  color: AppPallete.borderColor,
                                  dashPattern: const [10, 4],
                                  radius: Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.folder_open, size: 40),
                                        SizedBox(height: 15),
                                        Text(
                                          'Select Your Image',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 6,
                    children:Constants.topics.map(
                              (e) => GestureDetector(
                                onTap: () {
                                  if (selectedTopic.contains(e)) {
                                    selectedTopic.remove(e);
                                  } else {
                                    selectedTopic.add(e);
                                  }
                                  setState(() {});
                                },

                                child: Chip(
                                  label: Text(e),
                                  color:
                                      selectedTopic.contains(e)
                                          ? WidgetStatePropertyAll(
                                            AppPallete.gradient1,
                                          )
                                          : null,
                                  side:
                                      selectedTopic.contains(e)
                                          ? BorderSide.none
                                          : BorderSide(
                                            color: AppPallete.borderColor,
                                          ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: 10),
                BlogEditor(controller: titleController, hintText: 'Blog title'),
                SizedBox(height: 10),
                BlogEditor(
                  controller: contentController,
                  hintText: 'Blog content',
                ),
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}
