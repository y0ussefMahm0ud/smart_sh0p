import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_sh0p/screens/auth/login.dart';
import 'package:smart_sh0p/screens/inner_screens/orders/orders_screen.dart';
import 'package:smart_sh0p/screens/inner_screens/viewed_recently.dart';
import 'package:smart_sh0p/screens/inner_screens/wishlist.dart';
import 'package:smart_sh0p/widgets/subtitle_text.dart';
import 'package:smart_sh0p/widgets/title_text.dart';

import '../models/user_model.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../services/assets_manager.dart';
import '../services/my_app_method.dart';
import 'inner_screens/privacy & policy.dart';
import 'inner_screens/support chat.dart';
import 'loading_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>  with AutomaticKeepAliveClientMixin {
   @override
 
   bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error has been occured $error",
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            period: const Duration(seconds: 16),
            baseColor: Colors.purple,
            highlightColor: Colors.red,
            child: const TitlesTextWidget(
              label: "smart_sh0p",
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: LoadingManager(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: user == null ? true : false,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TitlesTextWidget(
                        label: "Please login to have ultimate access"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                userModel == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    width: 3),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userModel!.userImage,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitlesTextWidget(label: userModel!.userName),
                                SubtitleTextWidget(
                                  label: userModel!.userEmail,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitlesTextWidget(label: "General"),
                      user == null
                          ? const SizedBox.shrink()
                          : CustomListTile(
                              imagePath: AssetsManager.orderSvg,
                              text: "All orders",
                              function: () async {
                                await Navigator.pushNamed(
                                  context,
                                  OrdersScreenFree.routeName,
                                );
                              },
                            ),
                      user == null
                          ? const SizedBox.shrink()
                          : CustomListTile(
                              imagePath: AssetsManager.wishlistSvg,
                              text: "Wishlist",
                              function: () {
                                Navigator.pushNamed(
                                  context,
                                  WishlistScreen.routName,
                                );
                              },
                            ),
                      CustomListTile(
                        imagePath: AssetsManager.recent,
                        text: "Viewed recently",
                        function: () {
                          Navigator.pushNamed(
                            context,
                            ViewedRecentlyScreen.routName,
                          );
                        },
                      ),
                      CustomListTile(
                        imagePath: AssetsManager.support,
                        text: "support chat",
                        function: () {
                           Navigator.pushNamed(
                            context,
                            Supportchat.routName,
                          );
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const TitlesTextWidget(label: "Settings"),
                      const SizedBox(
                        height: 7,
                      ),
                      SwitchListTile(
                        secondary: Image.asset(
                          AssetsManager.theme,
                          height: 30,
                        ),
                        title: Text(themeProvider.getIsDarkTheme
                            ? "Dark mode"
                            : "Light mode"),
                        value: themeProvider.getIsDarkTheme,
                        onChanged: (value) {
                          themeProvider.setDarkTheme(themeValue: value);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                CustomListTile(
                  imagePath: AssetsManager.privacy,
                  text: "privacy & policy",
                  function: () {
                     Navigator.pushNamed(
                            context,
                            Privacy.routName,
                          );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (user == null) {
                          await Navigator.pushNamed(
                            context,
                            LoginScreen.routName,
                          );
                        } else {
                          await MyAppMethods.showErrorORWarningDialog(
                              context: context,
                              subtitle: "Are you sure?",
                              fct: () async {
                                await FirebaseAuth.instance.signOut();
                                if (!mounted) return;
                                await Navigator.pushNamed(
                                  context,
                                  LoginScreen.routName,
                                );
                              },
                              isError: false);
                        }
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(user == null ? Icons.login : Icons.logout),
                      ),
                      label: Text(
                        user == null ? "Login" : "Logout",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  
 
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.function});
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(label: text),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
