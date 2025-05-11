import 'package:flutter/material.dart';
import 'package:mywallet/Style/style.dart';

class CDropDown<T> extends StatefulWidget {
  const CDropDown({
    super.key,
    required this.changedItem,
    required this.options,
    this.selectedItemName = "Select an Option",
    this.onChange,
  });

  final List<T> options;
  final String Function(T) changedItem;
  final String selectedItemName;
  final Function? onChange;

  @override
  State<CDropDown<T>> createState() => _CDropDownState<T>();
}

class _CDropDownState<T> extends State<CDropDown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;
  late String _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItemName;
    super.initState();
  }

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

  Widget _buildMenuItem(T option) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedItem = widget.changedItem(option);
        });
        if (widget.onChange != null) widget.onChange!();
        _closeDropdown();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(widget.changedItem(option), style: dropDownText),
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
            border: Border.all(color: boxBorderColor, width: boxBorderWith),
            borderRadius: BorderRadius.circular(dropdownRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedItem, style: dropDownText),
              SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: selectedIconColor,
                size: dropdownIconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
