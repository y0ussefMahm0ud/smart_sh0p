// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/title_text.dart';

class Privacy extends StatelessWidget {
  static const routName = '/Privacy';
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            period: const Duration(seconds: 16),
            baseColor: Colors.purple,
            highlightColor: Colors.red,
            child: const TitlesTextWidget(
              label: "Privacy Policy for smart_sh0p",
            ),
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Last updated: July 23, 2023',
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Text(
                  'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                  style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 10,
              ),
              Text(
                  'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.',
                  style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 20,
              ),
              Text(
                'Interpretation and Definitions',
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Interpretation',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                  style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 10,
              ),
              Text(
                'Definitions',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text('For the purposes of this Privacy Policy:',
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              // ignore: prefer_adjacent_string_concatenation
              Text(
                ' Account means a unique account created for You to access our Service or parts of our Service.' +
                    ' Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election' +
                    " Application refers to smart_sh0p, the software program provided by the Company." +
                    " Country refers to: Egypt" +
                    " Service refers to the Application",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 30,
              ),
               Text('Contact Us',
                  style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 15,
              ),
               Text('If you have any questions about this Privacy Policy, You can contact us:',
                  style: TextStyle(fontSize: 15)),
                 SizedBox(
                height: 15,
              ),
                 Text('By email: ym793875@gmail.com',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ));
  }
}
