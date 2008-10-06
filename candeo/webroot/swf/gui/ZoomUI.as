//////////////////////////////////////////////////////////////////////////
//  ZoomUI
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
	public class ZoomUI extends Sprite {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var elements			:Array;
		public var viewMode			:String;
		public var dc						:Object
		public var mapContainer	:Object;
		public var labels				:Array;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ZoomUI(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc						= _dc;
			mapContainer 	= dc.root.mapContainer_mc
			elements			= new Array();
			labels				= new Array();
			x 						= 2;
			y							= mapContainer.height-this.height+69;
			scaleX				= .9;
			scaleY				= scaleX;
			height				= height-37;
			alpha					= .75;
			viewMode			= "mapMode";
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			DispatchController.addEventListener("buildingMode", onBuildingMode);
			DispatchController.addEventListener("mapMode", onMapMode);
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			DispatchController.dispatchEvent(new Event("zoomUIAttached"));
			addZoomLabels();
			
		} // END ZoomUI()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseDown(e:MouseEvent):void{
		} // END onMouseDown()
		
		public function onMouseUp(e:MouseEvent):void{
		} // END onMouseUp()
		
		public function onMouseOver(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				fadeZoomUI(1);
			}
		} // END onMouseOver()
		
		public function onMouseOut(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				fadeZoomUI(.75);
			}
		} // END onMouseOut()
		
		public function onBuildingMode(e:Event):void{
			fadeZoomUI(0, 3, hideZoomUI);
			viewMode = "buildingMode";
			for(var i:Number = 0; i < elements.length; i++){
				elements[i].viewMode = viewMode;
			}
			for(var j:Number = 0; j < labels.length; j++){
				labels[j].viewMode = viewMode;
			}
		} // END onBuildingMode()
		
		public function onMapMode(e:Event):void{
			showZoomUI();
			fadeZoomUI(.75, 3);
			viewMode = "mapMode";
			for(var i:Number = 0; i < elements.length; i++){
				elements[i].viewMode = viewMode;
			}
			for(var j:Number = 0; j < labels.length; j++){
				labels[j].viewMode = viewMode;
			}
		} // END onMapMode()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function fadeZoomUI(_alpha:Number, _duration:Number = 1, _onCompleteFunction = null):void{
			TweenLite.to(this, _duration, {alpha:_alpha, ease:Strong.easeOut, onComplete:_onCompleteFunction}); 
		} // END fadeZoomUI()
		
		public function addZoomLabels():void{
			var zoomLabelBuilding:ZoomLabel = new ZoomLabel(dc, x+44,y-59, "Building", 14);
			var zoomLabelArea:ZoomLabel = new ZoomLabel(dc, x+38,y+121, "Area", 8);
			var zoomLabelUni:ZoomLabel = new ZoomLabel(dc, x+32,y+361, "Uni", 0);
			labels.push(zoomLabelBuilding);
			labels.push(zoomLabelArea);
			labels.push(zoomLabelUni);
			addChild(zoomLabelBuilding);
			addChild(zoomLabelArea);
			addChild(zoomLabelUni);
		} // END addZoomLabels()
		
		public function hideZoomUI():void{
			visible = false; 
		} // END hideZoomUI()
		
		public function showZoomUI():void{
			visible = true; 
		} // END showZoomUI()
		
	} // END ZoomUI
} // END package
