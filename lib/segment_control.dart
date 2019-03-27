library segment_control;

import 'package:flutter/material.dart';

typedef ValueChanged<T, M> = void Function(T value, M valueM);

class SegmentControl extends StatefulWidget {
	final double height;
	final double width;
	final List<String> tabs;
	final ValueChanged<int, String> selected;
	final Color normalBackgroundColor;
	final Color activeBackgroundColor;
	final Color normalTitleColor;
	final Color activeTitleColor;
	final TextStyle normalTitleStyle;
	final TextStyle activeTitleStyle;
	final Color borderColor;
	final double radius;
	
	final bool selectNone;
	
	SegmentControl({
		@required this.tabs,
		@required this.selected,
		this.height = 40,
		this.width = double.infinity,
		this.normalBackgroundColor = Colors.white,
		this.activeBackgroundColor = Colors.blue,
		this.normalTitleColor = Colors.blue,
		this.activeTitleColor = Colors.white,
		this.normalTitleStyle = const TextStyle(fontSize: 16, color: Colors.blue),
		this.activeTitleStyle = const TextStyle(fontSize: 18, color: Colors.white),
		this.radius = 0,
		this.borderColor = Colors.blue,
		this.selectNone = false,
	});
	
	_SegmentControlState state;
	
	@override
	_SegmentControlState createState() {
		state = _SegmentControlState();
		return state;
	}
}

class _SegmentControlState extends State<SegmentControl> with SingleTickerProviderStateMixin {
	TabController _ctrl;
	
	@override
	void initState() {
		super.initState();
		_ctrl = TabController(length: widget.tabs.length, vsync: this);
		_ctrl.addListener(() {
			if (_ctrl.indexIsChanging) {
				setState(() {});
				widget.selected(_ctrl.index, widget.tabs[_ctrl.index]);
			}
		});
	}
	
	@override
	Widget build(BuildContext context) {
		return SizedBox(
			height: widget.height,
			width: widget.width,
			child: TabBar(
				controller: _ctrl,
				tabs: widget.tabs.map((f) {
					var idx = widget.tabs.indexOf(f);
					return Tab(
						child: Container(
							decoration: BoxDecoration(
								border: Border.all(color: widget.borderColor, width: 1.0),
								borderRadius: cicleRadius(idx),
								color: (idx == _ctrl.index && !widget.selectNone) ? widget.activeBackgroundColor : widget.normalBackgroundColor,
							),
							child: Center(
								child: Text(f, style: (idx == _ctrl.index && !widget.selectNone) ? widget.activeTitleStyle : widget.normalTitleStyle),
							),
						),
					);
				}).toList(),
				isScrollable: false,
				indicatorColor: Colors.transparent,
				labelPadding: EdgeInsets.zero,
			),
		);
	}
	
	BorderRadius cicleRadius(int idx) {
		if (idx == 0) {
			return BorderRadius.only(
				topLeft: Radius.circular(widget.radius),
				bottomLeft: Radius.circular(widget.radius),
			);
		}
		
		if (idx == widget.tabs.length - 1) {
			return BorderRadius.only(
				topRight: Radius.circular(widget.radius),
				bottomRight: Radius.circular(widget.radius),
			);
		}
		
		return BorderRadius.zero;
	}
}
