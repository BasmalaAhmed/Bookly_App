import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
                    children: [
                      const CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage(
                          'assets/images/Avatar_Placeholder.jpeg',
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kButtonColor,
                            ),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.penFancy,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
  }
}