import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkoutProgramScreen extends StatefulWidget {
  const WorkoutProgramScreen({Key? key}) : super(key: key);

  @override
  _WorkoutProgramScreenState createState() => _WorkoutProgramScreenState();
}

class _WorkoutProgramScreenState extends State<WorkoutProgramScreen>
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
        title: const Text('Programmes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Afficher les options de filtrage
              showModalBottomSheet(
                context: context,
                builder: (context) => const FilterSheet(),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'En cours'),
            Tab(text: 'Planifiés'),
            Tab(text: 'Terminés'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivePrograms(),
          _buildScheduledPrograms(),
          _buildCompletedPrograms(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => const ProgramDetailsScreen(isNewProgram: true),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Créer un nouveau programme',
      ),
    );
  }

  Widget _buildActivePrograms() {
    final programs = [
      {
        'title': 'Prise de masse',
        'progress': 0.65,
        'days': '12 jours restants',
        'image': 'assets/images/strength.jpg',
        'color': Colors.blue,
      },
      {
        'title': 'Cardio & Endurance',
        'progress': 0.32,
        'days': '18 jours restants',
        'image': 'assets/images/cardio.jpg',
        'color': Colors.orange,
      },
    ];

    return _buildProgramsList(programs);
  }

  Widget _buildScheduledPrograms() {
    final programs = [
      {
        'title': 'HIIT Intensif',
        'progress': 0.0,
        'days': 'Commence dans 8 jours',
        'image': 'assets/images/hiit.jpg',
        'color': Colors.red,
      },
      {
        'title': 'Récupération active',
        'progress': 0.0,
        'days': 'Commence dans 22 jours',
        'image': 'assets/images/recovery.jpg',
        'color': Colors.green,
      },
    ];

    return _buildProgramsList(programs);
  }

  Widget _buildCompletedPrograms() {
    final programs = [
      {
        'title': 'Remise en forme',
        'progress': 1.0,
        'days': 'Terminé le 15/05/2025',
        'image': 'assets/images/fitness.jpg',
        'color': Colors.purple,
      },
      {
        'title': 'Préparation marathon',
        'progress': 1.0,
        'days': 'Terminé le 23/04/2025',
        'image': 'assets/images/marathon.jpg',
        'color': Colors.teal,
      },
    ];

    return _buildProgramsList(programs);
  }

  Widget _buildProgramsList(List<Map<String, dynamic>> programs) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        return ProgramCard(
          title: program['title'] as String,
          progress: program['progress'] as double,
          days: program['days'] as String,
          image: program['image'] as String,
          color: program['color'] as Color,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProgramDetailsScreen(isNewProgram: false),
              ),
            );
          },
        );
      },
    );
  }
}

