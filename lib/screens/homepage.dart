import 'package:eveapp/screens/signup.dart';
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
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
       });
  }
 
  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
           child: Column(
            children: [
              GestureDetector(
                onTap: (() => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUP(),))),
                child: Padding(padding:EdgeInsets.symmetric(vertical: 60),
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Report new Charger ", style: TextStyle(fontSize: 19,color: Colors.blue,backgroundColor: Colors.white)),
                    ),
                  ) ,
                ),
                ),
              )
            ],
           ),
        ),
        appBar: AppBar(
          title: Text("eve"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition:CameraPosition(
              target: LatLng(11.6854, 76.1320),
              zoom: 10.0,
            ),
            onMapCreated: (GoogleMapController controller){
              _controller = controller;
            },
            markers: _markers,
          ) ,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching,color: Colors.white,),
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
}