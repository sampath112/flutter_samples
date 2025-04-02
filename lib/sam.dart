import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(color: Colors.blue[600]),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home',
            onPressed: () {
              Scaffold.of(context).openDrawer(); // ✅ Opens drawer when clicked
            },
          ),
          Expanded(child: title),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null, // Disabled button
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // ✅ Fixed
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MyAppBar(
          title: Text(
            'MY APP',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                "Navigation SIDE BAR",
                style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 25),
              ),
            ),
            ListTile(title: Text('Item 1'), leading: Icon(Icons.people)),
            ListTile(title: Text('Item 2'), leading: Icon(Icons.mail)),
          ],
        ),
      ),
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Hello0000000, world!'))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // Show alert dialog when the button is pressed
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Alert'),
                      content: const Text('You clicked the button!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Thank you'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // text color
                backgroundColor: const Color.fromARGB(
                  255,
                  245,
                  40,
                  252,
                ), // background color
              ),
              child: const Text('TOUCH ME'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(child: MyScaffold()),
    ),
  );
}
