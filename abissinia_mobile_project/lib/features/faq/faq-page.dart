import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/faq/bloc/faq_bloc.dart';
import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:abissinia_mobile_project/features/faq/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
      context.read<FaqBloc>().add(LoadAllFaqEvent());
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.12), 
          child: Container(
            color: Colors.green,
            child: const Column(
              children: [
              Icon(Icons.question_mark,size:40,color: Color.fromARGB(255, 225, 220, 220),),
                SizedBox(height: 8), 
                Text(
                  'How Can we help you?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: commonSerchDecoration,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8), 
                  const Icon(
                    Icons.menu,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 16),            
 Expanded(
                      child:BlocListener<FaqBloc, FaqState>(
                  listener: (context, state) {
                    if (state is DeleteFaqState) {
                      showCustomSnackBar(
                        context,
                        state.faqModel.responseMessage,
                        state.faqModel.isRight,
                      );
                       context.read<FaqBloc>().add(LoadAllFaqEvent());
                    }
                  },
                  child: BlocBuilder<FaqBloc, FaqState>(
                    builder: (context, state) {
                      if (state is FaqLoadingState) {
                        return  Center(
                          child: CircularProgressIndicator(color: commonColor),
                        );
                      } else if (state is FaqLoadedState) {
                        List<FaqEntity> filteredFaqs = state.loadedFaqs
                            .where((faq) =>
                                faq.question.toLowerCase().contains(searchQuery.toLowerCase()))
                            .toList();

                        if (filteredFaqs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No Faqs available',
                              style: TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: filteredFaqs.length,
                          itemBuilder: (context, index) {
                            return FaqCard(
                              faq: filteredFaqs[index],
                              isAdmin: true,
                            );
                          },
                        );
                      } else if (state is FaqErrorState) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        );
                      }

                      return const Center(
                        child: Text('No Faqs available'),
                      );
                    },
                  )
                    ),
 )
            ],
          ),
        ),
      ),
    );
  }
}
