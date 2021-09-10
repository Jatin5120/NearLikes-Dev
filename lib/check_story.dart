import 'package:flutter/material.dart';

class CheckStory extends StatefulWidget {
  const CheckStory({Key? key}) : super(key: key);

  @override
  _CheckStoryState createState() => _CheckStoryState();
}

class _CheckStoryState extends State<CheckStory> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          loading == true
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        const Text('Checking your instagram story'),
                        const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          // color: Colors.black,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loading = false;
                            });
                          },
                          child: const Text('checking done'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const Text('checking done!!'),
        ],
      ),
    );
  }
}
