import 'package:flutter/material.dart';

import '../root_screen.dart';
import 'subtitle_text.dart';
import 'title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText});
  final String imagePath, title, subtitle, buttonText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const TitlesTextWidget(
              label: "Whoops",
              fontSize: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
            SubtitleTextWidget(
              label: title,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubtitleTextWidget(
                label: subtitle,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 125, 119, 119),
                                        padding: const EdgeInsets.all(12),
                                        // backgroundColor:
                                        // Theme.of(context).colorScheme.background,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ), onPressed: () { 
                                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RootScreen()),
            );
                                       },
                                      child:   const Text("sh0p n0w",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                        )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
