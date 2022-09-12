

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eveapp/components/details_pop_up.dart';
import 'package:eveapp/components/ui/styles.dart';
import 'package:eveapp/screens/details.dart';
import 'package:eveapp/screens/login.dart';
import 'package:eveapp/screens/panel_widget.dart';
import 'package:eveapp/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:sliding_up_panel/sliding_up_panel.dart';
 
 
 
class MapScreen extends StatefulWidget {
  double latitude;
  
  double longitude;

  MapScreen({required this.latitude, required this.longitude});



  @override
  _MapScreenState createState() => _MapScreenState();
}
 
class _MapScreenState extends State<MapScreen> {
 // PanelController _pc = new PanelController();
// @override
//      Widget build(BuildContext context){
//       return Scaffold(
//         body:SlidingUpPanel(
//         body:MapScreen(),
//         panelBuilder: (controller) => PanelWidget(
//         controller:controller,
//         ),
//         ),
//     );
// }








  GoogleMapController? _controller;
  Location currentLocation = Location();
  double? latitude_current;
  double? longitude_current;
  Set<Marker> _markers={};
  bool isuserloggined = true;


 
 
  void getLocation() async{
      ImageConfiguration configuration = ImageConfiguration(size: Size(20,20));
      BitmapDescriptor  descriptor = await BitmapDescriptor.fromAssetImage(configuration, "assets/images/marker.png");
    
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){

 
      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 13.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        latitude_current = loc.latitude;
        longitude_current = loc.longitude;
        _markers.add(Marker(markerId: const MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
            icon: descriptor
        ));
      });
       });
  }
      void getRegisteredChargingStations()async{

        ImageConfiguration configuration = ImageConfiguration(size: Size(2,2));
      BitmapDescriptor  descriptor = await BitmapDescriptor.fromAssetImage(configuration, "assets/images/map.png");
      var newLocation = await currentLocation.getLocation();

        
    QuerySnapshot<Map<String, dynamic>> collectionReference = await FirebaseFirestore.instance.collection("addded location").get();
    

      double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
    
    for (var element in collectionReference.docs) {
      print(element.data().entries);
      setState(() {
        
        var distance = calculateDistance(element.data().entries.elementAt(2).value["latitude"],
         element.data().entries.elementAt(2).value["longitude"],
          newLocation.latitude,
           newLocation.longitude);

        _markers.add(Marker(markerId: MarkerId(element.id),position: LatLng(element.data().entries.elementAt(2).value["latitude"], element.data().entries.elementAt(2).value["longitude"]), infoWindow:  InfoWindow( //popup info 
          title: element.data().entries.elementAt(3).value["Name"],
          snippet: 'Distance: ${distance.toStringAsPrecision(2)} km',

          
        ),
        icon: descriptor,
        onTap: (){
          showDialog(context: context, builder: (context)=>DetailsPopUP(name: element.data().entries.elementAt(3).value["Name"], adress_details: element.data().entries.elementAt(3).value["AdressLine"], operational_status: element.data().entries.elementAt(1).value["status"], working_hours: element.data().entries.elementAt(1).value["working_hours"], number_of_ports: element.data().entries.elementAt(1).value["number_of_ports"], connectionType:element.data().entries.elementAt(0).value ["connectionType"], charger_availability: element.data().entries.elementAt(0).value["charger_availability"], charging_level: element.data().entries.elementAt(0).value["charging_level"]));
        }
         ));
      });
    }
   

  }
  User? user;

//   {equipment_details: {charging_level: b, charger_availability: a, connectionType: a}, charging_details: {usage_type:
// a, working_hours: a, number_of_ports: a, operator: a, status: a}, location_details: {latitude: 11.8354111, longitude: 75.9692691}, adress_details:{country: a, pincode: a, phoneNumber: a, city_town: a, AdressLine: a, state: a, landmark: a, Name: a}}
// [   +8 ms] I/flutter (17186): {charging_details: {usage_type:   h, working_hours: b, number_of_ports: b, operator: b, status: b},
// eqRuipment_details: {charging_level: f, charger_availability: f, connectionType:  f}, location_details: {latitude: 11.8354529, longitude:
// 75.9692461}, adress_details: {pincode: b, country: n, phoneNumber: b, city_town: b, AdressLine:  b, state: b, landmark: n, Name:  b}}
 
  @override
  void initState(){
    super.initState();
            FirebaseAuth.instance
        .authStateChanges()
        .listen((event) => updateUserState(event));
    setState(() {
      getLocation();
      getRegisteredChargingStations();
    });

  }




    updateUserState(event) {
    setState(() {
      user = event;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
        
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 187, 225, 255),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("EVE CHARGING STATION LOCATOR APP \nVERSION 1.1.0", style: Styles().style1(),),
                  ) ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.push(context, MaterialPageRoute(builder: (_) => user == null? Login():Details(),))),
                      child: const Padding(padding:EdgeInsets.symmetric(vertical: 0),
                      child: Card(
                        elevation: .5,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("REPORT NEW CHARGER ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,backgroundColor: Colors.white)),
                          ),
                          
                        ) ,
  
                      ),
                    
                      ),
                    ),
                    user == null ?
                    GestureDetector(
                      onTap: ((){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                      }),
                      child: const Padding(padding:EdgeInsets.symmetric(vertical: 0),
                      child: Card(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("SIGN IN ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,backgroundColor: Colors.white)),
                          ),
                          
                        ) ,
  
                      ),
                    
                      ),
                    ):
                    GestureDetector(
                      onTap: ((){
                        firebase_logout();
                      }),
                      child: const Padding(padding:EdgeInsets.symmetric(vertical: 0),
                      child: Card(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("SIGN OUT ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue,backgroundColor: Colors.white)),
                          ),
                          
                        ) ,
  
                      ),
                    
                      ),
                    ),
                  ],
                ),
              )
            ],
           ),
        ),
        appBar: AppBar(
          title: const Text("EV MAP"),

        ),
      
          body: RefreshIndicator(
            onRefresh: () async{  
              getRegisteredChargingStations();
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:GoogleMap(
               
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  
                  target: LatLng(widget.latitude, widget.longitude),
                  zoom: 13,
                ),
                onMapCreated: (GoogleMapController controller){
                  _controller = controller;
                },
                markers: _markers,
              ) ,
            ),
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
    try {
    await FirebaseAuth.instance.signOut().whenComplete(() =>Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUP()))) );
      
    } catch (e) {
      
    }
  }
  
}

