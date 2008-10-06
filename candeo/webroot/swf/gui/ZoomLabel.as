//////////////////////////////////////////////////////////////////////////
//  ZoomLabel
//
//  Created by  on 2008-05-02.
//  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
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
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import tools.*;
	import map.*;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-02
	 */
	public class ZoomLabel extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc								:Object;
		public var mapContainer			:Object;
		public var bg								:Sprite;
		public var zoomLabelText		:String;
		public var zoomLabel				:TextField;
		public var zoomLevel				:Number;
		public var viewMode					:String;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		public function ZoomLabel(_dc:Object, _x:Number, _y:Number, _zoomLabelText:String, _zoomLevel:Number){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc						= _dc;
			mapContainer 	= dc.root.mapContainer_mc
			bg 						= new Sprite();
			x 						= _x;
			y 						= _y;
			alpha					= .75;
			zoomLabelText = _zoomLabelText;
			zoomLevel			= _zoomLevel
			zoomLabel			= new TextField();
			viewMode			= "mapMode";

			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			drawZoomLabel();
			
		} // END ZoomLabel();
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseOver(e:MouseEvent):void{
		} // END onMouseOver()
		
		public function onMouseOut(e:MouseEvent):void{
		} // END onMouseOver()
		
		public function onMouseDown(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				alpha	= 1;
				mapContainer.zoomLevel = zoomLevel;
				mapContainer.zoomMap(zoomLevel, "normal");
			}
		} // END onMouseDown()
		
		public function onMouseUp(e:MouseEvent):void{
			alpha = .75;
		} // END onMouseUp()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function drawZoomLabel():void{
			drawBackground();
			configureZoomLabel();
			setText(zoomLabelText);
		} // END drawZoomLabel()
		
		public function drawBackground():void{
			bg.graphics.clear();
			bg.graphics.beginFill(0xFFFFFF, 0);
			bg.graphics.drawRect(25, 0, 50, 10);
			bg.graphics.endFill();
			bg.graphics.lineStyle(1, 0xFFFFFF, .75);
			bg.graphics.moveTo(0, 5);
			bg.graphics.lineTo(20, 5);
			addChild(bg);
		} // END drawBackground()
		
		private function configureZoomLabel():void {
			zoomLabel.x = 23;
			zoomLabel.y = -5;
			zoomLabel.autoSize		= TextFieldAutoSize.LEFT;
			zoomLabel.background	= false;
			zoomLabel.border			= false;
			zoomLabel.selectable	= false;
			zoomLabel.defaultTextFormat = setStyle("DIN-Bold",12);
			zoomLabel.embedFonts	= true;
			zoomLabel.antiAliasType = AntiAliasType.ADVANCED;
			addChild(zoomLabel);
		} // END configureInstituteVariables()
		
		public function setText(_zoomLabelText:String):void {
			zoomLabel.text = _zoomLabelText;
		} // END setInstituteVariables()
		
		public function setStyle(_font:String, _size:Number):TextFormat{
			var format:TextFormat = new TextFormat();
			format.font				= _font;
			format.color			= 0xFFFFFF;
			format.size				= _size;
			format.underline	= false;
			return format;
		} // END setStyle()
		
	} // END ZoomLabel
} // END package
