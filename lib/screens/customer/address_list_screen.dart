import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/app_models.dart';

class AddressListScreen extends StatefulWidget {
  final VoidCallback onBack;

  const AddressListScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  late List<AddressItem> _addresses;

  final List<String> _cities = [
    'Lahore',
    'Karachi',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
    'Sialkot',
    'Gujranwala',
    'Quetta',
  ];

  @override
  void initState() {
    super.initState();
    _addresses = List.from(MockData.savedAddresses);
  }

  void _showAddEditAddressSheet({AddressItem? existingAddress}) {
    final isEditing = existingAddress != null;
    final nameController = TextEditingController(text: existingAddress?.recipientName ?? 'Arbab Jabeen');
    final phoneController = TextEditingController(text: existingAddress?.phone ?? '+92 300 1234567');
    final streetController = TextEditingController(text: existingAddress?.streetAddress ?? '');
    final areaController = TextEditingController(text: existingAddress?.area ?? '');
    final postalController = TextEditingController(text: existingAddress?.postalCode ?? '54000');
    
    String selectedCity = existingAddress?.city ?? 'Lahore';
    String selectedLabel = existingAddress?.label ?? 'Home';
    bool isDefault = existingAddress?.isDefault ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEditing ? 'Edit Address' : 'Add New Address',
                          style: AppTypography.serif(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Label chips
                    Text(
                      'Address Type',
                      style: AppTypography.sans(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: ['Home', 'Studio', 'Work', 'Other'].map((lbl) {
                        final isSel = selectedLabel == lbl;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(lbl),
                            selected: isSel,
                            onSelected: (val) {
                              if (val) setSheetState(() => selectedLabel = lbl);
                            },
                            backgroundColor: AppColors.surfaceWarm,
                            selectedColor: AppColors.primary,
                            labelStyle: AppTypography.sans(
                              fontSize: 12,
                              fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                              color: isSel ? Colors.white : AppColors.textPrimary,
                            ),
                            showCheckmark: false,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // Recipient Name
                    _buildTextField(label: 'Recipient Full Name', controller: nameController),
                    const SizedBox(height: 10),

                    // Phone
                    _buildTextField(label: 'Phone Number (+92)', controller: phoneController, keyboardType: TextInputType.phone),
                    const SizedBox(height: 10),

                    // Street
                    _buildTextField(label: 'Street / House / Building', controller: streetController),
                    const SizedBox(height: 10),

                    // Area & City row
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(label: 'Area / Sector', controller: areaController),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceWarm,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: AppColors.borderLight),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedCity,
                                    isExpanded: true,
                                    items: _cities.map((city) {
                                      return DropdownMenuItem(
                                        value: city,
                                        child: Text(city, style: AppTypography.sans(fontSize: 13, color: AppColors.textPrimary)),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) setSheetState(() => selectedCity = val);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Postal Code
                    _buildTextField(label: 'Postal Code', controller: postalController, keyboardType: TextInputType.number),
                    const SizedBox(height: 12),

                    // Set default toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Set as default delivery address',
                          style: AppTypography.sans(fontSize: 13, color: AppColors.textPrimary),
                        ),
                        Switch(
                          value: isDefault,
                          activeThumbColor: AppColors.primary,
                          onChanged: (val) => setSheetState(() => isDefault = val),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (streetController.text.trim().isEmpty || areaController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter street and area details.'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                            return;
                          }

                          setState(() {
                            if (isDefault) {
                              for (var a in _addresses) {
                                a.isDefault = false;
                              }
                            }

                            if (isEditing) {
                              final idx = _addresses.indexWhere((a) => a.id == existingAddress.id);
                              if (idx != -1) {
                                _addresses[idx] = AddressItem(
                                  id: existingAddress.id,
                                  label: selectedLabel,
                                  recipientName: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  streetAddress: streetController.text.trim(),
                                  area: areaController.text.trim(),
                                  city: selectedCity,
                                  postalCode: postalController.text.trim(),
                                  isDefault: isDefault,
                                );
                              }
                            } else {
                              _addresses.add(
                                AddressItem(
                                  id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
                                  label: selectedLabel,
                                  recipientName: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  streetAddress: streetController.text.trim(),
                                  area: areaController.text.trim(),
                                  city: selectedCity,
                                  postalCode: postalController.text.trim(),
                                  isDefault: isDefault || _addresses.isEmpty,
                                ),
                              );
                            }
                          });

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isEditing ? 'Address updated!' : 'Address added successfully!'),
                              backgroundColor: AppColors.sage,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          isEditing ? 'Update Address' : 'Save Address',
                          style: AppTypography.sans(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTypography.sans(fontSize: 13, color: AppColors.textPrimary),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.surfaceWarm,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
      ],
    );
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
          'Saved Addresses',
          style: AppTypography.serif(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    final addr = _addresses[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: addr.isDefault ? AppColors.primary : AppColors.borderLight,
                          width: addr.isDefault ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.blush,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      addr.label,
                                      style: AppTypography.sans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  if (addr.isDefault) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.sageLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Default Address',
                                        style: AppTypography.sans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.sageDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert, size: 18, color: AppColors.textMuted),
                                onSelected: (val) {
                                  if (val == 'edit') {
                                    _showAddEditAddressSheet(existingAddress: addr);
                                  } else if (val == 'default') {
                                    setState(() {
                                      for (var a in _addresses) {
                                        a.isDefault = false;
                                      }
                                      addr.isDefault = true;
                                    });
                                  } else if (val == 'delete') {
                                    setState(() {
                                      _addresses.remove(addr);
                                    });
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'default',
                                    child: Text('Set as Default'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            addr.recipientName,
                            style: AppTypography.sans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            addr.fullAddress,
                            style: AppTypography.sans(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Phone: ${addr.phone}',
                            style: AppTypography.sans(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Add New Address Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddEditAddressSheet(),
                  icon: const Icon(Icons.add_location_alt_outlined, size: 18),
                  label: const Text('Add New Address'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

