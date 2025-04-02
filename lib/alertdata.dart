import 'package:flutter/material.dart';

// Entry point
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String appTitle = 'SAMPATH';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: appTitle),
    ); // Removed incorrect Expanded & IconButton
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Initialize with a valid index
  final _formKey = GlobalKey<FormState>(); // Key to validate form
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();

  // Method to change the app bar title and update selected index
  void _onItemTapped(int index) {
    if (index >= 0 && index < 3) {
      // Ensure the index is within bounds
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        foregroundColor: Colors.cyanAccent, // Title text color
        backgroundColor: const Color.fromARGB(255, 76, 127, 175),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              // Add search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text(_getBodyText(), style: const TextStyle(fontSize: 40.0)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // No extra padding
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                "Sampath Jonnalagadda",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text("sampathchowdarie@gmail.com"),
              currentAccountPictureSize: Size.square(50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "SJ",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ),
              ),
            ),
            _drawerItem(Icons.person, "My Profile", 0),
            _drawerItem(Icons.book, "My Course", 1),
            _drawerItem(Icons.workspace_premium, "Go Premium", 2),
            _drawerItem(Icons.video_label, "Saved Videos", 3),
            _drawerItem(Icons.edit, "Edit Profile", 4),
            _drawerItem(Icons.logout, "Log Out", 5),
            _drawerItem(Icons.add, "Add Data", 6), // New item to open the form
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Add new item or perform an action
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('FAB clicked!')));
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, // Always within bounds (0 to 2)
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  // Return appropriate title based on selected index
  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Notifications';
      case 2:
        return 'Settings';
      default:
        return widget.title;
    }
  }

  // Return appropriate body text based on selected index
  String _getBodyText() {
    switch (_selectedIndex) {
      case 0:
        return 'Welcome to Home Page!';
      case 1:
        return 'Here are your notifications';
      case 2:
        return 'Settings Page';
      default:
        return 'PAGES CREATED USING DRAWER.';
    }
  }

  // Helper method to create drawer items
  Widget _drawerItem(IconData icon, String text, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        if (index == 6) {
          _openForm(); // Open form for Add Data
        } else {
          _onItemTapped(index); // Update selected index
          _navigateToPage(text); // Navigate to corresponding page
        }
      },
    );
  }

  // Method to navigate to different pages based on drawer selection
  void _navigateToPage(String pageName) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigating to $pageName')));
    Navigator.pop(context); // Close drawer after selection
  }

  // Open form with two input fields
  void _openForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Data"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _textField1Controller,
                  decoration: InputDecoration(labelText: 'Field 1'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _textField2Controller,
                  decoration: InputDecoration(labelText: 'Field 2'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // If the form is valid, show success alert
                  Navigator.of(context).pop();
                  _showAlertDialog('Success', 'Data Submitted Successfully');
                } else {
                  // If fields are missing
                  _showAlertDialog('Error', 'Please fill in all fields');
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Function to show alert dialog
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
