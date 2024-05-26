import 'dart:convert';
import '../models/entities/member.dart';
import '../configs/constants.dart';
import 'package:http/http.dart' as http;
import '../configs/http_api_exception.dart';

class MemberService {
  Future<List<Member>> fetchAll() async {
    String url = "${BASE_URL}member/list";
    print(url);
    List<Member> members = [];
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> parsedData = json.decode(response.body);
      members =
          parsedData.map((memberJson) => Member.fromJson(memberJson)).toList();
      return members;
    } else {
      throw HttpApiException(response.statusCode, response.body);
    }
  }
}
