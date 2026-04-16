StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/charities',
      builder: (context, state) => const CharityView(),
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) => const CharityDetelsView(),
          
        ),
      ],
    ),
  ],
),   



IconButton(
  onPressed: () {
    context.push('/charities/details');
  },
  icon: Icon(Icons.arrow_forward_ios_outlined),
),