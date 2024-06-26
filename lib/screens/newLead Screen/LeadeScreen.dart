import 'package:flutter/material.dart';
import 'package:leadkart/component/HelpButtonWhite.dart';
import 'package:leadkart/component/leadeTile.dart';
import 'package:leadkart/helper/dimention.dart';
import 'package:leadkart/helper/helper.dart';
import 'package:leadkart/my%20custom%20assets%20dart%20file/myast%20dart%20file.dart';
import 'package:leadkart/screens/leads/getNewLeads.dart';
import 'package:leadkart/screens/newLead%20Screen/assign_Leads.dart';

import '../../component/helpButton.dart';




class LeadeScreen extends StatefulWidget {
  const LeadeScreen({super.key});

  @override
  State<LeadeScreen> createState() => _LeadeScreenState();
}

class _LeadeScreenState extends State<LeadeScreen> {

  List<String> filters = ["All","Pending","In-progress","follow on interested"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //AppBar
      appBar: AppBar(

        //titel
        title: Text("Leads"),

        actions: [

          //help Button
          HelpButton(title: "Search?",),
          SizedBox(width: 10,),
        ],
      ),


      //Body OF Screen
      body: ListView(
        padding: EdgeInsets.only(top: 20,bottom: 10),
        children: [
          
          //titelButtons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: MyHelper.appConstent.horizontalPedding,
              child: Row(
                children: [
                  for(String i in filters)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: OutlinedButton(onPressed: (){}, child: Text(i,
                      
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: SC.from_width(16),color:Colors.grey.shade700))),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: SC.fromHeight(70),),

          //Loop For Leads
          for(int i =0;i<12;i++)
            LeadeTile(onTap: (){RouteTo(context, child:(a,b) =>AssaignLeads());},)
        ],
      ),

    );
  }
}
