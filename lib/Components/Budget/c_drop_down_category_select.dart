import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_category.dart';
import 'package:mywallet/Style/style.dart';

class CDropDownCategorySelect extends StatefulWidget {
  const CDropDownCategorySelect({
    super.key,
    required this.changedItem,
    required this.options,
  });

  final List<DsCategory> options;
  final Function(DsCategory) changedItem;

  @override
  State<CDropDownCategorySelect> createState() =>
      _CDropDownCategorySelectState();
}

class _CDropDownCategorySelectState extends State<CDropDownCategorySelect> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

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

  Widget _buildMenuItem(DsCategory option) {
    return InkWell(
      onTap: () {
        widget.changedItem(option);
        _closeDropdown();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 15,
              width: 15,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: option.getColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(width: 10),
            Text(option.getName, style: unselectCategory),
          ],
        ),
      ),
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
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: textColor, size: 18),
                Text("Category", style: unselectCategory),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
