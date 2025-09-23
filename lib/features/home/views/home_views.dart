part of 'home_page.dart';

Widget _buildBody(HomeController controller) {
  return TabBarView(
    controller: controller.tabCtrl,
    physics: const NeverScrollableScrollPhysics(),
    children: const [ListProductPage(), UserInformationView()],
  );
}

Widget _buildBottomNavigationBar(HomeController controller) {
  return Stack(
    alignment: Alignment.center,
    children: [
      BottomAppBar(
        height: 70,
        color: Colors.white,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: NavItem.values.asMap().entries.expand((entry) {
              final index = entry.key;
              final item = entry.value;
              final selected = index == controller.currentIndex.value;
              final navButton = _NavButton(
                icon: item.iconData,
                selected: selected,
                onTap: () => controller.changeTab(index),
              );
              if (index == 1) {
                return [navButton];
              } else {
                return [navButton];
              }
            }).toList(),
          ),
        ),
      ),
      Positioned(
        top: 10,
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRouter.routerCreat_product);
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorOrange,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    ],
  );
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: selected ? 30 : 0,
              decoration: BoxDecoration(
                color: selected ? AppColors.colorOrange : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBoxCustom.h6,
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: selected ? AppColors.colorOrange : Colors.grey,
                size: selected ? 26 : 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum NavItem {
  home(Icons.home_outlined, '/'),
  profile(Icons.person_outline, '/profile');

  const NavItem(this.iconData, this.route);

  final IconData iconData;
  final String route;

  Icon icon(ColorScheme scheme, {bool selected = false}) => Icon(
    iconData,
    color: selected ? AppColors.colorOrange : scheme.onSurfaceVariant,
  );
}
