import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/http_api_exception.dart';
import '../../models/entities/member.dart';
import '../../services/member_service.dart';

class AboutController extends GetxController {
  RxList<Member> exercises = <Member>[].obs;

  Future<void> listMembers(BuildContext context) async {
    MemberService service = MemberService();
    try {
      service.fetchAll().then((list) {
        exercises.value = list;
      });
    } catch (e) {
      print(e);
      if (e is SocketException) {
        Get.snackbar('Error de comunicación con el servidor',
            'Probablemente esté no se encuentre disponbile');
      } else if (e is HttpApiException) {
        Get.snackbar('Respuesta HTTP con errores', e.toString());
      } else {
        Get.snackbar('Error no esperado', e.toString());
      }
    }
  }
}
