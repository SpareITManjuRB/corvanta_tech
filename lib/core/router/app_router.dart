import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/presentation/pages/about_page.dart';
import '../../features/admin/presentation/pages/admin_placeholder_page.dart';
import '../../features/blog/presentation/pages/blog_page.dart';
import '../../features/careers/presentation/pages/careers_page.dart';
import '../../features/case_studies/presentation/pages/case_studies_page.dart';
import '../../features/client_portal/presentation/pages/client_portal_placeholder_page.dart';
import '../../features/consulting/presentation/pages/consulting_page.dart';
import '../../features/contact/presentation/pages/contact_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../animations/animated_background.dart';
import '../animations/page_transitions.dart';
import '../widgets/app_navbar.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _AppShell(
        key: ValueKey(state.uri.path),
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: '/services',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const ServicesPage(),
          ),
        ),
        GoRoute(
          path: '/case-studies',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const CaseStudiesPage(),
          ),
        ),
        GoRoute(
          path: '/consulting',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const ConsultingPage(),
          ),
        ),
        GoRoute(
          path: '/contact',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const ContactPage(),
          ),
        ),
        GoRoute(
          path: '/about',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const AboutPage(),
          ),
        ),
        GoRoute(
          path: '/careers',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const CareersPage(),
          ),
        ),
        GoRoute(
          path: '/blog',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const BlogPage(),
          ),
        ),
        // Future-ready placeholders
        GoRoute(
          path: '/admin',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const AdminPlaceholderPage(),
          ),
        ),
        GoRoute(
          path: '/portal',
          pageBuilder: (context, state) => FadeSlideTransitionPage(
            key: state.pageKey,
            child: const ClientPortalPlaceholderPage(),
          ),
        ),
      ],
    ),
  ],
);

/// App shell with scroll-to-top on route change.
class _AppShell extends StatefulWidget {
  const _AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant _AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to top when route changes (key changes)
    if (widget.key != oldWidget.key) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const AppNavbar(),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBackground(
              scrollController: _scrollController,
            ),
          ),
          PrimaryScrollController(
            controller: _scrollController,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
