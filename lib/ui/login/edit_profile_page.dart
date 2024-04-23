// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/provider/data/LoginData.dart';
import 'package:flutter_logical_quiz/resizer/widget_utils.dart';
import 'package:flutter_logical_quiz/utility/color_scheme.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profile_model.dart';
import '../../resizer/fetch_pixels.dart';
import '../../utility/constants.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileModel profileModel;

  const EditProfilePage({super.key, required this.profileModel});

  @override
  State<EditProfilePage>  createState() {
    return _EditProfilePage();
  }
}

class _EditProfilePage extends State<EditProfilePage> {
  Future<bool> _requestPop() {
    backPage();

    return Future.value(false);
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int firstPosition = 2;
  int lastPosition = 1;
  int currentPosition = -1;

  @override
  void initState() {
    super.initState();

    firstNameController.text = widget.profileModel.firstName!;
    lastNameController.text = widget.profileModel.lastName!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double profileSize = FetchPixels.getPixelHeight(250);
    double size = FetchPixels.getPixelHeight(190);
    double editSize = FetchPixels.getPixelHeight(60);



    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: getBackgroundColor(context),
          appBar: getNoneAppBar(context),
          body: SafeArea(
            child: Column(
              children: [
                getCommonAppBar(context, title: 'Edit Profile', function: () {
                  _requestPop();
                }),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpace(context)),
                  child: Column(
                    children: [
                      getVerticalSpace(35),
                      SizedBox(
                        height: profileSize,
                        width: profileSize,
                        child: Stack(
                          children: [

                            Center(
                              child: ValueListenableBuilder(builder: (context, value, child) {
                                return SizedBox(
                                  child: getProfileImage(size),
                                  height: size,
                                  width: size,
                                );
                              },valueListenable: imagePath),
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  child: Container(
                                    height: editSize,
                                    width: editSize,
                                    padding: EdgeInsets.all(
                                        FetchPixels.getPixelHeight(12)),
                                    margin: EdgeInsets.only(
                                        bottom: FetchPixels.getPixelHeight(30),
                                        right: FetchPixels.getPixelWidth(30)),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: getBackgroundColor(context),
                                        boxShadow: [
                                          BoxShadow(
                                            color: getShadowColor(context),
                                            blurRadius: 24,
                                            offset: const Offset(0, 6),
                                          ),
                                        ]),
                                    child: getSvgImageWithSize(
                                        context,
                                        'edit.svg',
                                        FetchPixels.getPixelHeight(30),
                                        FetchPixels.getPixelHeight(30),
                                        color: getFontColor(context)),
                                  ),
                                  onTap: () {
                                    _imgFromGallery();
                                  },
                                ))
                          ],
                        ),
                      ),
                      getVerticalSpace(80),
                      getDefaultTextFiledWidget(
                          context, "First Name", firstNameController,
                          focus: (currentPosition == firstPosition),
                          onTapFunction: () {
                        setState(() {
                          currentPosition = firstPosition;
                        });
                      }),
                      getVerticalSpace(40),
                      getDefaultTextFiledWidget(
                          context, "Last Name", lastNameController,
                          focus: (currentPosition == lastPosition),
                          onTapFunction: () {
                        setState(() {
                          currentPosition = lastPosition;
                        });
                      }),
                      getVerticalSpace(40),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                )),
                getButtonWidget(
                  context,
                  'Update Profile',
                  () async {
                    if (isNotEmpty(firstNameController.text) &&
                        isNotEmpty(lastNameController.text)) {

                      String url='';
                      if(imagePath.value.isNotEmpty){
                        url = await uploadFile();
                      }

                      LoginData.updateProfile(
                          id: widget.profileModel.id,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,image: url);


                      if (!mounted) {
                        return;
                      }
                      showCustomToast(
                          context: context, message: 'Edit successfully');
                      Navigator.of(context).pop();
                    } else {
                      showCustomToast(context: context, message: 'Fill detail');
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
  Future<String> uploadFile() async {
    final path = 'files/${_imgFile!.name}';
    final file = File(imagePath.value);
    Reference ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

    String urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
  getProfileImage(double size) {
    Widget dummyImage = Center(
      child: Image.asset(
        '${assetPath}profile.png',
        color: Colors.grey.shade400,
        fit: BoxFit.fill,
      ),
    );

    if (imagePath.value.isNotEmpty  ) {

      return  Container(
        width:size,
        height: size,


        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          image: DecorationImage(
              image: FileImage(File(imagePath.value)),
              fit: BoxFit.contain
          ),
        ),
      );



    } else if (widget.profileModel.image != null &&
        widget.profileModel.image!.isNotEmpty) {



      return  Container(
        width:size,
        height: size,


        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
          image: DecorationImage(
              image: NetworkImage(widget.profileModel.image!),
              fit: BoxFit.contain
          ),
        ),
      );
    } else {
      return dummyImage;
    }
  }


  ValueNotifier<String> imagePath = ValueNotifier('');
  XFile? _imgFile ;
  final picker = ImagePicker();

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);


    if(image!=null){
    _imgFile = image;
    imagePath.value = image.path;
  }
}}
