import 'package:flutter/material.dart';
import 'package:qhawaq_atoq/configs/constants.dart';

class MemberCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;

  const MemberCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        color: Colors.white70,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Image.network(
                  '${BASE_URL}${imageUrl}',
                  height: 75,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(description,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Agrega puntos suspensivos al final si el texto es demasiado largo
                        maxLines: 8),
                  ],
                )),
              ],
            )) // Contenido del Container
        );
  }
}
