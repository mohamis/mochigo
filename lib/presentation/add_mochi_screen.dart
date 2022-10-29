// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, always_specify_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mochigo/core/models/mochi_model.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/home_screen.dart';
import 'package:mochigo/providers/login_provider.dart';
import 'package:mochigo/providers/mochi_provider.dart';
import 'package:mochigo/providers/user_provider.dart';

class AddMochiScreen extends StatefulWidget {
  const AddMochiScreen({super.key, required this.size});
  final Size size;
  @override
  _AddMochiScreenState createState() => _AddMochiScreenState();
}

class _AddMochiScreenState extends State<AddMochiScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String mochiName = '';
  String mochiCategory = '';
  String description = '';

  late String _selectedCategory = '';

  List<String> mochisCategory = [
    'Filled Mochi',
    'Special',
    'Mistery Mochi',
    'Premium',
    'Other',
  ];

  late final List<Widget> _imagesWidgetListPrimary = [];
  List<File> images = [];

  final LoginProvider _loginProvider = Get.find<LoginProvider>();
  final UserProvider _userProvider = Get.find<UserProvider>();
  final MochiProvider _mochiProvider = Get.find<MochiProvider>();

  // pickup image
  Future<void> pickImage() async {
    final PickedFile? image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      _imagesWidgetListPrimary.removeWhere(
        (Widget element) => element == _imagesWidgetListPrimary.last,
      );
      images.add(File(image!.path));
      _imagesWidgetListPrimary.add(Image.file(File(image.path)));

      _imagesWidgetListPrimary.add(imagePickerWidget(widget.size));
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 211, 245),
        title: Text("Add Mochi", style: Theme.of(context).textTheme.headline3),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.3,
                width: size.width,
                child: _imagesWidgetListPrimary.isEmpty
                    ? imagePickerWidget(size)
                    : slider(size),
              ),
              addMochidataField()
            ],
          ),
        ),
      ),
    );
  }

  //image picker widget
  Widget imagePickerWidget(Size size) {
    return InkWell(
      onTap: () async {
        await pickImage();
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          height: size.height * 0.27,
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: MochigoTheme.PRIMARY_COLOR,
            // border: Border.all(color: MochigoTheme.FONT_DARK_COLOR),
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo,
                size: 45,
              ),
              Text(
                "Add image \nof the Mochi",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }

  // CarouselSlider
  Widget slider(Size size) {
    return CarouselSlider(
      initialPage: _imagesWidgetListPrimary.length + 1,
      slideIndicator: CircularSlideIndicator(
        currentIndicatorColor: MochigoTheme.FONT_DARK_COLOR,
      ),
      children: _imagesWidgetListPrimary,
    );
  }

//add mochi data widgets
  Form addMochidataField() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Name of Mochi :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'mochi name'),
            onSaved: (String? newValue) => mochiName = newValue!,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Mochi name cannot be empty!';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Description about mochi :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'mochi description'),
            onSaved: (String? newValue) => description = newValue!,
            keyboardType: TextInputType.multiline,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Mochi description cannot be empty!';
              }

              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Category :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          DropdownButton<String>(
            elevation: 5,
            hint: Text(
              _selectedCategory.isEmpty
                  ? 'Please choose category'
                  : _selectedCategory,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            // value: 'choose',
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: mochisCategory
                .map<DropdownMenuItem<String>>((String currentCategory) {
              return DropdownMenuItem(
                value: currentCategory,
                child: Text(
                  currentCategory,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              );
            }).toList(),
          ),
          Align(
            child: ElevatedButton(
              onPressed: () async {
                await addMochiForSell();
              },
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addMochiForSell() async {
    final bool validate = _formKey.currentState!.validate();
    if (validate && _selectedCategory != '' && images.isNotEmpty) {
      _formKey.currentState!.save();
      print(images);
      print("*************");
      //creating new instance of mochimodel
      final MochiModel newMochi = MochiModel(
        name: mochiName,
        id: '',
        category: _selectedCategory,
        ownerId: _loginProvider.userData.userId,
        description: description,
        images: '1',
        price: 1,
      );
      await _mochiProvider.addMochiForSell(newMochi, images);

      await Get.off(HomeScreen());
    } else if (_selectedCategory == '') {
      Get.snackbar('Error', 'Select appropriate category');
    } else if (images.isEmpty) {
      print("images not recieved");
    }
  }
}
