// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   // Animation controller
//   late AnimationController _animationController;

//   // This is used to animate the icon of the main FAB
//   late Animation<double> _buttonAnimatedIcon;

//   // This is used for the child FABs
//   late Animation<double> _translateButton;

//   // This variable determnies whether the child FABs are visible or not
//   bool _isExpanded = false;

//   @override
//   initState() {
//     _animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 600))
//       ..addListener(() {
//         setState(() {});
//       });

//     _buttonAnimatedIcon =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

//     _translateButton = Tween<double>(
//       begin: 100,
//       end: -20,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//     super.initState();
//   }

//   // dispose the animation controller
//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // This function is used to expand/collapse the children floating buttons
//   // It will be called when the primary FAB (with menu icon) is pressed
//   _toggle() {
//     if (_isExpanded) {
//       _animationController.reverse();
//     } else {
//       _animationController.forward();
//     }

//     _isExpanded = !_isExpanded;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('KindaCode.com')),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Transform(
//             transform: Matrix4.translationValues(
//               0.0,
//               _translateButton.value * 4,
//               0.0,
//             ),
//             child: FloatingActionButton(
//               backgroundColor: Colors.blue,
//               onPressed: () {/* Do something */},
//               child: const Icon(
//                 Icons.email,
//               ),
//             ),
//           ),
//           Transform(
//             transform: Matrix4.translationValues(
//               0,
//               _translateButton.value * 3,
//               0,
//             ),
//             child: FloatingActionButton(
//               backgroundColor: Colors.red,
//               onPressed: () {/* Do something */},
//               child: const Icon(
//                 Icons.call,
//               ),
//             ),
//           ),
//           Transform(
//             transform: Matrix4.translationValues(
//               0,
//               _translateButton.value * 2,
//               0,
//             ),
//             child: FloatingActionButton(
//               backgroundColor: Colors.amber,
//               onPressed: () {/* Do something */},
//               child: const Icon(Icons.message),
//             ),
//           ),
//           // This is the primary FAB
//           FloatingActionButton(
//             onPressed: _toggle,
//             child: AnimatedIcon(
//               icon: AnimatedIcons.menu_close,
//               progress: _buttonAnimatedIcon,
//             ),
//           ),
//         ],
//       ),sss
//     );
//   }
// }