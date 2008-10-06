//////////////////////////////////////////////////////////////////////////
//  Building
//
//  Created by Christian Siegrist on 08-04-28.
//  Copyright (c) 2008 Christian Siegrist / Significant.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package map {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import barchart.*;
	import tools.*;
	import map.*;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-04-28
	 */
	public class Building extends MovieClip {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc											:Object;
		public var mapContainer						:Object;
		public var originalWidth					:Number;
		public var originalHeight					:Number;
		public var daten									:XML;
		public var institutesData					:Array;
		public var institutesDataComplete	:Array;
		public var institutesMC						:Array;
		public var recordsData						:Array;
		public var buildingPotential			:Number;
		
		public var viewMode								:String;
		public var detailBuilding					:DetailBuilding;
		public var detailBuildingVisible	:Boolean;
		public var records								:Records;
		public var buildingDanger					:BuildingDanger;
		public var detailInstitute				:Object
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		public function Building(){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			originalWidth	 					= width;
			originalHeight 					= height;
			viewMode			 					= "mapMode";
			institutesData 					= new Array();
			institutesDataComplete	= new Array();
			institutesMC	 					= new Array();
			recordsData							= new Array();
			useHandCursor	 					= true;
			buttonMode		 					= true;
			detailBuildingVisible		= false;
			buildingDanger					= null;
			buildingPotential				= 0;
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			DispatchController.addEventListener("dcAttached", onDcAttached);
			DispatchController.addEventListener("buildingMode", onBuildingMode);
			DispatchController.addEventListener("mapMode", onMapMode);
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
		} // END Building()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseDown(e:MouseEvent):void{
			if(viewMode=="mapMode"){	
				fadeArea(1);
			}
		} // END onMouseDown()
		
		public function onMouseUp(e:MouseEvent):void{
			if(viewMode=="mapMode"){	
				extMouseUp(e)
				callInstitutes(e);
			}
		} // END onMouseUp()
		
		public function extMouseUp(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				DispatchController.dispatchEvent(new Event("buildingMode"));
				dc.tooltip.removeTooltip();
				dc.dangerLayer.removeBuildingDanger();
				mapContainer.savePosition();
				mapContainer.zoomToBuilding(this, originalWidth, originalHeight);
				fadeStreets(0, 3);
				fadeAreas(0, 3);
				fadeArea(0, 3);
				fadeOutline(.5, 3);
				addDetailBuilding();
				addRecords();
			};
		} // END extMouseUp()
		
		public function onMouseOver(e:MouseEvent):void{
			if(viewMode=="mapMode" && dc.dangerLayer.fadeActive==false){
				extMouseOver(e, false);
				callInstitutes(e);
			};
		} // END onMouseOver()
		
		public function extMouseOver(e:MouseEvent, _remote:Boolean):void{
			if(viewMode=="mapMode" && dc.dangerLayer.fadeActive==false){
				fadeAreas(.1);
				fadeArea(.85);
				dc.tooltip.addTooltip(this, _remote);
			};
		} // END extMouseOver()
		
		public function onMouseOut(e:MouseEvent):void{
			if(viewMode=="mapMode" && dc.dangerLayer.fadeActive==false){	
				extMouseOut(e);
				callInstitutes(e);
			}
		} // END onMouseOut()
		
		public function extMouseOut(e:MouseEvent):void{
			if(viewMode=="mapMode" && dc.dangerLayer.fadeActive==false){
				fadeAreas(.5);
				dc.tooltip.removeTooltip();
			}
		} // END extMouseOut()
		
		public function onDcAttached(e:Event):void{
			// dc registrieren
			dc = CandeoDC.root;
			// map registrieren
			mapContainer = dc.root.mapContainer_mc;
			// gebaeude dem array hinzufuegen
			if(this.name != "outline" && this.name != "area"){
				dc.buildings_mc.push(this);
			}else{
				this.x = 10;
				this.y = 10;
			}
			// hide outlines
			fadeOutline(0, 0);
			// set default alpha for areas
			fadeArea(.5, 0)
		} // END onDcAttached()
		
		public function onBuildingMode(e:Event):void{
			buttonMode = false;
			useHandCursor = false;
			viewMode = "buildingMode";
		} // END onBuildingMode()
		
		public function onMapMode(e:Event):void{
			if(detailBuildingVisible==true){
				TweenLite.to(detailBuilding, 3, {alpha:0, ease:Strong.easeOut, onComplete:removeDetailBuilding});
				TweenLite.to(records, 3, {alpha:0, ease:Strong.easeOut, onComplete:removeRecords});
			}
			fadeArea(.5, 3);
			fadeOutline(0, 3);
			fadeStreets(.1, 3);
			viewMode = "mapMode";
			buttonMode = true;
			useHandCursor = true;
		} // END onMapMode()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function fadeAreas(_alpha:Number, _duration:Number = .5):void{
			for(var i:Number = 0; i < dc.buildings_mc.length; i++){
				dc.buildings_mc[i].fadeArea(_alpha, _duration);
			};
		} // END fadeBuildings()
		
		public function fadeArea(_alpha:Number, _duration:Number = .5):void{
			TweenLite.to(this.area, _duration, {alpha:_alpha, ease:Strong.easeOut}); 
			//this.area.alpha = _alpha;
		} // END fadeBuilding()
		
		public function fadeOutlines(_alpha:Number, _duration:Number = .5):void{
			for(var i:Number = 0; i < dc.buildings_mc.length; i++){
				dc.buildings_mc[i].fadeOutline(_alpha, _duration);
			};
		} // END fadeOutlines()
		
		public function fadeOutline(_alpha:Number, _duration:Number = .5):void{
			TweenLite.to(this.outline, _duration, {alpha:_alpha, ease:Strong.easeOut});
			//this.outline.alpha = _alpha;
		} // END fadeOutline()
		
		public function addRecords():void{
			records = new Records(dc, this);
			dc.addChild(records);
			TweenLite.to(records, 3, {alpha:.85, delay:1.8, ease:Strong.easeOut});
		} // END Records		
		
		public function removeRecords():void{
			dc.removeChild(records);
		} // END Records
		
		public function addDetailBuilding():void{
			detailBuilding = new DetailBuilding(dc, this);
			dc.addChild(detailBuilding);
			TweenLite.to(detailBuilding, 3, {alpha:.85, delay:1.8, ease:Strong.easeOut});
			detailBuildingVisible = true;
			mapContainer.detailBuilding = this;
		} // END addDetailBuilding()
		
		public function removeDetailBuilding():void{
			dc.removeChild(detailBuilding);
			detailBuildingVisible = false;
			mapContainer.detailBuilding = null;
		} // END removeDetailBuilding()
		
		public function callInstitutes(e:MouseEvent):void{
			var institute:ColumnHeader;
			switch(e.type){
				case "mouseOver":
					// TODO: Alle Institute gehighlightet lassen
					for each (institute in institutesMC){
						institute.extMouseOver(e);
					};
					break;
				case "mouseOut":
					for each (institute in institutesMC){
						institute.extMouseOut(e);
					};
					break;
				case "mouseUp":
					if(institutesMC.length > 0){
						institutesMC[0].extMouseUp(e);
					};
					break;
				default:
				break;
			}
		} // END callInstitutes()
		
		public function registerInstitute(_institute):void{
			institutesMC.push(_institute.ch);
			institutesDataComplete.push(_institute);
		} // END registerInstitute()
		
		public function fadeStreets(_alpha:Number, _duration:Number = .5):void{
			TweenLite.to(mapContainer.streets, _duration, {alpha:_alpha, ease:Strong.easeOut});
			//mapContainer.streets.alpha = _alpha;
		} // END fadeOutline()
	} // END Building
} // END package