import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../common/common.dart';
import '../common/horizontal_separator.dart';
import 'invite/invite.dart';
import 'navigation_rail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const String route = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.mainBG,
          child: Row(
            children: [
              MainNavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationClick: (index) {
                  setState(() => _selectedIndex = index);
                },
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 88,
                        height: MediaQuery.of(context).size.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HorizontalSeparator(
                              height: MediaQuery.of(context).size.height,
                            ),
                            HorizontalSeparator(
                              height: MediaQuery.of(context).size.height,
                            ),
                            HorizontalSeparator(
                              height: MediaQuery.of(context).size.height,
                            ),
                            HorizontalSeparator(
                              height: MediaQuery.of(context).size.height,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 48,
                      left: 48,
                      child: Text(
                        Strings.inviteSent.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.listTitleText,
                          letterSpacing: 2,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 96,
                      left: 48,
                      child: SizedBox(
                        width: 260,
                        height: 124 * 2.0,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InviteCard(
                                invite: Invite(
                                  id: '5e394a33609f9160cd8500fe',
                                  categories: ['Glamour'],
                                  date: 1595099225000,
                                  status: 'sent',
                                  sender: Member(
                                      id: '5e394a33609f9160cd8500fe',
                                      firstName: 'John',
                                      lastName: 'Doe',
                                      username: 'john',
                                      avatar: ''),
                                  receiver: Member(
                                      id: '5e394a33609f9160cd8500fe',
                                      firstName: 'John',
                                      lastName: 'Doe',
                                      username: 'joe',
                                      avatar: ''),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 96 + (124 * 2.0) + 16,
                      left: 48,
                      child: InkWell(
                        onTap: () {
                          logger.i('Invite new models');
                        },
                        child: SizedBox(
                          width: 260,
                          height: 48,
                          child: CustomContainer(
                            shadowColor: AppColors.inviteContainerShadow,
                            child: Row(
                              children: const [
                                HorizontalSpacer(
                                  space: 16,
                                ),
                                Icon(
                                  MaterialIcons.person_add,
                                  color: AppColors.inviteCardIcon,
                                ),
                                HorizontalSpacer(
                                  space: 12,
                                ),
                                Text(
                                  'Invite new model',
                                  style: TextStyle(
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
