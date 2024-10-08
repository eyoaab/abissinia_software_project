import 'package:abissinia_mobile_project/features/service/srvice-page.dart';
import 'package:abissinia_mobile_project/features/testimoney/bloc/testimony_bloc.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
       BlocProvider.of<TestimonyBloc>(context).add(UpdateTestimonyEvent(testimonyEntity: updatedTestimonyEntity));

  }
    void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text('Updating Testimony...'),
            ],
          ),
        );
      },
    );
  }
    void _dismissLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
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
            onPressed: () =>   Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  const ServicePage()),
            ),
          ),
          title: const Text('Update Testimony', style: TextStyle(color: Colors.black)),
        ),
         body: BlocListener<TestimonyBloc, TestimonyState>(
          listener: (context, state) {
            if (state is TestimonyUpdateLoadingState) {
              _showLoadingDialog();
            } else if (state is UpdateTestimonyState) {
              _dismissLoadingDialog();
              showCustomSnackBar(context, state.testimonyModel.responseMessage, state.testimonyModel.isRight);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ServicePage()),
              );
            } else if (state is TestimonyErrorState) {
              _dismissLoadingDialog();
              showCustomSnackBar(context, state.message, false);
            }
          },
        
        child:SingleChildScrollView(
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
    ),
    );
  }
}
