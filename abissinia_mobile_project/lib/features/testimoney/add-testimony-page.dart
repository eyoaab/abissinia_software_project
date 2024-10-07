import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class AddTestimonyPage extends StatefulWidget {
  @override
  _AddTestimonyPageState createState() => _AddTestimonyPageState();
}

class _AddTestimonyPageState extends State<AddTestimonyPage> {
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _campanyController = TextEditingController(); 
  final TextEditingController _descriptionController = TextEditingController();


  void _clearAllFields() {
    setState(() {
      _serviceController.clear();
      _descriptionController.clear();
      _campanyController.clear(); 
    });
  }

  void _saveTestimony() {
    if (_serviceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _campanyController.text.isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and add at least one feature')),
      );
      return;
    }

    final TestimonyEntity testimonyEntity  = TestimonyEntity(
      id: 0,
     service: _serviceController.text.trim(),
     company: _campanyController.text.trim(),
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
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            ),
          ),
          title: const Text('Add Testimony', style: TextStyle(color: Colors.black)),
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
                controller: _campanyController,
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
                        onPressed: _saveTestimony,
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
