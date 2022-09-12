

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eveapp/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

import '../components/ui/styles.dart';

class UISCreen extends StatefulWidget {
  const UISCreen({Key? key}) : super(key: key);

  @override
  State<UISCreen> createState() => _UISCreenState();
}

class _UISCreenState extends State<UISCreen> {
  Location currentLocation = Location();
    double? latitude_current;
  double? longitude_current;
  
  
    void getLocation() async{
      ImageConfiguration configuration = ImageConfiguration(size: Size(20,20));
     
    
    var location = await currentLocation.getLocation();
  

        setState(() {
          
          latitude_current = location.latitude;
          longitude_current = location.longitude;
        });
 


  }


   CollectionReference collectionReference =  FirebaseFirestore.instance.collection("addded location");

        double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Nearest EV Charging Stations"),

        ),
                 
      body: Container(
       
        color: Color.fromARGB(255, 183, 223, 255),
        child: SafeArea(

          
                   
          child: Padding(
            
 padding: const EdgeInsets.only(left: 20, top: 100, right: 20,bottom: 25),
             child: Column(
              
                     mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                  // color: Colors.blue,
                  
                  height: 520,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: collectionReference.snapshots(),
                    
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      
                       
                         
                      if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                      }else{
                      
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,

                      itemBuilder: (context, index) {
                      double distance = calculateDistance(latitude_current, longitude_current,double.parse(snapshot.data!.docs[index]["location_details"]["latitude"].toString()) , double.parse(snapshot.data!.docs[index]["location_details"]["longitude"].toString()));
                       
                      return SizedBox(
                        
                        child: Card(
                          
                          child:  Padding(
                            
                          
                            padding: const EdgeInsets.only(left: 20, top: 20, right: 20,bottom: 20),
                            
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Padding(
                                  padding: const EdgeInsets.only(top:.3),
                                  child: ListTile(
                                    horizontalTitleGap:25.0 ,
                                    minVerticalPadding: 15,
                                    onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(latitude: double.parse(snapshot.data!.docs[index]["location_details"]["latitude"].toString()),longitude: double.parse(snapshot.data!.docs[index]["location_details"]["longitude"].toString()) ),) ), // MapScreen(latitude: double.parse(snapshot.data!.docs[index]["location_details"]["latitude"].toString()),longitude: double.parse(snapshot.data!.docs[index]["location_details"]["latitude"].toString()) ),
                                    title:Text(snapshot.data!.docs[index]["adress_details"]["Name"],style:Styles().style2()) ,
                                    
                                    // title: Text(snapshot.data!.docs[index].data().toString()),s
                                    subtitle:Text('Distance: ${distance.toStringAsPrecision(2)} km',style:Styles().style3()) ,
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      
                    },);
                      }
                  },),
            ),
               ],
             ),
          ),
        ),
      ),
    );
    
  }
}