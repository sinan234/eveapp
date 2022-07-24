

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPopUP extends StatefulWidget {
  // const DetailsPopUP({Key? key}) : super(key: key);
  String name;
  String adress_details;
  String operational_status;
  String working_hours;
  String number_of_ports;
  String connectionType;
  String charger_availability;
  String charging_level;
  DetailsPopUP({required this.name,
  required this.adress_details,
  required this.operational_status,
  required this.working_hours,
  required this.number_of_ports,
  required this.connectionType,
  required this.charger_availability,
  required this.charging_level
   });

  @override
  State<DetailsPopUP> createState() => _DetailsPopUPState();
}

class _DetailsPopUPState extends State<DetailsPopUP> {

  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50,bottom: 50),
      
      child: Card(
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              
              
              width: double.infinity,
              height: double.infinity,
              
      
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Container(
                    
                    child: Column(
                     
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        Card(
                        margin: EdgeInsets.all(0),
                        child: Container(
                        height: 120,
                        width: double.infinity,
                        color: Color.fromARGB(255, 187, 225, 255),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
                              child: Text(widget.name.toUpperCase(), style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 27, 53)  , overflow: TextOverflow.ellipsis),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                            
                              children: [
                                Icon(Icons.location_on_outlined, color: Color.fromARGB(255, 0, 55, 107) ,),
                                Text(widget.adress_details.toUpperCase(), style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 55, 107) , overflow: TextOverflow.ellipsis),),
                              ],
                            ),
                          ],
                            ),
                             )
                           ),
                    
                        Container(
                          padding: const EdgeInsets.only(left:13),
                          child: Column(
                            
                              crossAxisAlignment: CrossAxisAlignment.end,
                            children: [ 
                             
                              Divider(),
                    
                              
                              rowWidget("OPERATIONAL STATUS:",widget.operational_status, Icons.settings),
                              Divider(),
                    
                              rowWidget("WORKING HOURS: ", widget.working_hours,Icons.timelapse_outlined),
                    
                              Divider(),
                    
                              rowWidget("NUMBER OF PORTS: ", widget.number_of_ports,Icons.account_tree_rounded),
                              Divider(),
                    
                              rowWidget("CONNECTION:", widget.connectionType,Icons.construction_outlined),
                              Divider(),
                    
                              rowWidget("CHARGER AVAILABILITY: ", widget.charger_availability,Icons.power_outlined),
                              Divider(),
                    
                              rowWidget("CHARGING PRICE: ", widget.charging_level,Icons.currency_rupee_rounded),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ElevatedButton.icon(onPressed: (){_launchUrl();}, icon: Icon(Icons.rate_review_outlined), label: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text ("REVIEW", style: TextStyle(fontWeight: FontWeight.bold),),
                                )),
                                                             )
                            ],
                          ),
                        ),
                        
                    
                              
                        
                       
                      ],
                      
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
      
        ),
      ),
    );
  }

  Widget rowWidget(String name ,String parameter, IconData icon){
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(icon,color: Color.fromARGB(255, 112, 112, 112) , size: 22,),
                            ),
                        Text(name, style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 82, 82, 82),fontFamily: 'Open Sans', fontWeight: FontWeight.bold)),
                          ],
                        ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                           child: Text(parameter.toUpperCase(), style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 116, 116, 116),fontFamily: 'Open Sans',fontWeight: FontWeight.bold),),
                         )
                      ],
                    ),
      ),
    );
  }
  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSeHjm2GjFBF0jvNOIZoWCi1ShwMPj1LvKrZYkGK5_UH-o_xCw/viewform?usp=pp_url&entry.1035775763=${widget.name}&entry.1744541650=${widget.adress_details}');
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
}