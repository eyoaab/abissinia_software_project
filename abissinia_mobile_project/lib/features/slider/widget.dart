import 'package:abissinia_mobile_project/core/store.dart';
import 'package:abissinia_mobile_project/features/slider/slider-entity.dart';
import 'package:abissinia_mobile_project/features/slider/update-slider-page.dart';
import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  final SliderEntity sliderEntity;
  final bool isAdmin;

  const SliderCard({required this.sliderEntity, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image.network(
                sliderEntity.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isAdmin)
                    IconButton(
                      icon:  Icon(Icons.edit, color: commonColor,size :40),
                      onPressed: () {
                        Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  UpdateSliderPage(slider:sliderEntity)),
            ) ;
                      },
                    ),
                  Expanded(
                    child: Text(
                      sliderEntity.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isAdmin)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red,size :40),
                      onPressed: () {
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
