import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eveapp/screens/login.dart';
import 'package:eveapp/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
 
 
 
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}
 
class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};
  bool isuserloggined = true;


 
 
  void getLocation() async{
            
    
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){
 
      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(markerId: const MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
       });
  }
      void getRegisteredChargingStations()async{
    QuerySnapshot<Map<String, dynamic>> collectionReference = await FirebaseFirestore.instance.collection("addded location").get();
    collectionReference.docs.forEach((element) {
      print(element.data());
      setState(() {
        _markers.add(Marker(markerId: MarkerId(element.id),position: LatLng(element.data().entries.elementAt(2).value["latitude"], element.data().entries.elementAt(2).value["longitude"]), infoWindow:  InfoWindow( //popup info 
          title: element.data().entries.elementAt(3).value["Name"],
          snippet: 'EV Charging Station',
        ), ));G
      });
    });
   

  }

//   {equipment_details: {charging_level: b, charger_availability: a, connectionType: a}, charging_details: {usage_type:
// a, working_hours: a, number_of_ports: a, operator: a, status: a}, location_details: {latitude: 11.8354111, longitude: 75.9692691}, adress_details:{country: a, pincode: a, phoneNumber: a, city_town: a, AdressLine: a, state: a, landmark: a, Name: a}}
// [   +8 ms] I/flutter (17186): {charging_details: {usage_type:   h, working_hours: b, number_of_ports: b, operator: b, status: b},
// equipment_details: {charging_level: f, charger_availability: f, connectionType:  f}, location_details: {latitude: 11.8354529, longitude:
// 75.9692461}, adress_details: {pincode: b, country: n, phoneNumber: b, city_town: b, AdressLine:  b, state: b, landmark: n, Name:  b}}
 
  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
      getRegisteredChargingStations();
    });
  }

  

 
  @override
  Widget build(BuildContext context) {
    // if(FirebaseAuth.instance.currentUser!.uid.isNotEmpty ){
    //   setState(() {
    //     isuserloggined == true;
    //   });
    // }
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
           child: Column(
            children: [
              GestureDetector(
                onTap: (() => Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),))),
                child: const Padding(padding:EdgeInsets.symmetric(vertical: 60),
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Report new Charger ", style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue,backgroundColor: Colors.white)),
                    ),
                  ) ,
                ),
                ),
              )
            ],
           ),
        ),
        appBar: AppBar(
          title: const Text("eve"),
          actions: [
            Column(
            children: [
              isuserloggined?ElevatedButton.icon(onPressed:() {
                
              }, icon: Icon(Icons.logout_outlined), label: Text("Logout")):Container()
            ],
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:GoogleMap(
           
            zoomControlsEnabled: false,
            initialCameraPosition:const CameraPosition(
              target: const LatLng(11.6854, 76.1320),
              zoom: 10.0,
            ),
            onMapCreated: (GoogleMapController controller){
              _controller = controller;
            },
            markers: _markers,
          ) ,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_searching,color: Colors.white,),
          onPressed: (){
            if (Permission.location.isGranted == false){
              Permission.location.request();
              
            }else{
    print(Permission.location.isGranted);
            getLocation();
            }
          },
        ),
      ),
    );
  }
  void firebase_logout()async{
    FirebaseAuth.instance.signOut();
  }
  
}
