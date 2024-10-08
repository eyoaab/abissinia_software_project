import 'package:abissinia_mobile_project/features/faq/bloc/faq_bloc.dart';
import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:abissinia_mobile_project/features/faq/faq-page.dart';
import 'package:abissinia_mobile_project/main.dart';
import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/add-page/add-page.dart';
import 'package:abissinia_mobile_project/features/product/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<FaqBloc>(context).add(UpdateFaqEvent(faqEntity: updatedFaqEntity));

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
              Text('Updating faq...'),
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
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  MainPage(selectedIndex:2,isAdmin: true,)),
            ),
          ),
          title: const Text('Update FAQ', style: TextStyle(color: Colors.black)),
        ),
        body: BlocListener<FaqBloc, FaqState>(
          listener: (context, state) {
            if (state is FaqUpdateLoadingState) {
              _showLoadingDialog();
            } else if (state is UpdateFaqState) {
              _dismissLoadingDialog();
              showCustomSnackBar(context, state.faqModel.responseMessage, state.faqModel.isRight);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage(isAdmin: true,selectedIndex: 2,)),
              );
            } else if (state is FaqErrorState) {
              _dismissLoadingDialog();
              showCustomSnackBar(context, state.message, false);
            }
          },
        
        
        
        
        child: SingleChildScrollView(
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
    ),
    );
  }
}
