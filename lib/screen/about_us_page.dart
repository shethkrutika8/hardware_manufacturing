import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const List<_CompanyValue> _values = [
    _CompanyValue(
      icon: Icons.verified_user_outlined,
      title: 'Quality first',
      description:
          'Carefully selected hardware designed to work hard and last.',
    ),
    _CompanyValue(
      icon: Icons.precision_manufacturing_outlined,
      title: 'Built for the job',
      description:
          'Practical tools and supplies for professionals and DIY builders.',
    ),
    _CompanyValue(
      icon: Icons.handshake_outlined,
      title: 'Service you can trust',
      description:
          'Straightforward support from a team that understands your work.',
    ),
    _CompanyValue(
      icon: Icons.trending_up_outlined,
      title: 'Always improving',
      description:
          'We keep looking for better ways to help every project move forward.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BluePageScaffold(
      maxBodyWidth: 1200,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        children: [
          _buildHero(context),
          const SizedBox(height: 32),
          _buildHighlights(context),
          const SizedBox(height: 40),
          _buildStory(context),
          const SizedBox(height: 40),
          _buildMission(context),
          const SizedBox(height: 40),
          _buildValues(context),
          const SizedBox(height: 40),
          _buildClosingCard(context),
          const SizedBox(height: 20),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 700;

    return Container(
      height: isCompact ? 430 : 440,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: kNavy,
        boxShadow: [
          BoxShadow(
            color: kNavy.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const AppAssetImage(
            path: 'assets/images/BuildTech_hardware_picture.png',
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xee061b32),
                  Color(0xc9061b32),
                  Color(0x14061b32),
                ],
                stops: [0, 0.55, 1],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isCompact ? 20 : 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff1678ce).withValues(alpha: 0.28),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xff78bbff).withValues(alpha: 0.6),
                        ),
                      ),
                      child: const Text(
                        'About us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Built on trust.\nMade to last.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isCompact ? 36 : 48,
                        height: 1.05,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Dependable tools and quality hardware for professionals, '
                      'makers, and DIY builders.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: isCompact ? 15 : 17,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 22),
                    FilledButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/products'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xff1683e6),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward, size: 18),
                      label: const Text('Explore our products'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlights(BuildContext context) {
    const highlights = [
      (Icons.verified_outlined, 'Quality you can trust'),
      (Icons.handyman_outlined, 'Tools for every project'),
      (Icons.engineering_outlined, 'Made for professionals'),
      (Icons.home_repair_service_outlined, 'Ready for everyday fixes'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth >= 760
            ? (constraints.maxWidth - 36) / 4
            : (constraints.maxWidth - 12) / 2;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final highlight in highlights)
              Container(
                width: itemWidth,
                constraints: const BoxConstraints(minHeight: 88),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffe2eaf3)),
                ),
                child: Row(
                  children: [
                    Icon(highlight.$1, color: kMidBlue, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        highlight.$2,
                        style: const TextStyle(
                          color: kInk,
                          fontSize: 13,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildStory(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 680;
        final image = ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: isCompact ? 230 : 320,
            width: double.infinity,
            child: const AppAssetImage(
              path: 'assets/images/toolkit.png',
              fit: BoxFit.cover,
            ),
          ),
        );
        final story = _storyCopy();

        return Container(
          padding: EdgeInsets.all(isCompact ? 18 : 26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: kNavy.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [image, const SizedBox(height: 22), story],
                )
              : Row(
                  children: [
                    Expanded(flex: 5, child: image),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: story),
                  ],
                ),
        );
      },
    );
  }

  Widget _storyCopy() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel('WHO WE ARE'),
        SizedBox(height: 10),
        Text(
          'Your partner for getting the job done.',
          style: TextStyle(
            color: kInk,
            fontSize: 26,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'BuildTech Hardware brings together dependable tools and quality '
          'hardware for projects of every size. Whether you work on site or '
          'take on projects at home, we want finding the right essentials to '
          'feel simple and reliable.',
          style: TextStyle(color: Color(0xff596b7b), fontSize: 15, height: 1.7),
        ),
      ],
    );
  }

  Widget _buildMission(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 600;
        final cardWidth = isCompact
            ? constraints.maxWidth
            : (constraints.maxWidth - 16) / 2;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: cardWidth,
              child: _MissionCard(
                icon: Icons.flag_outlined,
                label: 'OUR MISSION',
                title: 'Make reliable hardware easier to find.',
                description:
                    'We provide durable, dependable, and affordable hardware '
                    'that helps professionals and DIY builders get the job done.',
                color: const Color(0xffeaf4ff),
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: _MissionCard(
                icon: Icons.visibility_outlined,
                label: 'OUR PROMISE',
                title: 'Support every project with confidence.',
                description:
                    'From a quick repair to a demanding job, we aim to make '
                    'quality products and helpful service part of the experience.',
                color: const Color(0xffedf8f3),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildValues(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('WHAT MATTERS TO US'),
        const SizedBox(height: 8),
        const Text(
          'Good work starts with good foundations.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth >= 760
                ? (constraints.maxWidth - 36) / 4
                : (constraints.maxWidth - 12) / 2;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final value in _values)
                  SizedBox(
                    width: itemWidth,
                    child: _ValueCard(value: value),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildClosingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      decoration: BoxDecoration(
        color: kNavy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 600;
          final message = const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Have a project in mind?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Find the tools and hardware to help bring it to life.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          );
          final button = OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/products'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xff7dbfff)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Browse products'),
          );

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [message, const SizedBox(height: 18), button],
            );
          }

          return Row(
            children: [
              Expanded(child: message),
              const SizedBox(width: 20),
              button,
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 600;
    final links = Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        _FooterLink(
          label: 'Home',
          onPressed: () => Navigator.pushNamed(context, '/home'),
        ),
        _FooterLink(
          label: 'Products',
          onPressed: () => Navigator.pushNamed(context, '/products'),
        ),
        const _FooterLink(label: 'About us'),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 18 : 24,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff061b32),
        borderRadius: BorderRadius.circular(18),
      ),
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BuildTechLogo(width: 132, height: 40),
                const SizedBox(height: 12),
                const Text(
                  'Dependable hardware for work that lasts.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 16),
                links,
              ],
            )
          : Row(
              children: [
                const BuildTechLogo(width: 132, height: 40),
                const SizedBox(width: 18),
                const Expanded(
                  child: Text(
                    'Dependable hardware for work that lasts.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                links,
              ],
            ),
    );
  }
}

class _CompanyValue {
  const _CompanyValue({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: kMidBlue,
        fontSize: 11,
        letterSpacing: 1.1,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({
    required this.icon,
    required this.label,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 210),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffdce8f2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: kMidBlue),
          const SizedBox(height: 14),
          Text(
            label,
            style: const TextStyle(
              color: kMidBlue,
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: kInk,
              fontSize: 19,
              height: 1.25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xff596b7b),
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({required this.value});

  final _CompanyValue value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 170),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(value.icon, color: kMidBlue, size: 26),
          const SizedBox(height: 12),
          Text(
            value.title,
            style: const TextStyle(
              color: kInk,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value.description,
            style: const TextStyle(
              color: Color(0xff596b7b),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        visualDensity: VisualDensity.compact,
      ),
      child: Text(label),
    );
  }
}
