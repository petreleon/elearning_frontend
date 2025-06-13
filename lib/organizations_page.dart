import 'package:flutter/material.dart';
import 'models.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Technology',
    'Business',
    'Education',
    'Healthcare',
    'Arts',
    'Science'
  ];

  final List<Organization> allOrganizations = [
    Organization(
      id: '1',
      name: 'Tech Academy',
      description: 'Leading provider of technology courses and certifications',
      imageUrl: 'https://via.placeholder.com/150',
      courseCount: 45,
      categories: ['Technology'],
    ),
    Organization(
      id: '2',
      name: 'Business Institute',
      description: 'Professional business training and development programs',
      imageUrl: 'https://via.placeholder.com/150',
      courseCount: 32,
      categories: ['Business'],
    ),
    Organization(
      id: '3',
      name: 'Creative Arts Center',
      description:
          'Unleash your creativity with our comprehensive arts programs',
      imageUrl: 'https://via.placeholder.com/150',
      courseCount: 28,
      categories: ['Arts'],
    ),
    Organization(
      id: '4',
      name: 'Medical Training Hub',
      description: 'Advanced medical education and healthcare training',
      imageUrl: 'https://via.placeholder.com/150',
      courseCount: 38,
      categories: ['Healthcare'],
    ),
    Organization(
      id: '5',
      name: 'Science Research Academy',
      description: 'Cutting-edge scientific research and education programs',
      imageUrl: 'https://via.placeholder.com/150',
      courseCount: 41,
      categories: ['Science'],
    ),
    Organization(
      id: '6',
      name: 'Global Education Network',
      description: 'International education standards and multilingual courses',
      imageUrl: 'https://via.placeholder.com/150',
      courseCount: 67,
      categories: ['Education', 'Technology'],
    ),
  ];

  List<Organization> get filteredOrganizations {
    return allOrganizations.where((org) {
      final matchesSearch =
          org.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              org.description.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'All' ||
          org.categories.contains(selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search organizations...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                );
              },
            ),
          ),

          // Organizations List
          Expanded(
            child: filteredOrganizations.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No organizations found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrganizations.length,
                    itemBuilder: (context, index) {
                      final organization = filteredOrganizations[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/organization-detail',
                              arguments: organization,
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Organization Logo
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Icon(
                                    Icons.business,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Organization Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        organization.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        organization.description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.book,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${organization.courseCount} courses',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Arrow Icon
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