class ProgramCard extends StatelessWidget {
  final String title;
  final double progress;
  final String days;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const ProgramCard({
    Key? key,
    required this.title,
    required this.progress,
    required this.days,
    required this.image,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.darken,
                  child: Image.asset(
                    image,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    days,
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 5.0,
                    percent: progress,
                    center: Text('${(progress * 100).toInt()}%'),
                    progressColor: color,
                    backgroundColor: Colors.grey[300],
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 1200,
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

class FilterSheet extends StatelessWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filtrer les programmes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text('Type de programme'),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('Force'),
                onSelected: (bool value) {},
              ),
              FilterChip(
                label: const Text('Cardio'),
                onSelected: (bool value) {},
              ),
              FilterChip(
                label: const Text('Flexibilité'),
                onSelected: (bool value) {},
              ),
              FilterChip(
                label: const Text('HIIT'),
                onSelected: (bool value) {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Durée'),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('< 2 semaines'),
                onSelected: (bool value) {},
              ),
              FilterChip(
                label: const Text('2-4 semaines'),
                onSelected: (bool value) {},
              ),
              FilterChip(
                label: const Text('> 4 semaines'),
                onSelected: (bool value) {},
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Réinitialiser'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Appliquer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgramDetailsScreen extends StatefulWidget {
  final bool isNewProgram;

  const ProgramDetailsScreen({Key? key, required this.isNewProgram})
    : super(key: key);

  @override
  _ProgramDetailsScreenState createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _programName;
  String? _programType;
  int _duration = 4; // en semaines
  int _sessionsPerWeek = 3;

  final List<String> _programTypes = [
    'Force et Musculation',
    'Cardio et Endurance',
    'Perte de poids',
    'HIIT',
    'Flexibilité',
    'Récupération',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isNewProgram ? 'Nouveau programme' : 'Détails du programme',
        ),
        actions: [
          if (!widget.isNewProgram)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Mode édition
              },
            ),
        ],
      ),
      body:
          widget.isNewProgram ? _buildNewProgramForm() : _buildProgramDetails(),
      floatingActionButton:
          widget.isNewProgram
              ? FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Sauvegarder le nouveau programme
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.save),
              )
              : null,
    );
  }

  Widget _buildNewProgramForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom du programme',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom pour le programme';
                }
                return null;
              },
              onSaved: (value) {
                _programName = value;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Type de programme',
                border: OutlineInputBorder(),
              ),
              items:
                  _programTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _programType = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner un type de programme';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Durée du programme (semaines)'),
            Slider(
              value: _duration.toDouble(),
              min: 1,
              max: 12,
              divisions: 11,
              label: _duration.toString(),
              onChanged: (double value) {
                setState(() {
                  _duration = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Nombre de séances par semaine'),
            Slider(
              value: _sessionsPerWeek.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              label: _sessionsPerWeek.toString(),
              onChanged: (double value) {
                setState(() {
                  _sessionsPerWeek = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Exercices du programme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Placeholder pour la liste des exercices
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text('Exercice ${index + 1}'),
                    subtitle: const Text('Appuyez pour ajouter des détails'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Ouvrir un écran pour configurer l'exercice
                    },
                  ),
                );
              },
            ),
            Center(
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Ajouter un exercice'),
                onPressed: () {
                  // Ouvrir l'écran de recherche d'exercices
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramDetails() {
    // Exemple de données pour un programme existant
    const programName = 'Prise de masse';
    const programType = 'Force et Musculation';
    const duration = '4 semaines';
    const startDate = '01/05/2025';
    const endDate = '29/05/2025';

    final workoutSessions = [
      {
        'day': 'Lundi',
        'focus': 'Haut du corps',
        'exercises': 6,
        'duration': '45 min',
      },
      {
        'day': 'Mercredi',
        'focus': 'Bas du corps',
        'exercises': 5,
        'duration': '40 min',
      },
      {
        'day': 'Vendredi',
        'focus': 'Full body',
        'exercises': 8,
        'duration': '55 min',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête du programme
          const Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    programName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    programType,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Durée'),
                          Text(
                            duration,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date de début'),
                          Text(
                            startDate,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date de fin'),
                          Text(
                            endDate,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Progression du programme
          const Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progression',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 10,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('65% complété'), Text('12 jours restants')],
                  ),
                ],
              ),
            ),
          ),

          // Sessions d'entraînement
          const Text(
            'Sessions d\'entraînement',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.only(bottom: 8),
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workoutSessions.length,
            itemBuilder: (context, index) {
              final session = workoutSessions[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(session['day']!.substring(0, 2)),
                  ),
                  title: Text(session['day'] as String),
                  subtitle: Text(
                    '${session['focus']} • ${session['exercises']} exercices',
                  ),
                  trailing: Text(session['duration'] as String),
                  onTap: () {
                    // Ouvrir les détails de la session
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SessionDetailScreen(),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Boutons d'action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Commencer la séance'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  // Démarrer la prochaine séance planifiée
                },
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Partager'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  // Partager le programme
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exemple de données pour une session d'entraînement
    const sessionTitle = 'Séance du Lundi - Haut du corps';
    final exercises = [
      {
        'name': 'Développé couché',
        'sets': 4,
        'reps': '10-12',
        'rest': '90s',
        'image': 'assets/images/bench_press.jpg',
      },
      {
        'name': 'Tirage vertical',
        'sets': 3,
        'reps': '12-15',
        'rest': '60s',
        'image': 'assets/images/lat_pulldown.jpg',
      },
      {
        'name': 'Développé épaules',
        'sets': 3,
        'reps': '10-12',
        'rest': '90s',
        'image': 'assets/images/shoulder_press.jpg',
      },
      {
        'name': 'Curl biceps',
        'sets': 3,
        'reps': '12-15',
        'rest': '60s',
        'image': 'assets/images/bicep_curl.jpg',
      },
      {
        'name': 'Extension triceps',
        'sets': 3,
        'reps': '12-15',
        'rest': '60s',
        'image': 'assets/images/tricep_extension.jpg',
      },
      {
        'name': 'Gainage planche',
        'sets': 3,
        'reps': '30-45s',
        'rest': '30s',
        'image': 'assets/images/plank.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(sessionTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Éditer la séance
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoCard(
                  icon: Icons.fitness_center,
                  title: '6',
                  subtitle: 'Exercices',
                ),
                _InfoCard(
                  icon: Icons.timer,
                  title: '45 min',
                  subtitle: 'Durée',
                ),
                _InfoCard(
                  icon: Icons.local_fire_department,
                  title: '350',
                  subtitle: 'Calories',
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(exercise['image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      exercise['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${exercise['sets']} séries × ${exercise['reps']} répétitions',
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Instructions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Maintenez une bonne forme tout au long du mouvement. Expirez pendant l\'effort et inspirez pendant la phase négative.',
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _ExerciseDetail(
                                  label: 'Séries',
                                  value: '${exercise['sets']}',
                                ),
                                _ExerciseDetail(
                                  label: 'Répétitions',
                                  value: exercise['reps'] as String,
                                ),
                                _ExerciseDetail(
                                  label: 'Repos',
                                  value: exercise['rest'] as String,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.videocam),
                                  label: const Text('Voir la vidéo'),
                                  onPressed: () {
                                    // Afficher la vidéo démonstrative
                                  },
                                ),
                                const SizedBox(width: 16),
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.history),
                                  label: const Text('Historique'),
                                  onPressed: () {
                                    // Afficher l'historique des performances
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            // Démarrer la séance
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ActiveWorkoutScreen(),
              ),
            );
          },
          child: const Text(
            'DÉMARRER LA SÉANCE',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
      ],
    );
  }
}

class _ExerciseDetail extends StatelessWidget {
  final String label;
  final String value;

  const _ExerciseDetail({Key? key, required this.label, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

class _WorkoutInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _WorkoutInfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutSummaryScreen extends StatelessWidget {
  const WorkoutSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résumé de la séance'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec félicitations
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'Séance terminée !',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Félicitations pour votre travail aujourd\'hui !',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SummaryNumberWidget(
                        value: '45',
                        unit: 'min',
                        label: 'Durée',
                      ),
                      _SummaryNumberWidget(
                        value: '6',
                        unit: '',
                        label: 'Exercices',
                      ),
                      _SummaryNumberWidget(
                        value: '350',
                        unit: 'kcal',
                        label: 'Calories',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Graphique de performance
            const Text(
              'Performance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const SizedBox(
              height: 200,
              child: Placeholder(
                // Dans une application réelle, vous utiliseriez une bibliothèque comme fl_chart
                // pour afficher un graphique de performance
                color: Colors.blue,
                fallbackHeight: 200,
                strokeWidth: 2,
              ),
            ),

            const SizedBox(height: 24),

            // Résumé des exercices
            const Text(
              'Exercices complétés',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                final exercises = [
                  'Développé couché',
                  'Tirage vertical',
                  'Développé épaules',
                  'Curl biceps',
                  'Extension triceps',
                  'Gainage planche',
                ];

                final performances = [
                  '4 × 12 × 60kg',
                  '3 × 15 × 50kg',
                  '3 × 12 × 40kg',
                  '3 × 15 × 15kg',
                  '3 × 12 × 25kg',
                  '3 × 45s',
                ];

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(exercises[index]),
                    subtitle: Text(performances[index]),
                    trailing: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Commentaires et notes
            const Text(
              'Commentaires',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Ajouter des commentaires sur votre séance...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Noter votre séance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: index < 4 ? Colors.amber : Colors.grey,
                    size: 32,
                  ),
                  onPressed: () {
                    // Logique de notation
                  },
                );
              }),
            ),

            const SizedBox(height: 24),

            // Boutons d'action
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.share),
                    label: const Text('Partager'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      // Logique de partage
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.home),
                    label: const Text('Terminer'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryNumberWidget extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const _SummaryNumberWidget({
    Key? key,
    required this.value,
    required this.unit,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: unit, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
      ],
    );
  }
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int _currentExerciseIndex = 0;
  bool _isResting = false;
  int _remainingRestTime = 90; // en secondes
  final int _totalExercises = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Séance en cours'),
        backgroundColor:
            _isResting ? Colors.orange : Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: () {
              // Mettre la séance en pause
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Mettre en pause'),
                      content: const Text(
                        'Voulez-vous mettre la séance en pause?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Non'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Logique de pause ici
                          },
                          child: const Text('Oui'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: _isResting ? _buildRestView() : _buildExerciseView(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildExerciseView() {
    // Exemple d'exercice en cours
    const exerciseName = 'Développé couché';
    const currentSet = 2;
    const totalSets = 4;
    const reps = '10-12';

    return Column(
      children: [
        // Indicateur de progression
        LinearProgressIndicator(
          value: (_currentExerciseIndex + 1) / _totalExercises,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Exercice ${_currentExerciseIndex + 1}/$_totalExercises'),
              const Text('15:32 écoulées'),
            ],
          ),
        ),
        const Divider(),
        // Image démonstrative de l'exercice
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bench_press.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        // Informations sur l'exercice
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  exerciseName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Maintenez une bonne forme. Expirez pendant l\'effort et inspirez pendant la descente.',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _WorkoutInfoCard(
                      title: 'Série',
                      value: '$currentSet / $totalSets',
                      color: Colors.blue,
                    ),
                    _WorkoutInfoCard(
                      title: 'Répétitions',
                      value: reps,
                      color: Colors.green,
                    ),
                    _WorkoutInfoCard(
                      title: 'Repos',
                      value: '90s',
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'REPOS',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: _remainingRestTime / 90,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                strokeWidth: 8,
                backgroundColor: Colors.grey[300],
              ),
              Text(
                '$_remainingRestTime',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text('Prochain exercice:', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
            'Tirage vertical',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isResting = false;
                _currentExerciseIndex++;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('PASSER LE REPOS'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    if (_isResting) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Abandonner la séance
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Abandonner la séance'),
                          content: const Text(
                            'Êtes-vous sûr de vouloir abandonner cette séance ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Non'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Oui'),
                            ),
                          ],
                        ),
                  );
                },
                child: const Text('ABANDONNER'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  setState(() {
                    _isResting = true;
                  });

                  // Timer pour le repos (dans un vrai app, utiliser un vrai timer)
                  Future.delayed(const Duration(seconds: 5), () {
                    if (mounted) {
                      setState(() {
                        _isResting = false;
                        // Si c'était la dernière série du dernier exercice, terminer la séance
                        if (_currentExerciseIndex >= _totalExercises - 1) {
                          // Afficher l'écran de résumé de séance
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const WorkoutSummaryScreen(),
                            ),
                          );
                        }
                      });
                    }
                  });
                },
                child: const Text('TERMINER SÉRIE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
