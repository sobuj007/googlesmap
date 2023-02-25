import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

var gMapApiKey = 'AIzaSyANrm5Pr4dXHtyH2lfl2twKUduPDuNBpb4';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();

  runApp(MaterialApp(
    home: Gmap(),
  ));
}

class Gmap extends StatefulWidget {
  const Gmap({super.key});

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  Position? p;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cureent();
  }

  cureent() async {
   
    LocationPermission permission;
    permission = await Geolocator.requestPermission(); Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      print(position);
      p = position;
      currentMaker(p);
    });
  }

  Set<Marker> mark = {};

  void currentMaker(p) {
    setState(() {
      mark.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId('name'.toString()),
          position: LatLng(p.latitude, p.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(2.0),
          onTap: () {
          
            showModalBottomSheet(
                context: context,
                builder: (_) => Container(
                  
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(  color: Colors.white,borderRadius: BorderRadius.circular(15)),
                      height: MediaQuery.of(context).size.height*.30,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Current Location",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                 color: Colors.black,decorationColor: Colors.black),
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Latitude ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                                Text(
                                  ": ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                                Text(
                                  p.latitude.toString(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                              SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Longitude ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                                Text(
                                  ": ",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                                Text(
                                  p.longitude.toString(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                             SizedBox(height: 8.0,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                             

                              Container(height: 60,width: 60,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),fit: BoxFit.cover),borderRadius: BorderRadius.circular(50)),)
                           ,Text("Md.Sayeed Anwar",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.bold),),  ],)
, Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text("Blood Group",style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),)
                           , Text("O+",style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),)
                          ],)
                            
                          ],
                         
                        ),
                      ),
                    ));
          }));
    });
  }

  void addmarker(p) {
    setState(() {
      mark.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId('name'.toString()),
        position: LatLng(p.latitude, p.longitude),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(2.0),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          //body:p==null? Container(): Text(p.toString())
          body: Column(
            children: [
              p == null
                  ? Container()
                  : Expanded(
                      child: GoogleMap(
                          markers: mark,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(p!.latitude, p!.longitude),
                              zoom: 18.0))),
            ],
          )),
    );
  }
}
