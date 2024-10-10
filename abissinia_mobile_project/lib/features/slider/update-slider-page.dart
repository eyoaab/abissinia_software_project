import 'dart:io';
import 'package:abissinia_mobile_project/features/product/product-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:abissinia_mobile_project/features/slider/bloc/slider_bloc.dart';
import 'package:abissinia_mobile_project/features/slider/slider-entity.dart';
import 'package:abissinia_mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';

class UpdateSliderPage extends StatefulWidget {
  final SliderEntity slider; 

  const UpdateSliderPage({Key? key, required this.slider}) : super(key: key);

  @override
  _UpdateSliderPageState createState() => _UpdateSliderPageState();
}

class _UpdateSliderPageState extends State<UpdateSliderPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  
    _titleController = TextEditingController(text: widget.slider.title);
    _descriptionController = TextEditingController(text: widget.slider.description);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
     
      showCustomSnackBar(context, 'Error picking image: $e', false);

    }
  }

  void _clearAllFields() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _image = null;
    });
  }

  void _updateSlider() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        (_image == null && widget.slider.image.isEmpty)) {
    
      showCustomSnackBar(context, 'Please fill all fields', false);
      return;
    }

    final SlidersSend updatedSlider = SlidersSend(
      id: widget.slider.id, 
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      image: _image ?? File(widget.slider.image), 
    );

    BlocProvider.of<SliderBloc>(context).add(UpdateSliderEvent(sliderEntity: updatedSlider));
    
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: commonColor, size: 40),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  MainPage(isAdmin: true,selectedIndex: 0,)),
            ),
          ),
          title: const Text('Update Slider', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: _image == null
                        ? widget.slider.image.isNotEmpty 
                          ? Image.network(widget.slider.image, width: double.infinity, fit: BoxFit.cover)
                          : Icon(Icons.camera_alt, size: 55, color: commonColor)
                        : Image.file(_image!, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _titleController,
                decoration: decorateInput('Title'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _descriptionController,
                decoration: decorateInput('Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OutlinedButton(
                        onPressed: _updateSlider,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: commonColor,
                          side: BorderSide(color: commonColor, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text('UPDATE', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OutlinedButton(
                        onPressed: _clearAllFields,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text('CLEAR', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}