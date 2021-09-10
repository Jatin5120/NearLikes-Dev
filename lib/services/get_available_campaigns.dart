import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nearlikes/models/get_campaigns.dart';

Future<GetCampaigns?> getAvailableCampaigns(
    {int? followers, String? location, int? age}) async {
  print("data..");
  const String apiUrl = "https://nearlikes.com/v1/api/campaign/get/campaigns";
  var body = {"followers": followers, "location": "kolkata", "age": age};
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  print("data");
  print(response.statusCode);
  final String responseString = response.body.toString();

  print(responseString);
  return getCampaignsFromJson(responseString);
}
