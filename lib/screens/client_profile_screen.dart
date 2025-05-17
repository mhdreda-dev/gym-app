// client_profile_screen.dart
import 'package:flutter/material.dart';

class ClientProfileScreen extends StatefulWidget {
  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Naviguer vers les paramètres
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Informations'),
            Tab(text: 'Objectifs'),
            Tab(text: 'Mensurations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildInfoTab(), _buildGoalsTab(), _buildMeasurementsTab()],
      ),
    );
  }

  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_placeholder.png'),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 20,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      // Changer la photo de profil
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildInfoItem('Nom', 'Thomas Durand', Icons.person),
        _buildInfoItem('Âge', '32 ans', Icons.cake),
        _buildInfoItem('Taille', '180 cm', Icons.height),
        _buildInfoItem('Poids actuel', '82 kg', Icons.monitor_weight),
        _buildInfoItem('Email', 'thomas.durand@example.com', Icons.email),
        _buildInfoItem('Téléphone', '+33 6 12 34 56 78', Icons.phone),
        const SizedBox(height: 16),
        _buildSectionTitle('Informations médicales'),
        _buildInfoItem('Groupe sanguin', 'A+', Icons.bloodtype),
        _buildInfoItem('Allergies', 'Aucune', Icons.warning),
        _buildInfoItem('Blessures', 'Épaule droite (2022)', Icons.healing),
        const SizedBox(height: 16),
        _buildSectionTitle('Préférences d\'entraînement'),
        _buildInfoItem('Jours préférés', 'Lun, Mer, Ven', Icons.calendar_today),
        _buildInfoItem('Heures préférées', '18:00 - 20:00', Icons.access_time),
        _buildInfoItem(
          'Type préféré',
          'Force & Musculation',
          Icons.fitness_center,
        ),
      ],
    );
  }

  Widget _buildGoalsTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionTitle('Objectifs principaux'),
        _buildGoalCard(
          title: 'Perte de poids',
          description: 'Objectif: -10kg',
          startDate: '01/03/2025',
          targetDate: '15/08/2025',
          progress: 0.35,
          color: Colors.blue,
        ),
        _buildGoalCard(
          title: 'Augmentation de la masse musculaire',
          description: 'Focus sur le haut du corps',
          startDate: '01/03/2025',
          targetDate: '31/12/2025',
          progress: 0.2,
          color: Colors.green,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Objectifs spécifiques'),
        CheckboxListTile(
          title: Text('Courir 5km sans arrêt'),
          subtitle: Text('À réaliser avant le 30/06/2025'),
          value: false,
          onChanged: (value) {},
          activeColor: Theme.of(context).primaryColor,
        ),
        CheckboxListTile(
          title: Text('Faire 10 tractions'),
          subtitle: Text('À réaliser avant le 31/07/2025'),
          value: false,
          onChanged: (value) {},
          activeColor: Theme.of(context).primaryColor,
        ),
        CheckboxListTile(
          title: Text('Squatter 100kg'),
          subtitle: Text('À réaliser avant le 31/12/2025'),
          value: false,
          onChanged: (value) {},
          activeColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Ajouter un objectif'),
          onPressed: () {
            // Ouvrir le dialogue d'ajout d'objectif
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildMeasurementsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle('Historique des mensurations'),
              TextButton.icon(
                icon: Icon(Icons.add),
                label: Text('Ajouter'),
                onPressed: () {
                  // Ouvrir dialogue d'ajout de mensuration
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Graphique d'évolution du poids (placeholder)
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text('Graphique d\'évolution du poids')),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Dernières mensurations (15/05/2025)'),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildMeasurementCard('Poids', '82 kg'),
                _buildMeasurementCard('% Graisse', '18%'),
                _buildMeasurementCard('Tour de poitrine', '100 cm'),
                _buildMeasurementCard('Tour de bras', '35 cm'),
                _buildMeasurementCard('Tour de taille', '88 cm'),
                _buildMeasurementCard('Tour de cuisses', '58 cm'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(value, style: TextStyle(fontSize: 16)),
            ],
          ),
          Spacer(),
          Icon(Icons.edit, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required String title,
    required String description,
    required String startDate,
    required String targetDate,
    required double progress,
    required Color color,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Début: $startDate',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                Text(
                  'Objectif: $targetDate',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementCard(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
