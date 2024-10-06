import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:abissinia_mobile_project/features/faq/widgets.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final List<FaqEntity> dammyFaq = [
    FaqEntity(id: 1, question: 'Now, if there are', answer: 'Now, if there are no matching faq entries after a search, the user will see a message in the center of the screen indicating that no faqs were found. This enhances the user experience by providing clear feedback.'),
    FaqEntity(id: 1, question: 'Now, if there are', answer: 'Now, if there are no matching faq entries after a search, the user will see a message in the center of the screen indicating that no faqs were found. This enhances the user experience by providing clear feedback.'),
    FaqEntity(id: 1, question: 'Now, if there are', answer: 'Now, if there are no matching faq entries after a search, the user will see a message in the center of the screen indicating that no faqs were found. This enhances the user experience by providing clear feedback.'),
    FaqEntity(id: 1, question: 'Now, if there are', answer: 'Now, if there are no matching faq entries after a search, the user will see a message in the center of the screen indicating that no faqs were found. This enhances the user experience by providing clear feedback.'),
    FaqEntity(id: 1, question: 'Now, if there are', answer: 'Now, if there are no matching faq entries after a search, the user will see a message in the center of the screen indicating that no faqs were found. This enhances the user experience by providing clear feedback.'),
    FaqEntity(id: 1, question: 'Now, if there are', answer: 'Now, if there are no matching faq entries after a search, the user will see a message in the center of the screen indicating that no faqs were found. This enhances the user experience by providing clear feedback.'),

  ];

  List<FaqEntity> filteredfaq = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredfaq = dammyFaq;
  }

  void _filterfaqs(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredfaq = dammyFaq; 
      });
    } else {
      setState(() {
        filteredfaq = dammyFaq.where((faq) {
          return faq.question.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40.0
          
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
                      _filterfaqs(searchQuery);
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
              filteredfaq.isEmpty 
                  ? const Center(
                      child: Text(
                        'No Faqs found',
                        style: TextStyle(color: Colors.grey, fontSize: 20), 
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredfaq.length,
                        itemBuilder: (context, index) {
                          return FaqCard(faq: filteredfaq[index],isAdmin: false,);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
