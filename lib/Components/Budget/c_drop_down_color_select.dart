import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CDropDownColorSelect extends StatefulWidget {
  const CDropDownColorSelect({
    super.key,
    required this.changedItem,
    required this.options,
    this.selectedColor,
  });

  final List<Color> options;
  final Function(Color) changedItem;
  final Color? selectedColor;

  @override
  State<CDropDownColorSelect> createState() => _CDropDownColorSelectState();
}

class _CDropDownColorSelectState extends State<CDropDownColorSelect> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  late Color _selectedColor;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isDropdownOpen = false);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    double screenHeight = MediaQuery.of(context).size.height;
    double availableHeight =
        screenHeight - position.dy - renderBox.size.height - 30;

    return OverlayEntry(
      builder:
          (context) => Positioned.fill(
            left: position.dx,
            top: position.dy + renderBox.size.height + 4,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: _closeDropdown,
                  behavior: HitTestBehavior.opaque,
                ),
                Positioned(
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    offset: const Offset(0, 36),
                    child: Material(
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(dropdownRadius),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight:
                              availableHeight > 300 ? 300 : availableHeight,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: background,
                            border: Border.all(
                              color: boxBorderColor,
                              width: boxBorderWith,
                            ),
                            borderRadius: BorderRadius.circular(dropdownRadius),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  widget.options
                                      .map((option) => _buildMenuItem(option))
                                      .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  void initState() {
    if (widget.selectedColor != null) {
      _selectedColor = widget.selectedColor!;
    } else {
      _selectedColor = widget.options.first;
    }
    super.initState();
  }

  Widget _buildMenuItem(Color color) {
    return InkWell(
      onTap: () {
        _selectedColor = color;
        widget.changedItem(color);
        _closeDropdown();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: itemDesign(color),
      ),
    );
  }

  Widget itemDesign(Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: boxBorderDark, width: 1),
          ),
        ),
        SizedBox(width: 10),
        Text("Color", style: unselectCategory),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: unselectedButtonColor,
            borderRadius: BorderRadius.circular(roundedButtonRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: itemDesign(_selectedColor),
          ),
        ),
      ),
    );
  }
}
