import 'dart:io';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:abissinia_mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/service/bloc/service_bloc.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

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

  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Container(
            width: 300,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: commonColor),
                const SizedBox(width: 16),
                Expanded(child: Text(message, textAlign: TextAlign.center)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _clearAllFields() {
    setState(() {
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _categoryController.clear();
      _image = null;
      _timeController.clear();
    });
  }

  void _saveService() {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _image == null ||
        _timeController.text.isEmpty ||
        _categoryController.text.isEmpty) {
      showCustomSnackBar(context, 'Please fill all fields', false);
      return;
    }

    final ServiceSend serviceSend = ServiceSend(
      id: 0,
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      image: _image!,
      price: double.parse(_priceController.text.trim()),
      category: _categoryController.text.trim(),
      time: _timeController.text.trim(),
    );

    context.read<ServiceBloc>().add(AddServiceEvent(serviceSend: serviceSend));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceAddLoadingState) {
            _showLoadingDialog('Adding Service...');
          } else if (state is AddServiceState) {
            Navigator.of(context).pop(); 
            showCustomSnackBar(context, state.serviceModel.responseMessage, state.serviceModel.isRight);
            _clearAllFields();
          } else if (state is ServiceErrorState) {
            Navigator.of(context).pop(); 
            showCustomSnackBar(context, state.message, false);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.chevron_left, color: commonColor, size: 40),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(
                          isAdmin: true,
                          selectedIndex: 4,
                        )),
              ),
            ),
            title: const Text('Add Service', style: TextStyle(color: Colors.black)),
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
                          ? Icon(Icons.camera_alt, size: 55, color: commonColor)
                          : Image.file(_image!, width: double.infinity, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _nameController,
                  decoration: decorateInput('Title'),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _priceController,
                  decoration: decorateInput('Price'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _descriptionController,
                  decoration: decorateInput('Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _categoryController,
                  decoration: decorateInput('Category'),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _timeController,
                  decoration: decorateInput('Time Needed'),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: OutlinedButton(
                          onPressed: _saveService,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: commonColor,
                            side: BorderSide(color: commonColor, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: const Text('ADD', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 10),
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
      ),
    );
  }
}
