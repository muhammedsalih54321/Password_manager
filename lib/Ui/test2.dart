import 'package:flutter/material.dart';



class AppListPage extends StatefulWidget {
  @override
  _AppListPageState createState() => _AppListPageState();
}

class _AppListPageState extends State<AppListPage> {
  List<Map<String, String>> apps = [];

  void addApp(String name) {
    setState(() {
      apps.add({'name': name, 'time': TimeOfDay.now().format(context)});
    });
  }
    List<String> appNames = [
    'Amazon',
    'Bank B0FAUS3N',
    'Credit Card Visa',
    'Facebook',
    'Google',
    'Netflix',
    'Outlook',
    'PayPal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App List')),
      body:  ListView.builder(
            
              itemCount: appNames.length,
              itemBuilder: (context, index) {
                String name=appNames.elementAt(index)[0];
                // String appName = apps[index]['name']!;
                // String time = apps[index]['time']!;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[700],
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  title: Text(appNames[index]),
                  trailing: Text(''),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final result = await Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AppFormPage()),
          // );

          // if (result != null) {
          //   addApp(result);
          // }
      
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AppFormPage extends StatefulWidget {
  @override
  _AppFormPageState createState() => _AppFormPageState();
}

class _AppFormPageState extends State<AppFormPage> {
  final TextEditingController _nameController = TextEditingController();

  void submitApp() {
    if (_nameController.text.isNotEmpty) {
      Navigator.pop(context, _nameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add App Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'App Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitApp,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

