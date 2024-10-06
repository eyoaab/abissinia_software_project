import 'package:abissinia_mobile_project/features/faq/faq-entity.dart';
import 'package:flutter/material.dart';

class FaqCard extends StatefulWidget {
  final FaqEntity faq;
  final bool isAdmin;

  const FaqCard({Key? key, required this.faq, required this.isAdmin}) : super(key: key);

  @override
  _FaqCardState createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  Widget _buildHeader() {
    return Text(
      widget.faq.question,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAnswer() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: isExpanded ? _controller.value * 200 : 0, 
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: isExpanded ? Text(
              widget.faq.answer,
              style: const TextStyle(fontSize: 16),
              maxLines: isExpanded ? null : 0,
              overflow: TextOverflow.fade,
            ): const Text(''),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (widget.isAdmin) 
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
            },
          ),
        GestureDetector(
          onTap: _toggleExpansion,
          child: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.green,
            size: 30,
          ),
        ),
        if (widget.isAdmin) 
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 5),
              const Divider(thickness: 1.5, color: Colors.grey),
              _buildAnswer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
