import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:location/location.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Location currentLocation = Location();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController _adressline = TextEditingController();
   TextEditingController _name= TextEditingController();
  TextEditingController _cityTown = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _phone_number = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _isAvailable = TextEditingController();
  TextEditingController _operator = TextEditingController();
  TextEditingController _usageType = TextEditingController();
  TextEditingController _workingHours = TextEditingController();
  TextEditingController _ports = TextEditingController();
  TextEditingController _chargerAvailability = TextEditingController();
  TextEditingController _connectionType = TextEditingController();
  TextEditingController _chargingLevel = TextEditingController();
  late String latitude;
  late String longitude;


  


  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Container(
           padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
        
            children: [
              const SizedBox(height: 20),
              const Text("ADD A CHARGING LOCATION",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue)),
              const SizedBox(height: 15),
                const Text("STEP 1-LOCATION DETAILS ",style: TextStyle(fontSize: 21,color: Colors.blue)),
                 const SizedBox(height: 15),
              TextFormField(
                controller: _latitude,
                decoration: const InputDecoration(hintText: "Latitude",
                border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _longitude,
                decoration: const InputDecoration(hintText: "Longitude",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 15),
                ElevatedButton.icon(onPressed: (){
                getcurrentlocation();
              }, icon: const Icon(Icons.location_searching),
              
              label: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Get my current location"),
              )),
              
               const SizedBox(height: 20),
              const Text("STEP 2-ADDRESS DETAILS ",style: TextStyle(fontSize: 21,color: Colors.blue)),
                 const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                decoration: const InputDecoration(hintText: " Name",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),  
                  const SizedBox(height: 10),
                TextFormField(
                  controller: _adressline,
                decoration: const InputDecoration(hintText: "Address line",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _cityTown,
                decoration: const InputDecoration(hintText: "City or Town Name",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _landmark,
                decoration: const InputDecoration(hintText: "Nearest Landmark",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _state,
                decoration: const InputDecoration(hintText: "State or Province",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _pincode,
                decoration: const InputDecoration(hintText: "Zip/Postal code",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _phone_number,
                decoration: const InputDecoration(hintText: "Phone no",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _country,
                decoration: const InputDecoration(hintText: "Country",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 20),
               const Text("STEP 3-BASIC CHARGING DETAILS ",style: TextStyle(fontSize: 21,color: Colors.blue)),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _isAvailable,
                decoration: const InputDecoration(hintText: "Operational Status",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
              const SizedBox(height: 10),
               TextFormField(
                controller: _operator,
                decoration: const InputDecoration(hintText: "Operator",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _usageType,
                decoration: const InputDecoration(hintText: "Usage type",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _workingHours,
                decoration: const InputDecoration(hintText: "Working Hours",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _ports,
                decoration: const InputDecoration(hintText: "Number of Ports",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
                const SizedBox(height: 15),
               const Text("STEP 4-EQUIPEMENT DETAILS ",style: TextStyle(fontSize: 21,color: Colors.blue)),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _connectionType,
                decoration: const InputDecoration(hintText: "Connection type",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
                TextFormField(
                  controller: _chargerAvailability,
                decoration: const InputDecoration(hintText: "Charger Availability",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
             const SizedBox(height: 10),
                TextFormField(
                  controller: _chargingLevel,
                decoration: const InputDecoration(hintText: "Charging level",
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
              ElevatedButton(onPressed: (){
                  updateIntoFirebase();
              }, child: Text("Submit")),
              
              
            
            
               
             
            ],
          ),
        ),
      ),
      )
    );
  }

  void getcurrentlocation() async{
       
        var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){
 
      
      print(loc.latitude);
      print(loc.longitude);
      latitude = loc.latitude.toString();
      longitude = loc.longitude.toString();
      setState(() {
       _longitude.text = loc.longitude.toString();
       _latitude.text = loc.latitude.toString();
      });
       });

       }

       
       void updateIntoFirebase()async{
         CollectionReference collectionReference = FirebaseFirestore.instance.collection("addded location");
       await collectionReference.doc(FirebaseAuth.instance.currentUser!.uid).set({
        "location_details":{

        "latitude":latitude,
        "longitude":longitude,
        },
        "adress_details":{
        "Name":_name.text,
        "AdressLine":_adressline.text,
        "city_town":_cityTown.text,
        "landmark":_landmark.text,
        "state":_state.text,
        "pincode":_pincode.text,
        "phoneNumber":_phone_number.text,
        "country":_country.text,
        

        
        },
        "charging_details":{
          "status":_isAvailable.text,
          "operator":_operator.text,
          "usage_type":_usageType.text,
          "working_hours":_workingHours.text,
          "number_of_ports":_ports.text,
          

        },
        "equipment_details":{
          "connectionType":_connectionType.text,
          "charger_availability":_chargerAvailability.text,
          "charging_level":_chargingLevel.text,

        }


        
       });
  }
}