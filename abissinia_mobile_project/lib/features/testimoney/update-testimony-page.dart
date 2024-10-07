import 'package:abissinia_mobile_project/features/service/srvice-page.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class UpdateTestimonyPage extends StatefulWidget {
  final TestimonyEntity testimonyEntity;

  const UpdateTestimonyPage({Key? key, required this.testimonyEntity}) : super(key: key);

  @override
  _UpdateTestimonyPageState createState() => _UpdateTestimonyPageState();
}

class _UpdateTestimonyPageState extends State<UpdateTestimonyPage> {
  late TextEditingController _serviceController;
  late TextEditingController _companyController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the existing testimony data
    _serviceController = TextEditingController(text: widget.testimonyEntity.service);
    _companyController = TextEditingController(text: widget.testimonyEntity.company);
    _descriptionController = TextEditingController(text: widget.testimonyEntity.description);
  }

  void _clearAllFields() {
    setState(() {
      _serviceController.clear();
      _companyController.clear();
      _descriptionController.clear();
    });
  }

  void _updateTestimony() {
    if (_serviceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _companyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final updatedTestimonyEntity = TestimonyEntity(
      id: widget.testimonyEntity.id,
      service: _serviceController.text.trim(),
      company: _companyController.text.trim(),
      description: _descriptionController.text.trim(),
    );
    _clearAllFields();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: commonColor, size: 40),
            onPressed: () =>   Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  const ServicePage()),
            ),
          ),
          title: const Text('Update Testimony', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              TextField(
                controller: _serviceController,
                decoration: decorateInput('Service'),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _companyController,
                decoration: decorateInput('Company'),
              ),
              const SizedBox(height: 30),
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
                        onPressed: _updateTestimony,
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
                    const SizedBox(height: 20),
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
