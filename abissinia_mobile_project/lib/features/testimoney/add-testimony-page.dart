import 'package:abissinia_mobile_project/features/testimoney/bloc/testimony_bloc.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
               CircularProgressIndicator(color: commonColor,),
              const SizedBox(width: 16),
              Expanded(child: Text(message, textAlign: TextAlign.center)), 
            ],
          ),
        ),
      );
    },
  );
}

  void _saveTestimony() {
    if (_serviceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _campanyController.text.isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final TestimonyEntity testimonyEntity  = TestimonyEntity(
      id: 0,
     service: _serviceController.text.trim(),
     company: _campanyController.text.trim(),
      description: _descriptionController.text.trim(),
     
    );

      BlocProvider.of<TestimonyBloc>(context).add(AddTestimonyEvent(testimonyEntity: testimonyEntity));

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
        body: BlocListener<TestimonyBloc, TestimonyState>(
          listener: (context, state) {
            if (state is TestimonyAddLoadingState) {
              _showLoadingDialog('Creating a Testimony');
               
            }

            if (state is AddTestimonyState) {
              Navigator.pop(context); 
              showCustomSnackBar(context, state.testimonyModel.responseMessage, state.testimonyModel.isRight);
              _clearAllFields();
            }

            if (state is TestimonyErrorState) {
              Navigator.pop(context);
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
      ),),
    );
  }
}
