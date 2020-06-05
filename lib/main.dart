import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample_bloc/bloc/bloc_base.dart';
import 'package:flutter_sample_bloc/bloc/counterBloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(
      MaterialApp(
        home: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final CounterBloc bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _getStreamChild(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.incrementCounter();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _getStreamChild() {
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);
    return StreamBuilder(
      initialData: 0,
      stream: bloc.counterStream,
      builder: (BuildContext context, snapshot) {
        return Center(
          child: Text(
            "Clicked " + snapshot.data.toString() + " times!",
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }
}
