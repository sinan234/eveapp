import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eveapp/screens/homepage.dart';
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
              const Text("ADD A CHARGING LOCATION",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:  Color.fromARGB(255, 2, 28, 49))),
              const SizedBox(height: 15),
                const Text("LOCATION DETAILS ",style: TextStyle(fontSize: 21,color: Color.fromARGB(255, 2, 28, 49),)),
                 const SizedBox(height: 15),
              TextFormField(
                controller: _latitude,
                
                decoration: const InputDecoration(hintText: "Latitude",prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        color:  Color.fromARGB(255, 2, 28, 49),
                      ),
                border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _longitude,
                decoration: const InputDecoration(hintText: "Longitude",prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        color:  Color.fromARGB(255, 2, 28, 49),
                      ),
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
              const Text("ADDRESS DETAILS ",style: TextStyle(fontSize: 21,color: Color.fromARGB(255, 2, 28, 49))),
                 const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  
                decoration: const InputDecoration(hintText: " Name",prefixIcon: const Icon(
                        Icons.person_pin_circle_outlined,
                        color:  Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),  
                  const SizedBox(height: 10),
                TextFormField(
                  controller: _adressline,
                decoration: const InputDecoration(hintText: "Address line",prefixIcon: const Icon(
                        Icons.house_rounded,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _cityTown,
                decoration: const InputDecoration(hintText: "City or Town Name",prefixIcon: const Icon(
                        Icons.location_city_rounded,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _landmark,
                decoration: const InputDecoration(hintText: "Nearest Landmark",prefixIcon: const Icon(
                        Icons.landscape,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _state,
                decoration: const InputDecoration(hintText: "State or Province",prefixIcon: const Icon(
                        Icons.villa_outlined,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _pincode,
                decoration: const InputDecoration(hintText: "Zip/Postal code",prefixIcon: const Icon(
                        Icons.local_post_office_outlined,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _phone_number,
                decoration: const InputDecoration(hintText: "Phone no",prefixIcon: const Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _country,
                decoration: const InputDecoration(hintText: "Country",prefixIcon: const Icon(
                        Icons.other_houses_outlined,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 20),
               const Text("BASIC CHARGING DETAILS ",style: TextStyle(fontSize: 21,color: Color.fromARGB(255, 2, 28, 49),fontFamily: 'opensans')),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _isAvailable,
                decoration: const InputDecoration(hintText: "Operational Status",prefixIcon: const Icon(
                        Icons.hourglass_bottom_rounded,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
              const SizedBox(height: 10),
               TextFormField(
                controller: _operator,
                decoration: const InputDecoration(hintText: "Operator",prefixIcon: const Icon(
                        Icons.settings_applications_sharp,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _usageType,
                decoration: const InputDecoration(hintText: "Usage type",prefixIcon: const Icon(
                        Icons.public,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _workingHours,
                decoration: const InputDecoration(hintText: "Working Hours",prefixIcon: const Icon(
                        Icons.timelapse_outlined,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
               TextFormField(
                controller: _ports,
                decoration: const InputDecoration(hintText: "Number of Ports",prefixIcon: const Icon(
                        Icons.account_tree_rounded,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
                const SizedBox(height: 15),
               const Text("EQUIPEMENT DETAILS ",style: TextStyle(fontSize: 21,color: Color.fromARGB(255, 2, 28, 49))),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _connectionType,
                decoration: const InputDecoration(hintText: "Connection type",prefixIcon: const Icon(
                        Icons.construction_outlined,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
               const SizedBox(height: 10),
                TextFormField(
                  controller: _chargerAvailability,
                decoration: const InputDecoration(hintText: "Charger Availability",prefixIcon: const Icon(
                        Icons.power_outlined,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
                 border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
              ),
              ),
             const SizedBox(height: 10),
                TextFormField(
                  controller: _chargingLevel,
                decoration: const InputDecoration(hintText: "Charging level",prefixIcon: const Icon(
                        Icons.currency_rupee_rounded,
                        color: Color.fromARGB(255, 2, 28, 49),
                      ),
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
         try {
                  await collectionReference.doc(FirebaseAuth.instance.currentUser!.uid).set({
        "location_details":{

        "latitude":double.parse(_latitude.text),
        "longitude":double.parse(_longitude.text),
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


        
       }).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (_)=>MapScreen())));
         }on FirebaseException catch (e) {
          print(e.message);
           
         }

  }
}