import 'dart:io';
import 'package:abissinia_mobile_project/features/product/bloc/product_bloc.dart';
import 'package:abissinia_mobile_project/features/product/product-detail-page.dart';
import 'package:abissinia_mobile_project/features/product/product-page.dart';
import 'package:abissinia_mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/product/product-entity.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductEntity productEntity; 

  const UpdateProductPage({Key? key, required this.productEntity}) : super(key: key);

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _featureController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  List<String> _features = [];

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.productEntity.title;
    _priceController.text = widget.productEntity.pricing.toString();
    _descriptionController.text = widget.productEntity.description;
    _features = widget.productEntity.features;
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
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _featureController.clear();
      _image = null;
      _features.clear();
    });
  }

  void _updateProduct() {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        (_image == null && widget.productEntity.image.isEmpty) ||
        _features.isEmpty) {
      
      showCustomSnackBar(context, 'Please fill all fields ', false);

      
      return;
    }

    final ProductSend updatedProduct = ProductSend(
      id: widget.productEntity.id,
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      image: _image ?? File(widget.productEntity.image), 
      price: double.parse(_priceController.text.trim()),
      features: _features,
    );
    BlocProvider.of<ProductBloc>(context).add(UpdateProductEvent(productEntity: updatedProduct));

  }

  void _addFeature() {
    if (_featureController.text.isNotEmpty) {
      setState(() {
        _features.add(_featureController.text.trim());
        _featureController.clear();
      });
    }
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
              MaterialPageRoute(builder: (context) => ProductDetailPage(productEntity: widget.productEntity, isAdmin: true)),
            ),
          ),
          title: const Text('Update Product', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
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
                        ? Image.network(widget.productEntity.image, width: double.infinity, fit: BoxFit.cover)
                        : Image.file(_image!, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: decorateInput('Title'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: decorateInput('Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: decorateInput('Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _featureController,
                      decoration: decorateInput('Feature'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: commonColor),
                    onPressed: _addFeature,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: OutlinedButton(
                        onPressed: _updateProduct,
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
