import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mode_object_being_streamed.dart';

class StreamProviderExample extends StatelessWidget{
  StreamProviderExample({
    Key key,
}):super(key: key);

  @override
  Widget build(BuildContext context) {
   return StreamProvider<ModelObjectBeingStreamed>(
     initialData: ModelObjectBeingStreamed(currentValueOfMemberInTheObjectBeingStreamed: 0),
     create: (_)=>createStreamOfModelBeingStreamed(),
     child: MaterialApp(
       home: StreamProviderExampleUI(),
     ),
   );
  }

  Stream<ModelObjectBeingStreamed> createStreamOfModelBeingStreamed() {
    return Stream<ModelObjectBeingStreamed>.periodic(
      Duration(seconds: 1),
        (currentPeriodicValue) => ModelObjectBeingStreamed(currentValueOfMemberInTheObjectBeingStreamed: currentPeriodicValue+1)).take(10000);
  }

}

class StreamProviderExampleUI extends StatelessWidget{

 const StreamProviderExampleUI({
    Key key
}): super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('stream provider example'),
       backgroundColor: Colors.white,
     ),
     backgroundColor: Colors.white,
     body: Align(
//       alignment: Alignment(0,-20),
       child: Consumer<ModelObjectBeingStreamed>(
           builder:(context, newInstanceOfModelObjectBeingStreamed, _){
           return StuffyYouSee(newInstanceOfModelObjectBeingStreamed:newInstanceOfModelObjectBeingStreamed);
       },
         child: Container(),
       )
     ),
   );
  }
  
}

class StuffyYouSee extends StatelessWidget{
  final ModelObjectBeingStreamed newInstanceOfModelObjectBeingStreamed;
  const StuffyYouSee({
    Key key,
    this.newInstanceOfModelObjectBeingStreamed
}):super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
     margin: const EdgeInsets.all(16),
     decoration: BoxDecoration(
       color: Colors.purple[200],
       border: Border.all(
         color: Colors.black45,
         width: 2
       ),
         borderRadius: BorderRadius.circular(20),
     boxShadow:[
       BoxShadow(
         color: Colors.black38,
         blurRadius: 3,
         offset: Offset(2,2),
       ),
     ]),
     padding: const EdgeInsets.all(16),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Text('this is not incrementing!\n\nit\s the number of times this '
           'ModelObject has been replaced with a completely different '
           'one. Each new Object has a value one higher than the object it '
           'replaced. \n\n Remember, we\'are streaming Objects, not updates. \n',
         textAlign: TextAlign.left,
         style: TextStyle(
           fontWeight: FontWeight.w800,
           fontSize: 24,
           color: Colors.white,
           shadows: [
             BoxShadow(
               color: Colors.black54,
               blurRadius: 3,
               offset: Offset(1,1),
             )
           ]
         ),),
         Text(newInstanceOfModelObjectBeingStreamed.currentValueOfMemberInTheObjectBeingStreamed.toString(),
         style: TextStyle(
           fontWeight: FontWeight.w800,
           fontSize: 88,
           color: Colors.white,
             shadows: [
               BoxShadow(
                 color: Colors.black54,
                 blurRadius: 3,
                 offset: Offset(1,1),
               )
             ]
         ),),
       ],
     ),
   );
  }

}