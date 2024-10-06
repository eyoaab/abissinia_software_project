import 'package:flutter/material.dart';
import 'package:abissinia_mobile_project/features/testimoney/testimony-entity.dart';

class TestimonialCard extends StatelessWidget {
  final TestimonyEntity testimonyEntity;
  final bool isAdmin;

  const TestimonialCard({
    Key? key,
    required this.testimonyEntity,
    required this.isAdmin, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              testimonyEntity.service,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 30, 194, 1),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              testimonyEntity.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  testimonyEntity.company,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Wrap(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isAdmin)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit,size:30),
                    color: Colors.blue,
                    onPressed: () {
                      
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete,size:30),
                    color: Colors.red,
                    onPressed: () {
                    
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
