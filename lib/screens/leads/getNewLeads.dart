import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leadkart/business_pages/growBusinessFaster.dart';
import 'package:leadkart/component/select_plan_widget.dart';
import 'package:leadkart/helper/helper.dart';
import 'package:leadkart/them/constents.dart';

import '../../component/helpButton.dart';
import '../../helper/dimention.dart';

class GetNewLeads extends StatelessWidget {
  const GetNewLeads({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyHelper.appConstent.primeryColor,
        foregroundColor: Colors.white,
        title: const Text('Get New Leads'),
 
        actions: [  Padding(
          padding: const EdgeInsets.all(8.0),
          child: HelpButton(),
        )],
 
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const InfoCard(
                    title: 'Get new customers using Leads :',
                    subTitle:
                    ' Generate daily new leads by showing your ads to potential customers in target area.',
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Total Budget",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SC.from_width(10),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      BudgetSelecter(
                        icon: 'assets/facebook_wbg.png',
                        budget:'2000',
                      ),

                    ],
                  ),
                  SizedBox(
                    height: SC.from_width(10),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      BudgetSelecter(
                        icon: 'assets/instagram_wbg.png',
                        budget:'2000',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SC.fromContextWidth(context, 20),
                  ),
                  Text("OR"),
                  SizedBox(
                    height: SC.fromContextWidth(context, 20),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select a Plan",style: Theme.of(context).textTheme.displayMedium,),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  LeadSelecter(),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Package includes",style: Theme.of(context).textTheme.displayMedium,),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                   ConstrainedBox(
                     // height:200,
                     constraints: BoxConstraints(
                         maxHeight: 200,
                         minHeight: 200,
                       ),
                     child: PackageCards(),
                   ),
                  SizedBox(
                    height: 5,
                  ),
                  ExtimateResultCard(),
SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Package Frequently asked Questions",style: Theme.of(context).textTheme.displayMedium,),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, // Prevent excessive scrolling
                    physics: const NeverScrollableScrollPhysics(), // Disable scrolling if needed
                    itemCount: 10,
                    itemBuilder: (context, index) {

                      return ExpansionTile(
                        title: Text('Where will my ad be shown?'),
                        children: [
                          ListTile(
                            title: Text('No where!'),
                          ),
                        ],
                      );
                    },


        ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed('imageEditor');
                  },
                  child: Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LeadSelecter extends StatefulWidget {

  const LeadSelecter({super.key});

  @override
  State<LeadSelecter> createState() => _LeadSelecterState();
}

class _LeadSelecterState extends State<LeadSelecter> {
  final List<Map<String, dynamic>> containerData =  [
    {
      'isRecommendation': true,
      'duration': '30 days',
      'price': 2000.0, // Ensure this is a double
      'leads': 200,
      'reach': 50000,
      'platforms': [
        'assets/facebook.png',
        'assets/add_images/insta.png',
      ],
      'aiImages': 5,
    },    {
      'isRecommendation': false,
      'duration': '30 days',
      'price': 2000.0, // Ensure this is a double
      'leads': 200,
      'reach': 50000,
      'platforms': [
        'assets/facebook.png',
        'assets/add_images/insta.png',
      ],
      'aiImages': 5,
    },
    // Add more containers as needed
  ];
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return                       Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: containerData.length,
        itemBuilder: (context, index) {
          final data = containerData[index];
          return CustomContainerWidget(
            isRecommendation: data['isRecommendation'],
            duration: data['duration'],
            price: data['price'], // Ensure this is a double
            index: index,
            selectedValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
            leads: data['leads'],
            reach: data['reach'],
            platforms: data['platforms'],
            aiImages: data['aiImages'],
          );
        },
      ),
    )
    ;
  }
}

class PackageCards extends StatelessWidget {
  const PackageCards({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardData =  [
      {
        'image':"assets/add_images/img_3.png",
        'title':"AI Images",
        'desc':"Our AI generative tool will create images for your business"
      },
      {
        'image':"assets/add_images/img_3.png",
        'title':"AI Content",
        'desc':"Our AI tool will generate tittle, call to action and suggested audience."
      }
      // Add more containers as needed
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: cardData.length,
        itemBuilder: (context,index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,

              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 5,
                  ),
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("${cardData[index]['image']}", width: 40,),
                    Text("${cardData[index]['title']}", style:MyHelper.textStyls.greenMediumText),
                    Flexible(child: Text("${cardData[index]['desc']}", style:MyHelper.textStyls.leadTileSubTitle))
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}


class BudgetSelecter extends StatefulWidget {
  String icon;
  String budget;
  BudgetSelecter({super.key, required this.icon, required this.budget});

  @override
  State<BudgetSelecter> createState() => _BudgetSelecterState();
}

class _BudgetSelecterState extends State<BudgetSelecter> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: SC.fromContextWidth(context, 1.25),
        decoration: BoxDecoration(
          border: Border.all(color:Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 0, vertical: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration:  BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.grey))),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Image.asset(
                  widget.icon,
                  height: SC.from_width(20),
                )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.budget,style: Theme.of(context).textTheme.displaySmall,),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: SC.from_width(27),
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            widget.budget= (int.parse(widget.budget)-1).toString();
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                            child: Image.asset(
                              'assets/minus.png',
                              width: SC.from_width(15),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.budget= (int.parse(widget.budget)+1).toString();
                          });
                        },
                        child: Container(
                          decoration:  BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                              border: Border(
                                  left: BorderSide(color: Colors.grey))),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/add.png',
                                  width: SC.from_width(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class InfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  const InfoCard({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: MyHelper.appConstent.infoContainerColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: SC.from_width(10), vertical: SC.from_width(10)),
          // margin: EdgeInsets.symmetric(vertical: SC.from_width(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded, color: Colors.black,),
              SizedBox(
                width: SC.from_width(10),
              ),
              Flexible(
                child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: title,
                          style: Theme.of(context).textTheme.displayMedium),
                      TextSpan(
                          text: subTitle,
                          style: Theme.of(context).textTheme.displaySmall),
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



