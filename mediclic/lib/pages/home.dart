import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {  // Added generic type to fix error
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Added SingleChildScrollView to fix overflow issues
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(  // Added const
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/31035109/pexels-photo-31035109.jpeg"),
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Good Morning',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Thomas Dossa',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {},
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // PageView pour défiler les actualités (bannières)
                // Reduced height to fix overflow
                SizedBox(
                  height: 140,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          return child!;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.purple[300] : Colors.blue[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: index == 0 
                              ? _buildMedicalChecksBanner() 
                              : _buildGenericBanner(index),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 10),
                // Indicateurs de page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index 
                            ? Colors.blue 
                            : Colors.grey[300],
                      ),
                    );
                  }),
                ),
                
                const SizedBox(height: 20),
                // Rangée de boutons pour les services
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildServiceButton("Spécialistes", Icons.people, Colors.amber[100]!, Colors.amber),
                    _buildServiceButton("Rendez-vous", Icons.calendar_today, Colors.red[100]!, Colors.red),
                    _buildServiceButton("Dossier", Icons.folder, Colors.blue[100]!, Colors.blue),
                  ],
                ),
                
                const SizedBox(height: 25),
                // Section des prochains rendez-vous
                const Text(
                  'Prochain rendez-vous',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 15),
                // Cartes des rendez-vous - Reduced content to avoid overflow
                _buildAppointmentCard(
                  "Dr. Marie Martin",
                  "Cardiologue",
                  "Lundi 10 Mars",
                  "14h00",
                  Colors.pink[100]!,
                ),
                
                const SizedBox(height: 10),
                _buildAppointmentCard(
                  "Dr. Pierre Dupont",  // Fixed typo in the name
                  "Cardiologue",
                  "Lundi 13 Mars",
                  "15h00",
                  Colors.blue[100]!,
                ),
                
                const SizedBox(height: 20),
                // Bouton IA pour discuter
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.smart_toy),
                    label: const Text(
                      'Discuter avec IA',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                // Added padding at the bottom to ensure no overflow
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  
  Widget _buildMedicalChecksBanner() {
    return Padding(
      padding: const EdgeInsets.all(12.0),  
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Medical Checks !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,  
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),  
                Text(
                  'Health checks & consultations easily anywhere anytime',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 11,  // Reduced font size
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),  // Reduced padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Check Now'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/3774/3774299.png',
              height: 80,  // Reduced height
            ),
          ),
        ],
      ),
    );
  }
  
  
  Widget _buildGenericBanner(int index) {
    List<Map<String, dynamic>> bannerData = [
      {}, // 0 est la bannière Medical Checks, déjà traitée
      {
        'title': 'Téléconsultations',
        'subtitle': 'Consultez un médecin depuis votre domicile',
        'buttonText': 'Réserver',
        'imageUrl': 'https://cdn-icons-png.flaticon.com/512/3063/3063627.png',
      },
      {
        'title': 'Santé connectée',
        'subtitle': 'Suivez vos données de santé en temps réel',
        'buttonText': 'Découvrir',
        'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2491/2491418.png',
      },
    ];
    
    Map<String, dynamic> data = bannerData[index];
    
    return Padding(
      padding: const EdgeInsets.all(12.0),  
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,  // Reduced font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),  // Reduced spacing
                Text(
                  data['subtitle'],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 11,  // Reduced font size
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),  // Reduced padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: Text(data['buttonText']),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.network(
              data['imageUrl'],
              height: 80,  // Reduced height
            ),
          ),
        ],
      ),
    );
  }
  
 
  Widget _buildServiceButton(String label, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 100,
      height: 95,  // Slightly reduced height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,  // Reduced radius
            backgroundColor: bgColor,
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 6),  // Reduced spacing
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  
  Widget _buildAppointmentCard(String doctorName, String specialty, String date, String time, Color avatarColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),  // Reduced padding
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: avatarColor,
            radius: 22,  // Reduced radius
            child: const Icon(Icons.person, color: Colors.white, size: 20),  // Reduced icon size
          ),
          const SizedBox(width: 15),
          Expanded( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,  // Reduced font size
                  ),
                ),
                Text(
                  specialty,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,  // Reduced font size
                  ),
                ),
                const SizedBox(height: 3),  // Reduced spacing
                Text(
                  '$date · $time',  // Fixed dot character
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 12,  // Reduced font size
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}