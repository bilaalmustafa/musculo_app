import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final Function(String) onChanged;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final EdgeInsetsGeometry padding;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.height = 60,
    this.borderRadius = 8,
    this.backgroundColor = const Color(0xFFF9F9F9),
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String _currentValue;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isOpen) {
        _toggleDropdown();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _createOverlay();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _createOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder:
          (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children:
                        widget.items.map((item) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _currentValue = item;
                              });
                              widget.onChanged(item);
                              _toggleDropdown();
                            },
                            child: Container(
                              height: 50,
                              padding: widget.padding,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: widget.textColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          _toggleDropdown();
          _focusNode.requestFocus();
        },
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentValue,
                style: TextStyle(color: widget.textColor, fontSize: 16),
              ),
              Icon(Icons.keyboard_arrow_down, color: widget.iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
