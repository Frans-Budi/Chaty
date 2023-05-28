import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();

  final ThemeData light = ThemeData(
    primaryColor: Colors.white,
    colorScheme: const ColorScheme(
      primary: Colors.blue,
      secondary: Colors.green,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
  );

  final ThemeData dark = ThemeData(
    primaryColor: Color(0xff144272),
    colorScheme: const ColorScheme(
      primary: Colors.blue,
      secondary: Colors.green,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    primaryColorDark: Color(0xff144272),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.theme.primaryColor,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black45 : Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(
              Icons.logout,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile
          Container(
            child: Column(
              children: [
                Obx(
                  () => AvatarGlow(
                    endRadius: 110,
                    glowColor: Colors.black,
                    duration: const Duration(seconds: 2),
                    child: Container(
                      width: 175,
                      height: 175,
                      margin: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: authC.user.value.photoUrl == "noImage"
                            ? Image.asset(
                                'assets/logo/noimage.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '${authC.user.value.photoUrl}',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    '${authC.user.value.name}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '${authC.user.value.email}',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          // Controller
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Get.toNamed(Routes.UPDATE_STATUS),
                    leading: const Icon(Icons.note_add_outlined),
                    title: const Text(
                      'Update Status',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Change Profile',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_right),
                  ),
                  ListTile(
                    onTap: () => Get.changeTheme(Get.isDarkMode ? light : dark),
                    leading: const Icon(Icons.color_lens),
                    title: const Text(
                      'Change Theme',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: Text(Get.isDarkMode ? 'Dark' : 'Light'),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Container(
            margin:
                EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chat App',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black54,
                  ),
                ),
                Text(
                  'V.1.0',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
