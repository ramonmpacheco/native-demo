import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> _calcSum() async {
    const channel = MethodChannel('ramon.br/native');
    try {
      final sum = await channel.invokeMethod('calcSum', {"a": _a, "b": _b});
      setState(() {
        _sum = sum;
      });
    } on PlatformException {
      setState(() {
        _sum = 0;
      });
    }

    setState(() {
      _sum = _a + _b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NATIVE"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sum... $_sum',
                style: TextStyle(fontSize: 30),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _a = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _b = int.tryParse(value) ?? 0;
                  });
                },
              ),
              ElevatedButton(onPressed: _calcSum, child: Text('Sum'))
            ],
          ),
        ),
      ),
    );
  }
}
