// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, always_specify_types, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mochigo/controller/login_controller.dart';
import 'package:mochigo/controller/mochi_controller.dart';
import 'package:mochigo/core/models/mochi_model.dart';
import 'package:mochigo/core/theme/mochigo_theme.dart';
import 'package:mochigo/presentation/home_screen.dart';

class AddMochiScreen extends StatefulWidget {
  const AddMochiScreen({super.key, required this.size});
  final Size size;
  @override
  _AddMochiScreenState createState() => _AddMochiScreenState();
}

class _AddMochiScreenState extends State<AddMochiScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String mochiName = '';
  String mochiPrice = '';
  String mochiCategory = '';
  String description = '';

  late String _selectedCategory = '';

  List<String> mochisCategory = [
    'Filled',
    'Special',
    'Mystery Box',
    'Boxes',
    'Other',
  ];

  late final List<Widget> _imagesWidgetListPrimary = [];
  late File images;

  final LoginProvider _loginProvider = Get.find<LoginProvider>();
  final MochiProvider _mochiProvider = Get.find<MochiProvider>();

  // pickup image
  Future<void> pickImage() async {
    if (!kIsWeb) {
      final PickedFile? image = await ImagePicker.platform
          .pickImage(source: ImageSource.gallery, imageQuality: 40);
      if (image == null) {
        Get.snackbar('Error', 'Images were not recieved');
      } else {
        setState(() {
          _imagesWidgetListPrimary.removeWhere(
            (Widget element) => element == _imagesWidgetListPrimary.last,
          );

          images = File(image.path);

          _imagesWidgetListPrimary.add(Image.file(File(image.path)));

          _imagesWidgetListPrimary.add(imagePickerWidget(widget.size));
        });
      }
      // WEB
      // kIsWeb
    } else {
      Get.snackbar('Error', 'Permission not granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      final Size size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 211, 245),
          foregroundColor: Colors.black,
          title: const Text(
            "Add Mochi to the catalog",
          ),
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
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 211, 245),
          foregroundColor: Colors.black,
          title: const Text(
            "Admin feature available on mobile",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("This feature is only available on mobile")
              ],
            ),
          ),
        ),
      );
    }
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
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo,
                size: 45,
                color: Colors.white,
              ),
              Text(
                "Add image \nof the Mochi",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                    ),
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
              "Price of Mochi :",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'mochi price'),
            onSaved: (String? newValue) => mochiPrice = newValue!,
            keyboardType: TextInputType.number,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Mochi price cannot be empty!';
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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 216, 216),
                ),
              ),
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addMochiForSell() async {
    final bool validate = _formKey.currentState!.validate();
    if (validate && _selectedCategory != '' && images != null) {
      _formKey.currentState!.save();
      //creating new instance of mochimodel
      final MochiModel newMochi = MochiModel(
        name: mochiName,
        id: '',
        category: _selectedCategory,
        ownerId: _loginProvider.userData.userId,
        description: description,
        price: double.parse(mochiPrice.replaceAll(",", "")),
        images: "1",
      );
      await _mochiProvider.addMochiForSell(newMochi, images);

      await Get.off(const HomeScreen());
    } else if (_selectedCategory == '') {
      Get.snackbar('Error', 'Select appropriate category');
    } else if (images == null) {
      Get.snackbar('Error', 'Images were not recieved');
    }
  }
}
