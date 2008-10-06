//////////////////////////////////////////////////////////////////////////
//  ZoomOutButton
//
//  Created by  on 2008-05-22.
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
	import flash.geom.*;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import tools.*;

	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-22
	 */
	public class ZoomOutButton extends Button {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var viewMode			:String;
		public var buttonLabel	:TextField;
		public var labelBg			:Sprite;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ZoomOutButton(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			viewMode			= "mapMode";
			buttonLabel		= new TextField();
			labelBg 			= new Sprite();
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			DispatchController.addEventListener("buildingMode", onBuildingMode);
			DispatchController.addEventListener("mapMode", onMapMode);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			super(_dc);
		} // END ZoomOutButton()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onBuildingMode(e:Event):void{
			viewMode = "buildingMode";
			addButtonLabel();
			fadeButtonLabel(1, 3);
		} // END onBuildingMode()
		
		public function onMapMode(e:Event):void{
			viewMode = "mapMode";
			fadeButtonLabel(0, 3, removeButtonLabel);
		} // END onMapMode()
		
		override public function onMouseOver(e:MouseEvent):void{
			super.onMouseOver(e);
			buttonIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -255, -255, -255);
		} // END mouseOver()
		
		override public function onMouseOut(e:MouseEvent):void{
			buttonIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 255);
			super.onMouseOut(e);
		} // END mouseOut()
		
		override public function onMouseUp(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				if(dc.map_container.zoomLevel>0){
					dc.map_container.zoomLevel = dc.map_container.zoomLevel-1;
					dc.map_container.zoomMap(dc.map_container.zoomLevel,"normal");
				}
			}
			if(viewMode=="buildingMode"){
				dc.map_container.resetZoom();
			};
			super.onMouseUp(e);
		} // END onMouseUp()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function fadeButtonLabel(_alpha:Number, _duration:Number = 1, _onCompleteFunction = null):void{
			TweenLite.to(labelBg, _duration, {alpha:_alpha, ease:Strong.easeOut, onComplete:_onCompleteFunction}); 
		} // END fadeButtonLabel()
		
		public function addButtonLabel():void{
			drawLabelBackground();
			configureButtonLabel();
			setText();
		} // END addButtonLabel()
		
		public function removeButtonLabel():void{
			super.bg.removeChild(labelBg);
		} // END removeButtonLabel()
		
		public function drawLabelBackground():void{
			labelBg.graphics.clear();
			labelBg.x = 22;
			labelBg.y = 2;
			labelBg.graphics.beginFill(0xFFFFFF, 0);
			labelBg.graphics.drawRect(25, 0, 50, 10);
			labelBg.graphics.endFill();
			labelBg.graphics.lineStyle(1, 0xFFFFFF, .75);
			labelBg.graphics.moveTo(0, 5);
			labelBg.graphics.lineTo(20, 5);
			labelBg.alpha = 0;
			super.bg.addChild(labelBg);
		} // END drawBackground()
		
		private function configureButtonLabel():void {
			buttonLabel.x = 23;
			buttonLabel.y = -3;
			buttonLabel.autoSize		= TextFieldAutoSize.LEFT;
			buttonLabel.background	= false;
			buttonLabel.border			= false;
			buttonLabel.selectable	= false;
			buttonLabel.defaultTextFormat = setStyle("DIN-Medium",10);
			buttonLabel.embedFonts	= true;
			buttonLabel.antiAliasType = AntiAliasType.NORMAL;
			labelBg.addChild(buttonLabel);
		} // END configureInstituteVariables()
		
		public function setText():void {
			buttonLabel.text = "Zurück zur Karte";
		} // END setInstituteVariables()
		
		public function setStyle(_font:String, _size:Number):TextFormat{
			var format:TextFormat = new TextFormat();
			format.font				= _font;
			format.color			= 0xFFFFFF;
			format.size				= _size;
			format.underline	= false;
			return format;
		} // END setStyle()
		
	} // END ZoomOutButton
} // END package
