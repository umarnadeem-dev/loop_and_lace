import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialBio;
  final String initialCity;
  final String initialPhone;
  final VoidCallback onBack;
  final Function(String name, String bio, String city, String phone) onSave;

  const EditProfileScreen({
    super.key,
    this.initialName = 'Arbab Jabeen',
    this.initialBio = 'Crochet lover & amigurumi enthusiast',
    this.initialCity = 'Lahore',
    this.initialPhone = '+92 300 4567890',
    required this.onBack,
    required this.onSave,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  late String _selectedCity;
  String _skillLevel = 'Beginner';
  String _favCategory = 'Amigurumi';

  final List<String> _cities = [
    'Lahore',
    'Karachi',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
  ];

  final List<String> _skills = ['Beginner', 'Intermediate', 'Advanced Crafter'];
  final List<String> _categories = ['Amigurumi', 'Wearables', 'Blankets', 'Bags'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _bioController = TextEditingController(text: widget.initialBio);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _selectedCity = widget.initialCity;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
          onPressed: widget.onBack,
        ),
        title: Text(
          'Edit Profile',
          style: AppTypography.serif(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar circle with camera edit badge
              Stack(
                children: [
                  Container(
                    width: 86,
                    height: 86,
                    decoration: const BoxDecoration(
                      color: AppColors.blush,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : 'A',
                        style: AppTypography.serif(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Inputs
              _buildFieldCard(
                label: 'Full Name',
                controller: _nameController,
                hint: 'Your name',
              ),
              const SizedBox(height: 14),

              _buildFieldCard(
                label: 'Bio / Craft Status',
                controller: _bioController,
                hint: 'e.g. Crochet lover • Lahore',
                maxLines: 2,
              ),
              const SizedBox(height: 14),

              _buildFieldCard(
                label: 'Phone Number',
                controller: _phoneController,
                hint: '+92 300 0000000',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),

              // City Dropdown Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City',
                      style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCity,
                        isExpanded: true,
                        items: _cities.map((c) {
                          return DropdownMenuItem(
                            value: c,
                            child: Text(c, style: AppTypography.sans(fontSize: 13, color: AppColors.textPrimary)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedCity = val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Crochet Skill Level
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Crochet Skill Level',
                  style: AppTypography.serif(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: _skills.map((skill) {
                  final isSel = _skillLevel == skill;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(skill),
                      selected: isSel,
                      onSelected: (val) {
                        if (val) setState(() => _skillLevel = skill);
                      },
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.primary,
                      labelStyle: AppTypography.sans(
                        fontSize: 11,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                        color: isSel ? Colors.white : AppColors.textPrimary,
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Favorite Category
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favorite Projects',
                  style: AppTypography.serif(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: _categories.map((cat) {
                  final isSel = _favCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSel,
                      onSelected: (val) {
                        if (val) setState(() => _favCategory = cat);
                      },
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.sage,
                      labelStyle: AppTypography.sans(
                        fontSize: 11,
                        fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                        color: isSel ? Colors.white : AppColors.textPrimary,
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSave(
                      _nameController.text.trim(),
                      _bioController.text.trim(),
                      _selectedCity,
                      _phoneController.text.trim(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully! ✿'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                    widget.onBack();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: AppTypography.sans(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldCard({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: AppTypography.sans(fontSize: 13, color: AppColors.textPrimary),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: AppTypography.sans(fontSize: 12, color: AppColors.textMuted),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 6),
            ),
          ),
        ],
      ),
    );
  }
}

