// programs_screen.dart
import 'package:flutter/material.dart';

class ProgramsScreen extends StatefulWidget {
  @override
  _ProgramsScreenState createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  final List<Map<String, dynamic>> _programs = [
    {
      'id': 1,
      'title': 'Programme perte de poids',
      'description':
          'Entraînements HIIT et cardio pour maximiser la perte de poids',
      'duration': '12 semaines',
      'category': 'Perte de poids',
      'level': 'Intermédiaire',
      'sessions': 36,
      'progress': 0.25,
      'image': 'assets/weight_loss.jpg',
      'color': Colors.orange,
      'isActive': true,
    },
    {
      'id': 2,
      'title': 'Full Body - Force',
      'description': 'Développement de la force sur l\'ensemble du corps',
      'duration': '8 semaines',
      'category': 'Musculation',
      'level': 'Avancé',
      'sessions': 24,
      'progress': 0.0,
      'image': 'assets/strength.jpg',
      'color': Colors.blue,
      'isActive': false,
    },
    {
      'id': 3,
      'title': 'Mobilité & Récupération',
      'description':
          'Exercices pour améliorer la mobilité et accélérer la récupération',
      'duration': '4 semaines',
      'category': 'Bien-être',
      'level': 'Tous niveaux',
      'sessions': 12,
      'progress': 0.0,
      'image': 'assets/mobility.jpg',
      'color': Colors.green,
      'isActive': false,
    },
    {
      'id': 4,
      'title': 'Programme débutant',
      'description': 'Introduction au fitness et aux mouvements fondamentaux',
      'duration': '6 semaines',
      'category': 'Débutant',
      'level': 'Débutant',
      'sessions': 18,
      'progress': 0.0,
      'image': 'assets/beginner.jpg',
      'color': Colors.purple,
      'isActive': false,
    },
  ];

  String _selectedFilter = 'Tous';
  final List<String> _filters = [
    'Tous',
    'Actifs',
    'Perte de poids',
    'Musculation',
    'Bien-être',
    'Débutant',
  ];

  List<Map<String, dynamic>> get _filteredPrograms {
    if (_selectedFilter == 'Tous') {
      return _programs;
    } else if (_selectedFilter == 'Actifs') {
      return _programs.where((program) => program['isActive'] == true).toList();
    } else {
      return _programs
          .where((program) => program['category'] == _selectedFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implémenter la recherche
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtres horizontaux
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;

                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      }
                    },
                    selectedColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.8),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Liste des programmes
          Expanded(
            child:
                _filteredPrograms.isEmpty
                    ? Center(child: Text('Aucun programme trouvé'))
                    : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _filteredPrograms.length,
                      itemBuilder: (context, index) {
                        final program = _filteredPrograms[index];
                        return _buildProgramCard(program);
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers l'écran de création de programme
        },
        child: Icon(Icons.add),
        tooltip: 'Créer un programme',
      ),
    );
  }

  Widget _buildProgramCard(Map<String, dynamic> program) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Naviguer vers le détail du programme
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec image (placeholder)
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: program['color'].withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.fitness_center,
                      size: 48,
                      color: program['color'],
                    ),
                  ),
                  if (program['isActive'])
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'ACTIF',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Contenu du programme
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: program['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          program['category'],
                          style: TextStyle(
                            color: program['color'],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          program['level'],
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    program['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    program['description'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4),
                      Text(
                        program['duration'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.fitness_center,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${program['sessions']} séances',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  // Barre de progression
                  if (program['progress'] > 0) ...[
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: program['progress'],
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              program['color'],
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${(program['progress'] * 100).toInt()}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: program['color'],
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Boutons d'action
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!program['isActive'])
                        TextButton.icon(
                          icon: Icon(Icons.play_arrow),
                          label: Text('Commencer'),
                          onPressed: () {
                            // Activer le programme
                          },
                        )
                      else
                        TextButton.icon(
                          icon: Icon(Icons.pause),
                          label: Text('Mettre en pause'),
                          onPressed: () {
                            // Mettre le programme en pause
                          },
                        ),
                      SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: Icon(Icons.visibility),
                        label: Text('Détails'),
                        onPressed: () {
                          // Voir les détails du programme
                        },
                      ),
                    ],
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
