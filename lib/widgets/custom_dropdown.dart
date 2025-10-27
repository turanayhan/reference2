import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String? value;
  final String label;
  final String hint;
  final IconData icon;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDropdownChanged(String? value) {
    widget.onChanged(value);
    setState(() {
      _isOpen = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: DropdownButtonFormField<String>(
            value: widget.value,
            validator: widget.validator,
            isExpanded: true,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1976D2).withOpacity(0.15),
                      const Color(0xFF42A5F5).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF1976D2),
                  size: 20,
                ),
              ),
              filled: true,
              fillColor: widget.enabled ? Colors.grey[50] : Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF1976D2),
                  width: 2.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red[400]!, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.red[400]!, width: 2.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              errorStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: widget.value == item
                              ? const Color(0xFF1976D2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: widget.value == item
                                ? const Color(0xFF1976D2)
                                : Colors.black87,
                            fontWeight: widget.value == item
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (widget.value == item)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF1976D2),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: widget.enabled ? _onDropdownChanged : null,
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            icon: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 3.14159, // 180 degrees
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFF1976D2),
                      size: 20,
                    ),
                  ),
                );
              },
            ),
            iconSize: 0, // Hide default icon
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
              });
              if (_isOpen) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(16),
            elevation: 8,
          ),
        ),
      ],
    );
  }
}

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  const CustomSwitchTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[50]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value
              ? const Color(0xFF1976D2).withOpacity(0.3)
              : Colors.grey[200]!,
          width: 1.5,
        ),
        boxShadow: value
            ? [
                BoxShadow(
                  color: const Color(0xFF1976D2).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: value
                  ? const Color(0xFF1976D2).withOpacity(0.1)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              value ? Icons.notifications_active : Icons.notifications_off,
              color: value ? const Color(0xFF1976D2) : Colors.grey[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: value ? const Color(0xFF1976D2) : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Transform.scale(
            scale: 1.3,
            child: Switch.adaptive(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF1976D2),
              inactiveTrackColor: Colors.grey[300],
              inactiveThumbColor: Colors.grey[500],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
