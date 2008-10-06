//////////////////////////////////////////////////////////////////////////
//  ZoomInButton
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
	public class ZoomInButton extends Button {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var viewMode			:String;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ZoomInButton(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			viewMode		= "mapMode";
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
		} // END ZoomInButton()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function fadeButton(_alpha:Number, _duration:Number = 1, _onCompleteFunction = null):void{
			TweenLite.to(this, _duration, {alpha:_alpha, ease:Strong.easeOut, onComplete:_onCompleteFunction}); 
		} // END fadeButton()
		
		public function hideButton():void{
			visible = false; 
		} // END hideButton()
		
		public function showButton():void{
			visible = true; 
		} // END showButton()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onBuildingMode(e:Event):void{
			fadeButton(0, 3, hideButton);
			viewMode = "buildingMode";
		} // END onBuildingMode()
		
		public function onMapMode(e:Event):void{
			showButton();
			fadeButton(1, 3);
			viewMode = "mapMode";
		} // END onMapMode()
		
		override public function onMouseOver(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				super.onMouseOver(e);
				buttonIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -255, -255, -255);
			}
		} // END mouseOver()
		
		override public function onMouseOut(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				buttonIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 255);
				super.onMouseOut(e);
			}
		} // END mouseOut()
		
		override public function onMouseUp(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				if(dc.map_container.zoomLevel<dc.map_container.zoomLevels.length-1){
					dc.map_container.zoomLevel = dc.map_container.zoomLevel+1;
					dc.map_container.zoomMap(dc.map_container.zoomLevel,"normal");
				}
				super.onMouseUp(e);
			}
		} // END onMouseUp()
		
	} // END ZoomInButton
} // END package
		