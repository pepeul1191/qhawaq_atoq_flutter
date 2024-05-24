import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/member_card.dart';
import '../../configs/constants.dart';
import 'about_controller.dart';

class AboutPage extends StatelessWidget {
  AboutController control = Get.put(AboutController());

  Widget _buildBody(BuildContext context) {
    control.listMembers(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 6, right: 6, bottom: 6),
            child: Text(
              'Colaboradres', // Título de la lista
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: control.exercises.value.length,
              itemBuilder: (context, index) {
                // Obtener los detalles de cada tarjeta de la lista de datos
                final member = control.exercises.value[index];
                return MemberCard(
                  imageUrl: member.imageUrl,
                  title: '${member.names} ${member.lastNames}',
                  subtitle: 'Bio',
                  description: member.resume,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: appColor5,
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    ));
  }
}
