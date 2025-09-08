// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:tixclick/api/register_user.dart';
// import 'package:tixclick/models/register_user_model.dart';
// import 'package:tixclick/screens/login_screen.dart';
// import 'package:tixclick/services/auth_service.dart'; // Ganti dengan AuthService

// class PostApiScreen extends StatefulWidget {
//   const PostApiScreen({super.key});
//   static const id = '/post_api_screen';
//   @override
//   State<PostApiScreen> createState() => _PostApiScreenState();
// }

// class _PostApiScreenState extends State<PostApiScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   RegisterUserModel? user;
//   String? errorMessage;
//   bool isVisibility = false;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF001F3F),
//       body: Stack(children: [buildBackground(), buildLayer()]),
//     );
//   }

//   void registerUser() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     final name = nameController.text.trim();

//     if (email.isEmpty || password.isEmpty || name.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Email, Password, dan Nama tidak boleh kosong"),
//         ),
//       );
//       setState(() => isLoading = false);
//       return;
//     }

//     try {
//       final result = await AuthenticationAPI.registerUser(
//         email: email,
//         password: password,
//         name: name,
//       );

//       setState(() {
//         user = result;
//       });

//       // DEBUG PRINT
//       _debugPrintResponse();

//       // PERBAIKAN: Token sekarang di root, bukan dalam data
//       if (user?.token != null) {
//         await _saveUserData(email, name);

//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text("Pendaftaran berhasil")));

//         print(user?.toJson());

//         // Navigate ke login screen setelah registrasi berhasil
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       } else {
//         throw Exception("Token tidak ditemukan dalam response");
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         errorMessage = e.toString();
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Registrasi gagal: $errorMessage")),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   // Method untuk debug print response
//   void _debugPrintResponse() {
//     print('=== DEBUG REGISTER RESPONSE ===');
//     print('Message: ${user?.message}');
//     print('Token: ${user?.token}'); // Token di root
//     print('User name: ${user?.user?.name}');
//     print('User email: ${user?.user?.email}');
//     print('User ID: ${user?.user?.id}');
//     print('Email verified: ${user?.user?.emailVerifiedAt}');
//     print('Full response: ${user?.toJson()}');
//     print('===============================');
//   }

//   // Method untuk save user data - DIUBAH untuk model baru
//   Future<void> _saveUserData(String email, String name) async {
//     // PERBAIKAN: Token di root, bukan dalam data
//     await AuthService.saveToken(user!.token!);
//     await AuthService.saveUserEmail(email);
//     await AuthService.saveUserName(name);

//     final userId = user?.user?.id;
//     if (userId != null) {
//       await AuthService.saveUserId(userId);
//     }

//     print('=== DATA YANG DISIMPAN ===');
//     print('Token: ${user!.token}'); // Token di root
//     print('Name: $name');
//     print('Email: $email');
//     print('ID: $userId');
//     print('==========================');
//   }

//   SafeArea buildLayer() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Register",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 height(24),
//                 buildTitle("Email Address"),
//                 height(12),
//                 buildTextField(
//                   hintText: "Enter your email",
//                   controller: emailController,
//                 ),
//                 height(16),
//                 buildTitle("Name"),
//                 height(12),
//                 buildTextField(
//                   hintText: "Enter your name",
//                   controller: nameController,
//                 ),
//                 height(16),
//                 buildTitle("Password"),
//                 height(12),
//                 buildTextField(
//                   hintText: "Enter your password",
//                   isPassword: true,
//                   controller: passwordController,
//                 ),
//                 height(12),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       // Forgot password functionality
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 height(24),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : registerUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: isLoading ? Colors.grey : Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                     ),
//                     child: isLoading
//                         ? const CircularProgressIndicator()
//                         : Text(
//                             "Submit",
//                             style: TextStyle(fontSize: 16, color: Colors.black),
//                           ),
//                   ),
//                 ),
//                 height(16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.only(right: 8),
//                         height: 1,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Text(
//                       "Or Sign In With",
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.only(left: 8),
//                         height: 1,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//                 height(16),
//                 SizedBox(
//                   height: 48,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       // Google sign in functionality
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           "assets/images/google.png",
//                           height: 16,
//                           width: 16,
//                         ),
//                         width(4),
//                         Text("Google", style: TextStyle(color: Colors.black)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 height(16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Have an account?",
//                       style: TextStyle(fontSize: 12, color: Colors.white),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         "Sign In",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Container buildBackground() {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       decoration: const BoxDecoration(),
//     );
//   }

//   TextField buildTextField({
//     String? hintText,
//     bool isPassword = false,
//     TextEditingController? controller,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword ? !isVisibility : false,
//       style: const TextStyle(color: Colors.white, fontSize: 16),
//       cursorColor: Colors.white,
//       cursorWidth: 2.0,
//       cursorHeight: 20.0,
//       selectionHeightStyle: BoxHeightStyle.tight,
//       selectionWidthStyle: BoxWidthStyle.tight,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32),
//           borderSide: BorderSide(
//             color: Colors.white.withOpacity(0.5),
//             width: 1.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32),
//           borderSide: const BorderSide(color: Colors.white, width: 1.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32),
//           borderSide: BorderSide(
//             color: Colors.white.withOpacity(0.5),
//             width: 1.0,
//           ),
//         ),
//         suffixIcon: isPassword
//             ? IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isVisibility = !isVisibility;
//                   });
//                 },
//                 icon: Icon(
//                   isVisibility ? Icons.visibility : Icons.visibility_off,
//                   color: Colors.white,
//                 ),
//               )
//             : null,
//       ),
//     );
//   }

//   SizedBox height(double height) => SizedBox(height: height);
//   SizedBox width(double width) => SizedBox(width: width);

//   Widget buildTitle(String text) {
//     return Row(
//       children: [
//         Text(text, style: const TextStyle(fontSize: 12, color: Colors.white)),
//       ],
//     );
//   }
// }
