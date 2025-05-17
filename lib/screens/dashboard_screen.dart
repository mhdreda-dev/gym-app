// dashboard_screen.dart
import 'package:flutter/material.dart';

import '../widgets/nutrition_summary_card.dart';
import '../widgets/progress_card.dart';
import '../widgets/upcoming_session_card.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Coach Fitness'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Afficher les notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salutation personnalisée
            Text(
              'Bonjour, Thomas!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Prêt pour votre entraînement aujourd\'hui?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Carte de progression
            Text(
              'Vos objectifs',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ProgressCard(
              title: 'Perte de poids',
              current: 3.5,
              target: 10,
              unit: 'kg',
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            ProgressCard(
              title: 'Séances complétées',
              current: 12,
              target: 20,
              unit: 'séances',
              color: Colors.green,
            ),

            const SizedBox(height: 24),

            // Prochaine séance
            Text(
              'Prochaine séance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            UpcomingSessionCard(
              title: 'Entraînement Full Body',
              time: 'Aujourd\'hui, 18:00',
              duration: '45 min',
              coachName: 'Coach Sarah',
              onTap: () {
                // Naviguer vers le détail de la séance
              },
            ),

            const SizedBox(height: 24),

            // Résumé nutritionnel
            Text(
              'Nutrition aujourd\'hui',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            NutritionSummaryCard(
              calories: {'consommées': 1200, 'objectif': 2000},
              macros: {'Protéines': 45, 'Glucides': 30, 'Lipides': 25},
              onTap: () {
                // Naviguer vers la page de nutrition
              },
            ),

            const SizedBox(height: 24),

            // Conseil du jour
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Conseil du jour',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'N\'oubliez pas de vous hydrater suffisamment pendant vos séances d\'entraînement. Visez 500ml d\'eau pendant votre séance d\'aujourd\'hui.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
