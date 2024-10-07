import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class AddFaqPage extends StatefulWidget {
  @override
  _AddFaqPageState createState() => _AddFaqPageState();
}

class _AddFaqPageState extends State<AddFaqPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController(); 


  void _clearAllFields() {
    setState(() {
      _questionController.clear();
      _answerController.clear();
     
    });
  }

  void _saveTestimony() {
    if (_questionController.text.isEmpty ||
        _answerController.text.isEmpty) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and add at least one feature')),
      );
      return;
    }

    final FaqEntity faqEntity  = FaqEntity(
      id: 0,
     question: _questionController.text.trim(),
     answer: _answerController.text.trim(),
     
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
          title: const Text('Add FAQ', style: TextStyle(color: Colors.black)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              const SizedBox(height: 40),
              TextField(
                controller: _questionController,
                decoration: decorateInput('Question'),
              ),
              const SizedBox(height: 30),
             
              const SizedBox(height: 30),
              TextField(
                controller: _answerController,
                decoration: decorateInput('Answer'),
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
