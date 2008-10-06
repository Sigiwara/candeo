//////////////////////////////////////////////////////////////////////////
//  FilterLabel
//
//  Created by  on 2008-05-02.
//  Copyright (c) 2008 zhdk. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package gui {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.geom.Point;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import tools.*;
	import map.*;
	
	/**
	 *	Klasse der Labels beim Filter UI
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-02
	 */
	public class FilterLabel extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var bg								:Sprite;
		public var dc								:Object;
		public var filterUI					:Object;
		public var filterLabel			:TextField;
		public var filterValue			:Number;
		public var valueMax					:Number;
		public var viewMode					:String;
		public var mousePoint				:Point;
		public var deltaY						:Number;
		public var topY							:Number;
		public var bottomY					:Number;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function FilterLabel(_dc:Object, _filterUI, _x:Number, _y:Number, _name:String, _filterValue:Number){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc							= _dc;
			name						= _name;
			filterUI				= _filterUI;
			bg 							= new Sprite();
			filterLabel			= new TextField();
			filterValue			= _filterValue;
			x								= _x;
			y								= _y;
			alpha						= .75;
			deltaY					= 0;
			valueMax				= 0;
			viewMode				= "mapMode";
			mousePoint			= new Point();
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			dc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			drawFilterLabel();
		} // END FilterLabel();
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		
		public function drawFilterLabel():void{
			drawBackground();
			configureFilterLabel();
			updateVariables();
		} // END drawFilterLabel()
		public function drawBackground():void{
			bg.graphics.clear();
			bg.graphics.beginFill(0xFFFFFF, 0);
			bg.graphics.drawRect(-75, -4, 50, 10);
			bg.graphics.endFill();
			bg.graphics.lineStyle(1, 0xFFFFFF, .75);
			bg.graphics.moveTo(-20, 1);
			bg.graphics.lineTo(0, 1);
			addChild(bg);
		} // END drawBackground()
		//--------------------------------------
		//  TYPO
		//--------------------------------------
		private function configureFilterLabel():void {
			filterLabel.x = -123;
			filterLabel.y = -9;
			filterLabel.autoSize		= TextFieldAutoSize.RIGHT;
			filterLabel.background	= false;
			filterLabel.border			= false;
			filterLabel.selectable	= false;
			filterLabel.defaultTextFormat = setStyle("DIN-Bold",12);
			filterLabel.embedFonts	= true;
			filterLabel.antiAliasType = AntiAliasType.ADVANCED;
			addChild(filterLabel);
		} // END configureFilterLabel()
		public function setStyle(_font:String, _size:Number):TextFormat{
			var format:TextFormat = new TextFormat();
			format.font				= _font;
			format.color			= 0xFFFFFF;
			format.size				= _size;
			format.underline	= false;
			return format;
		} // END setStyle()
		//--------------------------------------
		//  POSITION & VARIABLES
		//--------------------------------------
		public function updateVariables():void{
			var n:Number;
			if(valueMax > 0){
				n = valueMax / 447;
				filterValue = Math.round(valueMax - (y-21)*n);
			}else{
				n = 100 / 447;
				filterValue = Math.round(100 - (y-21)*n);
			};
			filterLabel.text = filterValue.toString();
		} // END updateVariables()
		public function updateMinMax():void{
			switch(name){
				case "top":
				filterUI.valueMax = filterValue;
				break;
				case "bottom":
				filterUI.valueMin = filterValue;
				break;
			};
		} // END ()
		public function initLabelPosition():void{
			for each (var fl:FilterLabel in filterUI.labels){
				switch(fl.name){
					case "top":
					topY = fl.y-20;
					break;
					case "bottom":
					bottomY = fl.y-20;
					break;
				};
			};
		} // END initPanelPosition()
		public function updateLabelPosition():void{
			deltaY = dc.mouseY-mousePoint.y;
			if(bottomY-topY>50){
				y += deltaY;
			};
			if(bottomY-topY<=50&&deltaY<0&&name=="top"){
				y += deltaY;
			};
			if(bottomY-topY<=50&&deltaY>0&&name=="bottom"){
				y += deltaY;
			};
			if(y < 21){
				y = 21;
			};
			if(y > 448+20){
				y = 448+20;
			};
			mousePoint = new Point(dc.mouseX, dc.mouseY);
		} // END updateVariables()
		public function updatePanelPosition():void{
			var oldY:Number;
			var newY:Number;
			var deltaY:Number;
			for each (var fl:FilterLabel in filterUI.labels){
				switch(fl.name){
					case "top":
					oldY = filterUI.filterPanel.panel.y;
					newY = fl.y-20;
					topY = newY;
					deltaY = newY - oldY;
					if(bottomY-topY>50){
						filterUI.filterPanel.panel.y = newY;
						filterUI.filterPanel.panel.height -= deltaY;
					};
					break;
					case "bottom":
					oldY = filterUI.filterPanel.panel.y+filterUI.filterPanel.panel.height;
					newY = fl.y-20;
					bottomY = newY;
					deltaY = newY - oldY;
					if(bottomY-topY>50){
						filterUI.filterPanel.panel.height += deltaY;
					};
					break;
				};
			};
		} // END updatePanelPosition()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseDown(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				alpha	= 1;
				mousePoint = new Point(dc.mouseX, dc.mouseY);
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				dc.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				dc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		} // END onMouseDown()
		public function onMouseUp(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				dc.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				dc.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				alpha = .75;
				filterUI.updateDangers();
			};
		} // END onMouseUp()
		public function onMouseMove(e:MouseEvent):void{
			initLabelPosition();
			updateLabelPosition();
			updatePanelPosition();
			updateVariables();
			updateMinMax();
		} // END onMouseMove()
	} // END ZoomLabel
} // END package
