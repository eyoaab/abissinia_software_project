import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:abissinia_mobile_project/features/faq/faq-page.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';

class UpdateFaqPage extends StatefulWidget {
  final FaqEntity faqEntity; 

  UpdateFaqPage({required this.faqEntity}); 

  @override
  _UpdateFaqPageState createState() => _UpdateFaqPageState();
}

class _UpdateFaqPageState extends State<UpdateFaqPage> {
  late final TextEditingController _questionController;
  late final TextEditingController _answerController; 

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.faqEntity.question);
    _answerController = TextEditingController(text: widget.faqEntity.answer);
  }

  void _clearAllFields() {
    setState(() {
      _questionController.clear();
      _answerController.clear();
    });
  }

  void _saveFaq() {
    if (_questionController.text.isEmpty || _answerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final FaqEntity updatedFaqEntity = FaqEntity(
      id: widget.faqEntity.id, 
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
              MaterialPageRoute(builder: (context) => const FaqPage()),
            ),
          ),
          title: const Text('Update FAQ', style: TextStyle(color: Colors.black)),
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
                        onPressed: _saveFaq,
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
