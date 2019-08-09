import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Area Calculator'),
        ),
        body: AreaCalculator(),
      ),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  @override
  _AreaCalculatorState createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  
  List<String> shapes =  ['Rectangle', 'Triangle'];
  String currentShape;
  String result='0';
  double width = 0;
  double height = 0;

  final TextEditingController widthController =TextEditingController();
  final TextEditingController heightController =TextEditingController();

  @override
  void initState() {
      
    super.initState();
    result = '0';
    currentShape = 'Triangle';
    widthController.addListener(updateWidth);
    heightController.addListener(updateHeight);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          margin:EdgeInsets.only(top:15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
            //dropdown
              DropdownButton<String>(
                value:currentShape,
                items:shapes.map((String value) {
                    return new DropdownMenuItem<String>(
                      value:value,
                      child: Text(value, 
                        style: TextStyle(fontSize: 24.0),),
                    );
                  }).toList(),
                  onChanged:(shape){
                    setState(() {
                      currentShape = shape;
                    }); 
                  }),
              ShapeContainer(shape: currentShape,),
            //width
              AreaTextField(controller: widthController, hint: 'Width'),
            //height
              AreaTextField(controller: heightController, hint: 'Height'),
              Container(
                margin: EdgeInsets.all(15.0),
                child:RaisedButton(
                  child:Text('Calculate Area',
                    style: TextStyle(fontSize: 18.0),),
                  //color: Colors.lightBlue,
                  onPressed: calculateArea,
                  ) 
                ,
                ),
              Text(result, 
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.green[700],
                ),),
          ],)
        ),
      );
  }

  void calculateArea() {
    double area;

    if (currentShape == 'Rectangle') {
      area = width * height;
    }
    else if (currentShape == 'Triangle') {
      area = width * height / 2;
    }
    else {
      area = 0;
    }
    setState(() {
     result = 'The area is ' + area.toString();
    });
  }

  void updateWidth() {
    setState(() {
      if (widthController.text != '') {
         width = double.parse(widthController.text); 
      }
      else {
        width = 0;
      }
    });
  }
  
  void updateHeight() {
    setState(() {
      if (heightController.text != '') {
         height = double.parse(heightController.text); 
      }
      else {
        height = 0;
      }
    });

  }
}

class AreaTextField extends StatelessWidget {
  AreaTextField({this.controller, this.hint});
  
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child:TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.green[700], 
          fontWeight: FontWeight.w300,
          fontSize: 24.0
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.border_all),
          filled: true,
          fillColor: Colors.grey[300],
          hintText: hint,
          
        ),
      )
    );
  }
}

class ShapeContainer extends StatelessWidget {
  final String shape;

  const ShapeContainer({Key key, this.shape}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shape == 'Triangle'){
      return CustomPaint(
        size: Size(100.0, 100.0),
        painter: TrainglePainter()
      );
    } else{
      return CustomPaint(
        size: Size(100.0, 100.0),
        painter: RectanglePainter()
      );
    }
  }
}
        
class TrainglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();
    paint.color = Colors.black;

    var path = Path();
    path.moveTo(size.width/2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();
    paint.color = Colors.deepPurple;
    
    Rect rect = Rect.fromLTRB(0.0, size.height/4, size.width, size.height/4*3);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}