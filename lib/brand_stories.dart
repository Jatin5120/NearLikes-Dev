// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:nearlikes/instruction_post.dart';
import 'package:scratcher/widgets.dart';
import 'package:nearlikes/models/checkaddedstry.dart';
import 'package:nearlikes/scratch_cards.dart';
import 'package:social_share/social_share.dart';
import 'package:flutter/material.dart';
import 'package:nearlikes/models/get_media.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_share/instagram_share.dart';

import 'constants/constants.dart';
import 'controllers/controllers.dart';

GetMedia? _getMedia;
GetStry? _getStory;
String? customerId;
String? phonenumber;
String? instaPgId;
String? cid;
bool loading1 = false;
bool videoinit = false;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String? mediaType;

class BrandStories extends StatefulWidget {
  final String id; //owner id
  final String brand;
  final String campaignId;
  final String brandMoto;

  const BrandStories({
    Key? key,
    required this.id,
    required this.brand,
    required this.campaignId,
    required this.brandMoto,
  }) : super(key: key);
  @override
  _BrandStoriesState createState() => _BrandStoriesState();
}
//temp long user access token //in future generate from database
//String accesstoken='EAAG9VBauCocBALeqX0Owqm8ZCibZAb2UKe0vTL0VjRvCt7aNbLgab6kGh6AtLinwiWnz33d2A14CUX8ZB2G2BoGLMjQsr3hShBSN0FZBG6H1sQZCPumi2ZBR5R9hX6jVX2ZAl5mraAeZBCTy9a89nEyP9yUpkS4hALD5oYQakkugDTxZBobgH858ZC';

var cashback;
StreamController? _postsController;

Future<GetMedia?> getAvailableMedia({required String id}) async {
  print('inside get media');

  const String apiUrl = "https://nearlikes.com/v1/api/client/get/media";
  var body = {
    "id": id,
  };
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: json.encode(body),
  );

  final String responseString = response.body;
  _getMedia = getMediaFromJson(responseString);
  print('getAvailableMedia --> $responseString');

  return _getMedia;
}

loadPosts(var id) async {
  getAvailableMedia(id: id).then((res) async {
    _postsController!.add(res);
    return res;
  });
}

checkstry(String instapgid) async {
  print('inside checkstry the id is $instapgid');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accesstoken = prefs.getString('token')!;
  print('the access toke is $accesstoken');
  final String api =
      "https://graph.facebook.com/v11.0/$instapgid/stories?fields=media_url,timestamp,caption&access_token=$accesstoken";

  var response = await http.get(Uri.parse(api));
  //print(response.body);
  final String responseString = response.body;
  print('the body of fb story response is ${response.body}');

  try {
    _getStory = getStryFromJson(responseString);
    print('this is checkstry func');
    print('[][][][]');
    print(_getStory!.data![0].id);
    print(_getStory.toString());
    return _getStory;
  } catch (e) {
    print(e.toString());
    return 'error';
  }
}

checkstryId(List stryids, id, campaignId, customerId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userAccId = prefs.getString('user_acc_id')!;
  // String customerId = prefs.getString('customer_id');
  cid = customerId;

  String accesstoken = prefs.getString('token')!;

  print('the access toke is $accesstoken');

  print('customer id is === $customerId');
  print('cameign id $campaignId');
  print('the user_acc_id ${userAccId.toString()}');
  print('the id is $id');
  print('the stryId $stryids');

  const url =
      "https://nearlikes.com/v1/api/client/add/story"; //owner id should exist & campaign_id should exist
  var body = {
    "id": "$campaignId", //campegien id
    "user": accesstoken,
    "story": stryids,
    // "ownerId": "$customerId"//customer id
    "ownerId": "$customerId"
  };
  //  var body=   {
  //   "id": "60fc5e01856fd5b96000aa6f",
  // "story": ["17999262505344919"],
  // "user": "EAAG9VBauCocBALeqX0Owqm8ZCibZAb2UKe0vTL0VjRvCt7aNbLgab6kGh6AtLinwiWnz33d2A14CUX8ZB2G2BoGLMjQsr3hShBSN0FZBG6H1sQZCPumi2ZBR5R9hX6jVX2ZAl5mraAeZBCTy9a89nEyP9yUpkS4hALD5oYQakkugDTxZBobgH858ZC",
  // "ownerId": "610d685f705f995ffd38e109"
  // };
  var response = await http.post(Uri.parse(url),
      body: json.encode(body), headers: {"Content-Type": "application/json"});
  print(response.statusCode);
  print('======');
  print(response.body);

  if (response.statusCode == 200) //update business owners about the stry
  {
    var decoded = json.decode(response.body);

    cashback = decoded['cashback'];
    print('the cashback is $cashback');
    print("..in..business $id");

    String url2 =
        "https://nearlikes.com/v1/api/client/add/association"; //coustmer id should exist
    var body = {
      "id": "$customerId", // id of user while signing in
      "data": "$id" //  owner id from campeign list  whose story is shared
    };
    var response2 = await http.post(Uri.parse(url2),
        body: json.encode(body), headers: {"Content-Type": "application/json"});
    print(response2.body);

    return 200;
  } else {
    return response.statusCode;
  }
}

