//////////////////////////////////////////////////////////////////////////
//  FilterUI
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
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import tools.*;
	
	/**
	 *	Superklasse für das Filter Interface
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-17
	 */
	public class FilterUI extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc									:Object;
		public var mapContainer				:Object;
		public var labels							:Array;
		public var viewMode						:String;
		public var filterLabelTop			:FilterLabel;
		public var filterLabelBottom	:FilterLabel;
		public var valueMin						:Number;
		public var valueMax						:Number;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function FilterUI(_dc:Object){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc 						= _dc;
			mapContainer 	= dc.root.mapContainer_mc
			x 						= mapContainer.width-this.width+10;
			y							= mapContainer.height-this.height+50;
			scaleX				= .9;
			scaleY				= scaleX;
			alpha					= .65;
			labels				= new Array();
			viewMode			= "mapMode";
			valueMin			= 0;
			valueMax			= 0;
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			DispatchController.addEventListener("buildingMode", onBuildingMode);
			DispatchController.addEventListener("mapMode", onMapMode);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			addFilterLabels();
		} // END FilterUI()
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function addFilterLabels():void{
			filterLabelTop = new FilterLabel(dc, this, 19, 21, "top", 100);
			filterLabelBottom = new FilterLabel(dc, this, 19, filterPanel.height+20, "bottom", 0);
			labels.push(filterLabelTop);
			labels.push(filterLabelBottom);
			addChild(filterLabelTop);
			addChild(filterLabelBottom);
		} // END addFilterLabels()
		public function configureLabel(_max:Number):void{
			for each (var fl:FilterLabel in labels){
				fl.valueMax = _max;
				fl.updateVariables();
			};
		} // END configureLabel()
		public function fadeFilterUI(_alpha:Number, _duration:Number = 1, _onCompleteFunction = null):void{
			TweenLite.to(this, _duration, {alpha:_alpha, ease:Strong.easeOut, onComplete:_onCompleteFunction}); 
		} // END fadeFilterUI()
		public function hideFilterUI():void{
			visible = false; 
		} // END hideZoomUI()
		public function showFilterUI():void{
			visible = true; 
		} // END showZoomUI()
		public function updateDangers():void{
			var tObject:Object = new Object();
			tObject.min = valueMin;
			tObject.max = valueMax;
			dc.dangerLayer.resetDangers();
			dc.dangerLayer.fadeFilterDangers(tObject);
		} // END updateDangers()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseOver(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				fadeFilterUI(1);
			};
		} // END onMouseOver()
		public function onMouseOut(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				fadeFilterUI(.75);
			};
		} // END onMouseOut()
		public function onBuildingMode(e:Event):void{
			fadeFilterUI(0, 3, hideFilterUI);
			viewMode = "buildingMode";
			filterPanel.viewMode = viewMode;
			for each (var fl:FilterLabel in labels){
				fl.viewMode = viewMode;
			};
		} // END onBuildingMode()
		public function onMapMode(e:Event):void{
			showFilterUI();
			fadeFilterUI(.75, 3);
			viewMode = "mapMode";
			filterPanel.viewMode = viewMode;
			for each (var fl:FilterLabel in labels){
				fl.viewMode = viewMode;
			};
		} // END onMapMode()
	} // END FilterUI
} // END package
