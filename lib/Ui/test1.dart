// import 'package:flutter/material.dart';
// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   List<String> appNames = [
//     'Amazon',
//     'Bank B0FAUS3N',
//     'Credit Card Visa',
//     'Facebook',
//     'Google',
//     'Netflix',
//     'Outlook',
//     'PayPal',
//   ];


//   Map<String, List<String>> groupedApps = {};
// Map<String, List<String>> groupAppNames(List<String> appNames) {
//   Map<String, List<String>> groupedApps = {};
//   for (var app in appNames) {
//     String firstLetter = app[0].toUpperCase();
//     if (!groupedApps.containsKey(firstLetter)) {
//       groupedApps[firstLetter] = [];
//     }
//     groupedApps[firstLetter]!.add(app);
//   }
//   return groupedApps;
// }
//   @override
//   void initState() {
//     super.initState();
//     groupedApps = groupAppNames(appNames);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Password Manager'),
//       ),
//       body: Row(
//         children: [
//           // Left Side: Alphabetical List
//           Expanded(
//             flex: 1,
//             child: ListView.builder(
//               itemCount: groupedApps.length,
//               itemBuilder: (context, index) {
//                 String letter = groupedApps.keys.elementAt(index);
//                 return ExpansionTile(
//                   title: Text(letter),
//                   children: groupedApps[letter]!
//                       .map((app) => ListTile(
//                             title: Text(app),
//                             onTap: () {
//                               // TODO: Show details of the selected app
//                             },
//                           ))
//                       .toList(),
//                 );
//               },
//             ),
//           ),
//           // Right Side: App Details (Placeholder for now)
//           Expanded(
//             flex: 2,
//             child: Center(
//               child: Text('Select an app to view details'),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Navigate to the data creation page
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const DataCreationPage()),
//           );
//           // TODO: Update the app list after adding new data
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class DataCreationPage extends StatefulWidget {
//   const DataCreationPage({super.key});

//   @override
//   State<DataCreationPage> createState() => _DataCreationPageState();
// }

// class _DataCreationPageState extends State<DataCreationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _appNameController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _appNameController.dispose();
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
  

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _appNameController,
//                 decoration: const InputDecoration(labelText: 'App Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the app name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(labelText: 'Username'),
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Save the data and update the app list
//                     String appName = _appNameController.text;
//                     String username = _usernameController.text;
//                     String email = _emailController.text;
//                     String password = _passwordController.text;

                  
//                     Navigator.pop(context); // Close the data creation page
//                   }
//                 },
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// Import the provider

class AppIconPage extends StatefulWidget {
  const AppIconPage({super.key});

  @override
  State<AppIconPage> createState() => _AppIconPageState();
}

class _AppIconPageState extends State<AppIconPage> {
  final _appNameController = TextEditingController();

  @override
  void dispose() {
    _appNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appIconProvider = Provider.of<AppIconProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Icon Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextFormField for app name input
            TextFormField(
              controller: _appNameController,
              decoration: const InputDecoration(
                labelText: 'Enter App Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // ADD button
            ElevatedButton(
              onPressed: () async {
                if (_appNameController.text.isNotEmpty) {
                  await appIconProvider.addApp(_appNameController.text);
                  _appNameController.clear(); // Clear the input field
                }
              },
              child: const Text('ADD'),
            ),
            const SizedBox(height: 40),
            // Display fetched app icons
            Expanded(
              child: ListView.builder(
                itemCount: appIconProvider.appIcons.length,
                itemBuilder: (context, index) {
                  final appName = appIconProvider.appIcons.keys.elementAt(index);
                  final appIconUrl = appIconProvider.appIcons[appName];
                  return ListTile(
                    leading: appIconUrl != null
                        ? Image.network(appIconUrl)
                        : CircleAvatar(
                            child: Text(appName[0]),
                          ),
                    title: Text(appName),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AppIconProvider with ChangeNotifier {
  // Map to store app names and their icon URLs
  Map<String, String?> appIcons = {};

  // Add a new app and fetch its icon
  Future<void> addApp(String appName) async {
    final response = await http.get(Uri.parse('https://logo.clearbit.com/$appName.com'));
    if (response.statusCode == 200) {
      appIcons[appName] = 'https://logo.clearbit.com/$appName.com';
    } else {
      appIcons[appName] = null; // No icon found
    }
    notifyListeners(); // Update the UI
  }
}