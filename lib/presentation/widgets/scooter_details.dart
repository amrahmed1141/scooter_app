import 'package:flutter/material.dart';

class ScooterDetails extends StatefulWidget {
  final double batteryLevel;
  final double distanceCovered;
  final String speed;
  const ScooterDetails({super.key, required this.batteryLevel, required this.distanceCovered, required this.speed});

  @override
  State<ScooterDetails> createState() => _ScooterDetailsState();
}

class _ScooterDetailsState extends State<ScooterDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [ 
        const SizedBox(width: 15),
          Image.asset('assets/icons/battery.png',height: 30,width: 30,),
          const SizedBox(width: 5,),
          Text(widget.batteryLevel.toString(),style:const TextStyle(color: Colors.white) ,),
          const SizedBox(width: 15),
           Image.asset('assets/icons/road-with-broken-line.png',height: 30,width: 30,),
            const SizedBox(width: 5,),
         Text(widget.distanceCovered.toString(),style:const TextStyle(color: Colors.white) ,),
          const SizedBox(width: 15),
           Image.asset('assets/icons/speedometer.png',height: 30,width: 30,),
            const SizedBox(width: 5,),
          Text(widget.speed,style:const TextStyle(color: Colors.white) ,),
              
    ],);
  }
}