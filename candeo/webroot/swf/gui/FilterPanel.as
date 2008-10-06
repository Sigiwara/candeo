//////////////////////////////////////////////////////////////////////////
//  FilterPanel
//
//  Created by  on 2008-05-17.
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
	
	/**
	 *	Balken des Filter UI
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-17
	 */
	public class FilterPanel extends Sprite {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc							:Object;
		public var panel					:Sprite;
		public var bg							:Sprite;
		public var filterPanel		:Sprite;
		public var viewMode				:String;
		public var mousePoint			:Point;
		public var deltaY					:Number;
		public var originalHeight	:Number;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function FilterPanel(){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			panel									= new Sprite();
			panel.buttonMode 			= true;
			panel.useHandCursor		= true;
			originalHeight				= height;
			x											= 26;
			y											= 21;
			viewMode							= "mapMode";
			mousePoint						= new Point();
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			DispatchController.addEventListener("dcAttached", onDcAttached);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			drawPanel(0,0,8,448);
		} // END FilterUI()
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		// TODO: Debugging bei dem releasen vom panel
		public function drawPanel(_x:Number, _y:Number, _width:Number, _height:Number):void{
			panel.graphics.clear();
			panel.graphics.beginFill(0xFFFFFF,.75);
			panel.graphics.drawRect(_x, _y, _width, _height);
			panel.graphics.endFill();
			addChild(panel);
			mask = panel;
		} // END drawPanel()
		public function updatePosition():void{
			deltaY = dc.mouseY-mousePoint.y;
			panel.y += deltaY;
			if(panel.y < y-20){
				panel.y = y-20;
			};
			if(panel.y > originalHeight-panel.height){
				panel.y = originalHeight-panel.height;
			};
		} // END updatePosition()
		public function updateLabels():void{
			dc.ui.filterUI.filterLabelTop.y = panel.y+21;
			dc.ui.filterUI.filterLabelTop.updateVariables()
			dc.ui.filterUI.filterLabelBottom.y = panel.y+panel.height+20;
			dc.ui.filterUI.filterLabelBottom.updateVariables()
			dc.ui.filterUI.filterLabelBottom.updateMinMax();
			dc.ui.filterUI.filterLabelBottom.updateMinMax();
		} // END updateLabels()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onDcAttached(e:Event):void{
			dc = CandeoDC.root;
			dc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		} // END onDcAttached()
		public function onMouseDown(e:MouseEvent):void{
			if(viewMode=="mapMode"){
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
				dc.ui.filterUI.updateDangers();
			};
		} // END onMouseUp()
		public function onMouseMove(e:MouseEvent):void{
			updatePosition();
			updateLabels();
			mousePoint = new Point(dc.mouseX, dc.mouseY);
		} // END onMouseMove()
	} // END FilterUI
} // END package
