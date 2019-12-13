import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Intrest Calculator",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ),
  );
}

class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormstate();
  }

}

class _SIFormstate extends State<SIForm>{

  var formkey = GlobalKey<FormState>();
  var _currencies = ['Dollors','Rupees','Pound'];

  var _currentSelectItem = 'Rupees';

  TextEditingController principleController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("SI Calculator"),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: TextFormField(
                // ignore: missing_return
                validator: (String value){
                  if(value.isEmpty) {
                    return 'Enter the principle amount';
                  }
                },
                controller: principleController,
                style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 15.0,
                ),
                labelStyle: textStyle,
                labelText: "Principal",
                hintText: "Enter the amount eg. 12000",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
              ),
            )),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child:TextFormField(
                validator: (String value){
                  if(value.isEmpty){
                    return 'Enter the rate of intrest';
                  }
                },
                controller: rateController,
                style: textStyle,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.0,

                  ),
                labelStyle: textStyle,
                  labelText: "Rate of Intrest",
                  hintText: "Enter the rate (in percetange)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
              ),
            )),
            Row(
              children: <Widget>[
                Expanded(
                  child:TextFormField(
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Enter the time';
                      }
                    },
                    controller: termController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                    labelStyle: textStyle,
                      labelText: "Term",
                      hintText: "time in year",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),
                )),
                Container(width: 25.0,),
                Expanded(
                  child:DropdownButton<String>(
                  items: _currencies.map((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                  },).toList(),
                  value: _currentSelectItem,
                  onChanged: (String NewValueSelected){
                    onDropDownSelectedItem(NewValueSelected);
                  }
                ))
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Calculate",
                    textScaleFactor: 1.5,
                    style: textStyle,
                    ),
                    onPressed: (){
                      setState(() {
                        if(formkey.currentState.validate()) {
                          this.displayResult = _calculateTotalRetrun();
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor:Theme.of(context).accentColor,
                    child: Text("Reset",textScaleFactor: 1.5,),
                    onPressed: (){
                      setState(() {
                        _reset();
                      });
                    },
                  ),
                )
              ],
            ),),
            Text(displayResult),
          ],
        ),

      ),
    );
  }
  Widget getImageAsset () {
    AssetImage assetImage = AssetImage('images/flight.png');
    Image image = Image(image: assetImage, width: 150.0, height: 150.0,);
    return Container(child: image,);
  }

  void onDropDownSelectedItem(String NewValueSelected){
    setState(() {
      this._currentSelectItem = NewValueSelected;
    });
  }
  String _calculateTotalRetrun(){
   double principle= double.parse(principleController.text);
   double rate = double.parse(rateController.text);
   double time = double.parse(termController.text);

   double total = principle + (principle*rate*time)/100;

   String result = "After $time years your investment will be $total $_currentSelectItem";

   return result;
  }

  void _reset(){
    principleController.text = '';
    rateController.text = '';
    termController.text = '';
    displayResult = '';
    _currentSelectItem = _currencies[0];
  }
}