import 'dart:io';
import 'package:abissinia_mobile_project/features/product/product-page.dart';
import 'package:abissinia_mobile_project/features/service/bloc/service_bloc.dart';
import 'package:abissinia_mobile_project/features/service/service-detail.dart';
import 'package:abissinia_mobile_project/features/service/srvice-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/service/service-entity.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class UpdateServicePage extends StatefulWidget {
  final ServiceEntity service; 


  const UpdateServicePage({Key? key, required this.service}) : super(key: key);

  @override
  _UpdateServicePageState createState() => _UpdateServicePageState();
}

class _UpdateServicePageState extends State<UpdateServicePage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _timeController;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the existing service data
    _nameController = TextEditingController(text: widget.service.title);
    _priceController = TextEditingController(text: widget.service.pricing.toString());
    _descriptionController = TextEditingController(text: widget.service.description);
    _categoryController = TextEditingController(text: widget.service.category);
    _timeController = TextEditingController(text: widget.service.time);
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

  void _updateService() {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _timeController.text.isEmpty) {
  
      showCustomSnackBar(context, 'Please fill all fields', false);

      return;
    }

    final ServiceSend updatedService = ServiceSend(
      id: widget.service.id,
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      image: _image ?? File(''), 
      price: double.parse(_priceController.text.trim()),
      category: _categoryController.text.trim(),
      time: _timeController.text.trim(),
    );

  BlocProvider.of<ServiceBloc>(context).add(UpdateServiceEvent(serviceSend: updatedService));

  }

  void _clearAllFields() {
    setState(() {
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _categoryController.clear();
      _timeController.clear();
      _image = null;
    });
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
              MaterialPageRoute(builder: (context) =>  ServiceDetailPage(serviceEntity:widget.service, isAdmin: true)),
            ),
          ),
          title: const Text('Update Service', style: TextStyle(color: Colors.black)),
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
                        ? Image.network(widget.service.image, width: double.infinity, fit: BoxFit.cover) 
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
                        onPressed: _updateService,
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
    );
  }
}
