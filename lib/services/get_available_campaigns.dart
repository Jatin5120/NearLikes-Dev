// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nearlikes/models/get_campaigns.dart';

Future<GetCampaigns?> getAvailableCampaigns(
    {int? followers, String? location, int? age}) async {
  late GetCampaigns? _getCampaigns;

  const String apiUrl = "https://nearlikes.com/v1/api/campaign/get/campaigns";
  final Map<String, dynamic> body = {
    "followers": followers,
    "location": "kolkata",
    "age": age
  };
  final http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );
  print("statusCode --> ${response.statusCode}");
  final String responseString = response.body;

  print("Response --> $responseString");
  _getCampaigns = getCampaignsFromJson(responseString);
  return _getCampaigns;
}