Future<String?> addStory(String url) async {
  String result = '';
  print('addStory');
  if (mediaType == 'image') {
    var response = await http.get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(join(documentDirectory.path, 'nearlikes.mp4'));
    file.writeAsBytesSync(response.bodyBytes);
    return await SocialShare.shareInstagramStory(file.path);
  } else {
    var response = await http.get(Uri.parse(url));
    var documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(join(documentDirectory.path, 'nearlikes.mp4'));
    file.writeAsBytesSync(response.bodyBytes);
    await InstagramShare.share(file.path, "video").whenComplete(() {
      result = 'success';
    });
    return result;
  }
}

class _BrandStoriesState extends State<BrandStories> {
  static StoryController storyController = Get.find();

  int count = 0;
  var response;
  String caption = '#nearlikes';

  int choice = -1;
  List<String> storyId = [];

  late ConfettiController _controllerTopCenter;
  late List mySelTeams;
  String animationName = "celebrationstart";

  void _playAnimation() {
    setState(() {
      if (animationName == "celebrationstart") {
        animationName = "celebrationstop";
      } else {
        animationName = "celebrationstart";
      }
    });
  }

  getCustomerId(String phonenumber) async {
    var body = {"phone": "+91$phonenumber"};

    final response = await http.post(
      Uri.parse('https://nearlikes.com/v1/api/client/getid'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    setState(() {
      customerId = jsonDecode(response.body);
    });
    print('the response is $customerId');
    //getCustomer(test);
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    customerId = prefs.getString('customer_id');
    phonenumber = prefs.getString('phonenumber');
    setState(() {
      customerId = prefs.getString('customer_id');
      phonenumber = prefs.getString('phonenumber');
    });
    print('the phone number is $phonenumber');
    print('user acc id is $customerId');
    if (customerId == null) {
      print('test');
      getCustomerId(phonenumber!);
    }
    //else getCustomer(customerId);
  }

  getInstaId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phonenumber1 = prefs.getString('phonenumber');
    print('the phonenumber for instaId is $phonenumber1');
    const url = "https://nearlikes.com/v1/api/client/pid";
    var body = {"phone": "+91$phonenumber1"};
    var response = await http.post(Uri.parse(url),
        body: json.encode(body), headers: {"Content-Type": "application/json"});
    print('the instapgid is ${response.body}');
    print(response.statusCode);
    setState(() {
      instaPgId = response.body;
    });
    print("the iddddd is __${instaPgId}__");
  }

  Future<bool> _mockCheckForSession(mediaType) async {
    if (mediaType == 'image') {
      await Future.delayed(const Duration(milliseconds: 8000), () {
        setState(() {
          loading1 = false;
        });
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 15000), () {
        setState(() {
          loading1 = false;
        });
      });
    }
    return true;
  }

  checkMaxStry() async {
    print('inside max check stry');
    print(customerId);
    const url = "https://nearlikes.com/v1/api/client/story/check";
    var body = {"id": "$customerId"};
    var response = await http.post(Uri.parse(url),
        body: json.encode(body), headers: {"Content-Type": "application/json"});
    print('jesus');
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }

  @override
  void initState() {
    print('asasasas');
    print(widget.brand);
    print(widget.id);
    print(widget.campaignId);
    print('................${widget.id}');
    _postsController = StreamController();
    loadPosts(widget.id);
    getUserData();
    getInstaId();

    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter.play();
    getAvailableMedia(id: widget.id);
    // loadPosts(widget.id);

    // _controller = VideoPlayerController.network(
    //     '${_getMedia.media[index].src}')

    _playAnimation();

    super.initState();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // ---------------------- Post Story Button ---------------------------
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        decoration: const BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              offset: Offset(8, 4),
              blurRadius: 20.0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Obx(
          () => Container(
            height: 40,
            width: 185,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: storyController.isStorySelected ? null : Colors.grey,
              gradient: storyController.isStorySelected
                  ? const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [kSecondaryColor, kPrimaryColor],
                    )
                  : null,
              // color: selected == "" ? Colors.grey : null,
              // gradient: selected != ""
              //     ? const LinearGradient(
              //         begin: Alignment.topRight,
              //         end: Alignment.bottomLeft,
              //         colors: [kSecondaryColor, kPrimaryColor],
              //       )
              //     : null,
            ),
            child: InkWell(
              onTap: () async {
                if (storyController.isStorySelected) {
                  storyController.error = '';

                  int statusCode = await checkMaxStry();

                  print('the maxstry is $statusCode');

                  if (statusCode == 200) {
                    return showDialog(
                      context: _scaffoldKey.currentContext!,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(widget.brand),
                          content: Text(
                            '${widget.brandMoto.toString()} \n Note: Add #nearlikes to your story',
                          ),
                          actions: [
                            // Expanded(child: Text('Note: Add #nearlikes to your story',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                            ElevatedButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Ok'),
                              onPressed: () async {
                                setState(() {
                                  loading1 = true;
                                });
                                print(
                                    "Ok pressed --> ${storyController.storyUrl}");
                                String? response =
                                    await addStory(storyController.storyUrl);
                                print('the response is $response');
                                if (response == 'success') {
                                  // setState(() {
                                  //   loading1=false;
                                  // });
                                  //setState(() {loading=true;});
                                  _mockCheckForSession(mediaType).then(
                                    (value) {
                                      return showDialog(
                                        context: _scaffoldKey.currentContext!,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Checking your Story'),
                                            content: const Text(
                                                'Have you posted Instagram Story?'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  print('//b hello //b');
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ElevatedButton(
                                                child: const Text('Yes'),
                                                onPressed: () async {
                                                  setState(() {
                                                    loading1 = true;
                                                  });

                                                  var response =
                                                      await checkstry(
                                                          instaPgId!);
                                                  if (response == 'error') {
                                                    storyController.error =
                                                        'Post Story and Try Again';
                                                    setState(() {
                                                      loading1 = false;
                                                    });
                                                    Navigator.pop(context);
                                                  } else {
                                                    for (var i = 0;
                                                        i <
                                                            _getStory!
                                                                .data!.length;
                                                        i++) {
                                                      try {
                                                        RegExp exp = RegExp(
                                                          caption,
                                                          caseSensitive: false,
                                                        );
                                                        bool containe = exp
                                                            .hasMatch(_getStory!
                                                                .data![i]
                                                                .caption!);
                                                        print('in...');
                                                        if (containe == true) {
                                                          storyId.add(_getStory!
                                                              .data![i].id!);
                                                          // checkstryId(stry_id.toSet().toList(growable: true),widget.campaign_id);
                                                        } else {
                                                          setState(() {
                                                            loading1 = false;
                                                          });
                                                          //Navigator.pop(context);
                                                        }
                                                      } catch (e) {
                                                        // setState((){error='';});
                                                        setState(() {
                                                          loading1 = false;
                                                        });
                                                        //Navigator.pop(context);
                                                      }
                                                      // if(_getStry.data[i].caption==caption){
                                                      //   String id=_getStry.data[i].id;
                                                      //   print(id.toString());
                                                      //   Navigator.pop(context);
                                                      //   Navigator.push(context, MaterialPageRoute(
                                                      //       builder: (context) => ScratchCards()));
                                                      //
                                                      // }
                                                      // else setState(() {error='Post Story with given Instruction';});
                                                    }
                                                  }
                                                  var value = await checkstryId(
                                                      storyId.toSet().toList(
                                                          growable: true),
                                                      widget.id,
                                                      widget.campaignId,
                                                      customerId);
                                                  if (value == 200) {
                                                    print('in dialog');
                                                    setState(() {
                                                      loading1 = false;
                                                    });
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);

                                                    //Navigator.push(context, MaterialPageRoute(builder: (context) =>ScratchCards(phoneNumber:phonenumber  ,)));
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScratchCards(
                                                          cID: cid!,
                                                        ),
                                                      ),
                                                    );
                                                    //return goToDialog();
                                                  } else {
                                                    storyController.error =
                                                        'Please Add Proper Story';
                                                    setState(() {
                                                      loading1 = false;
                                                    });
                                                    // Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    storyController.error = 'Max story limit per day is One';
                    setState(() {
                      loading1 = false;
                    });
                  }
                }
              },
              child: Center(
                child: Text(
                  'Post a story',
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // ---------------------- Post Story Button END ---------------------------
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 0),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40, top: 0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InstructionPost(),
                            ),
                          );
                        },
                        child: const Text(
                          'Help',
                          style: TextStyle(
                            color: kBlackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset('assets/logo.png', width: 46.31, height: 60),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "${widget.brand} BRAND".toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kTextColor[300],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(bottom: 100),
                    height: 700,
                    child: DefaultTabController(
                      initialIndex: 0,
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            unselectedLabelColor: Colors.grey,
                            labelColor: kPrimaryColor,
                            tabs: const [
                              Tab(text: 'Photos'),
                              Tab(text: 'Videos'),
                            ],
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: kSecondaryColor,
                            isScrollable: false,
                            onTap: (index) {
                              storyController.isStorySelected = false;
                            },
                          ),
                          Expanded(
                            //height: 600,

                            // -------------------------- Photos List -------------------------
                            child: TabBarView(
                              children: [
                                FutureBuilder(
                                  future: getAvailableMedia(id: widget.id),
                                  // stream: _postsController.stream,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: _getMedia!.media!.length,
                                      itemBuilder: (_, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              storyController.error = '';
                                              storyController.storyUrl =
                                                  "${_getMedia!.media![index].src}";
                                              storyController.isStorySelected =
                                                  true;
                                              storyController.selectedIndex =
                                                  index;

                                              setState(() {
                                                print(
                                                    "Image OnTap --> ${_getMedia!.media![index].src}");

                                                mediaType =
                                                    "${_getMedia!.media![index].type}";
                                                choice = index;
                                              });
                                            },
                                            child: _getMedia!
                                                        .media![index].type ==
                                                    'image'
                                                ? Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(35, 0, 35, 0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    alignment: Alignment.center,
                                                    child: Obx(
                                                      () => Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: storyController
                                                                        .isStorySelected &&
                                                                    storyController
                                                                            .selectedIndex ==
                                                                        index
                                                                ? kBlackColor
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              "${_getMedia!.media![index].src}",
                                                          progressIndicatorBuilder: (context,
                                                                  url,
                                                                  downloadProgress) =>
                                                              CircularProgressIndicator(
                                                                  value: downloadProgress
                                                                      .progress),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink());
                                      },
                                    );
                                  },
                                ),

                                // -------------------------- Videos List -------------------------
                                FutureBuilder(
                                  future: getAvailableMedia(id: widget.id),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: _getMedia!.media!.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            storyController.storyUrl =
                                                "${_getMedia!.media![index].src}";
                                            storyController.error = '';
                                            setState(() {
                                              print(
                                                  "Video onTap --> ${_getMedia!.media![index].src}");

                                              mediaType =
                                                  "${_getMedia!.media![index].type}";
                                              choice = index;
                                            });
                                          },
                                          child: _getMedia!
                                                      .media![index].type ==
                                                  'video'
                                              ? Obx(
                                                  () => Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 35),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                        color: storyController
                                                                    .isStorySelected &&
                                                                storyController
                                                                        .selectedIndex ==
                                                                    index
                                                            ? kBlackColor
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: VideoWidget(
                                                      index: index,
                                                      play: true,
                                                      url:
                                                          '${_getMedia!.media![index].src}',
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height - 100),
              child: Obx(
                () => Text(
                  storyController.error,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // loading==true?FutureBuilder(
          //      future: checkstry(),
          //      builder: (context, AsyncSnapshot snapshot){
          //        if(!snapshot.hasData){
          //          return Padding(
          //            padding: const EdgeInsets.only(top: 300),
          //            child:  Center(child: Text('post story')),
          //          );
          //        }
          //       else
          //        for(var i=0;i<_getStry.data.length;i++){
          //          print(_getStry.data.length.toString());
          //
          //          if(_getStry.data[i].caption=='#nearlikes'){
          //            String id=_getStry.data[i].id;
          //            //count=count+1;
          //            print(id);
          //            return Padding(
          //              padding: const EdgeInsets.only(top: 300),
          //              child: Center(child: Text('story posted successfully')),
          //            );
          //          }
          //        }
          //        setState(() {
          //          loading==false;
          //        });
          //        return Text('Error');
          //
          //      }):Container(height: 0,)

          loading1 == true
              ? Container(
                  alignment: Alignment.bottomCenter,
                  child: const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.only(bottom: 30),
                )
              : Container(height: 0)
        ],
      ),
    );
  }

  goToDialog() {
    showDialog(
        //barrierColor: Colors.black.withOpacity(0.2),
        context: this.context,
        //barrierDismissible: true,
        builder: (context) => Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    successTicket(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ));
  }

  successTicket() => Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Material(
              clipBehavior: Clip.antiAlias,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _controllerTopCenter.play();
                          },
                          child: Text(
                            "Congratulations!",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: kTextColor[300],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "You have won a scratch card.",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: kTextColor[300],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     print("tapped");
                        //     _controllerTopCenter.play();
                        //   },
                        //   child: Card(
                        //     clipBehavior: Clip.antiAlias,
                        //     elevation: 0.0,
                        //     color: Colors.grey.shade200,
                        //     child: ListTile(
                        //       // leading: SizedBox(
                        //       //   child: Image.asset("assets/trophy.png"),
                        //       // ),
                        //       title: Stack(
                        //         children: <Widget>[
                        //           Text("Scratch your card"),
                        //         ],
                        //       ),
                        //       subtitle: Text("It will appear in your profile section."),
                        //     ),
                        //   ),
                        // ),
                        Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: ConfettiWidget(
                                confettiController: _controllerTopCenter,
                                blastDirection: 0,
                                emissionFrequency: 0.1,
                                numberOfParticles: 90,
                                maxBlastForce: 15,
                                minBlastForce: 9,
                                //  maxBlastForce: 10,
                                //shouldLoop: true,
                                minimumSize: const Size(2,
                                    5), // set the minimum potential size for the confetti (width, height)
                                maximumSize: const Size(10, 10),
                                //colors: [kPrimaryColor,kSecondaryColor,kLightGrey]
                              ),
                            ),
                            Card(
                              elevation: 6.0,
                              //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ScratchCardW(
                                  value: cashback,
                                  docId: "ddd",
                                  uId: "dddd",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}

class ScratchCardW extends StatefulWidget {
  final int value;
  final String docId, uId;
  const ScratchCardW(
      {Key? key, required this.value, required this.docId, required this.uId})
      : super(key: key);

  @override
  _ScratchCardWState createState() => _ScratchCardWState();
}

class _ScratchCardWState extends State<ScratchCardW> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scratcher(
      accuracy: ScratchAccuracy.low,
      threshold: 25,
      brushSize: 50,
      onThreshold: () {
        setState(() {
          _opacity = 1;
        });
      },
      color: Colors.greenAccent.shade700,
      image: Image.asset("assets/scratchcard.png"),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _opacity,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/trophy.png",
                  width: 100,
                  height: 95,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "You've won",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Rs. ${widget.value}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final bool play;
  final String url;
  final int index;

  const VideoWidget({
    Key? key,
    required this.url,
    required this.play,
    required this.index,
  }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  static StoryController storyController = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      //       Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  } // This closing tag was missing

  @override
  void dispose() {
    _controller.dispose();
    //    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () {
              storyController.isStorySelected = true;
              storyController.selectedIndex = widget.index;
              _controller.play();
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                // videoinit==false? Image.network("${_getMedia.media[index].pre}",fit: BoxFit.fitWidth): AspectRatio(
                //   aspectRatio: _controller.value.aspectRatio,
                //   child: VideoPlayer(_controller),
                // ),
                ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
