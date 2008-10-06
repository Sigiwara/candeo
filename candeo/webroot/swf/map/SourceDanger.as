//////////////////////////////////////////////////////////////////////////
//  SourceDanger
//
//  Created by Benjamin Wiederkehr on 2008-05-21.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package map {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import tools.*;
	import flash.geom.*;
	import gs.TweenLite;
	import fl.transitions.easing.*;
	import fl.motion.Color;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import barchart.*;
	
	/**
	 *	Danger Klasse – Zeichnungsfunktionen und 
	 *	grundsätzliches Verhalten von Gefahren auf der Map
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-21
	 */
	public class SourceDanger extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc												:Object;
		public var building									:Object;
		public var mapContainer							:Object;
		public var gefahrenquelle						:Sprite;
		public var sourcePoint							:Sprite;
		public var sourceContainer					:Sprite;
		public var potential								:DetailPotential;
		
		public var matrix										:Matrix;
		public var blur											:BlurFilter
		public var pBuildingBound						:Rectangle;
		public var maxZoomLevel							:Number;
		public var zoomActive								:Boolean;
		public var viewMode									:String;
		
		public var sourceX									:Number;
		public var sourceY									:Number;
		public var sourceR									:Number;
		public var sourceDangerParameter		:Object;
		
		public var buildingX								:Number;
		public var buildingY								:Number;
		public var buildingR								:Number;
		public var buildingDangerParameter	:Object;
		
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const MIN_BLUR				:int 	= 18;
		public const MAX_ADD_BLUR		:int 	= 30;
		public const RADIUS					:int 	= 1;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function SourceDanger(_dc, _building, _potential){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc											= _dc;
			mapContainer						= dc.root.mapContainer_mc;
			building								= _building;
			potential								= _potential;
			pBuildingBound 					= building.getBounds(dc);
			maxZoomLevel						= mapContainer.zoomLevels.length+1;
			
			gefahrenquelle 					= new Sprite();
			sourcePoint							= new Sprite();
			matrix 									= new Matrix();
			blur 										= new BlurFilter();
			
			viewMode								= "buildingMode";
			zoomActive							= true;
			alpha										= 1;
						
			// Building Danger Parameter
			buildingX								= pBuildingBound.x + pBuildingBound.width/2;
			buildingY								= pBuildingBound.y + pBuildingBound.height/2;
			buildingR								= Math.random()*45;
			buildingDangerParameter	= {dangerX:buildingX, dangerY:buildingY, dangerR:buildingR};
			
			// Source Danger Parameter
			sourceX									= Calculations.getRandom(building.x,building.x+building.width);
			sourceY									= Calculations.getRandom(building.y,building.y+building.height);
			sourceR									= calcDanger();
			sourceDangerParameter 	= {dangerX:sourceX, dangerY:sourceY, dangerR:sourceR};
			
			// Set Danger Position
			x = buildingDangerParameter.dangerX;
			y = buildingDangerParameter.dangerY;
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			DispatchController.addEventListener("zoomMapActive", onMapZoom);
			DispatchController.addEventListener("mapMode", onMapMode);
			sourcePoint.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			sourcePoint.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			// CHANGED: Animation entfernt
			// drawDanger(buildingDangerParameter);
			// addInitTween(sourceDangerParameter,.03,.03);
		} // END BuildingDanger()
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function ini():void{
			drawDanger(sourceDangerParameter);
			onInitComplete();
		} // END ini()
		public function drawDanger(_dangerParameter:Object):void {
			// Danger Layer in den Vordergrund
			dc.map_container.removeChild(dc.dangerLayer);
			dc.map_container.addChild(dc.dangerLayer);
			// Danger zeichnen
			gefahrenquelle.graphics.clear();
			matrix.createGradientBox(_dangerParameter.dangerR*2, _dangerParameter.dangerR*2, 0, -_dangerParameter.dangerR, -_dangerParameter.dangerR);
			gefahrenquelle.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF,0xFFE400,0xEA720D,0xFF0000,0xFF0000], [1,1,1,1,1], getColorRatios(_dangerParameter.dangerR), matrix);
			gefahrenquelle.graphics.drawCircle(0, 0, _dangerParameter.dangerR);
			gefahrenquelle.graphics.endFill();
			gefahrenquelle.cacheAsBitmap = true;
			gefahrenquelle.blendMode = BlendMode.SCREEN;
			setBlur(gefahrenquelle, calculateBlur());
			addChild(gefahrenquelle);
			gefahrenquelle.alpha = .5;
		} // END drawDanger()
		
		public function drawSourcePoint():void{
			sourcePoint.graphics.beginFill(0xFFFFFF,1);
			sourcePoint.graphics.drawCircle(0, 0, 5);
			sourcePoint.graphics.endFill();
			sourcePoint.x				= gefahrenquelle.x;
			sourcePoint.y				= gefahrenquelle.y;
			sourcePoint.alpha		= 0;
			sourceContainer.addChild(sourcePoint);
			sourceContainer.scaleX	= .03;
			sourceContainer.scaleY	= .03;
			sourceContainer.x				= sourceDangerParameter.dangerX;
			sourceContainer.y				= sourceDangerParameter.dangerY;
			TweenLite.to(sourcePoint, 1, {alpha:.5, ease:Strong.easeOut});
		} // END drawSourcePoint()
		
		public function calcDanger():Number{
			// Grösse von Danger ausrechnen
			var tRadius:Number = potential.record.potential/RADIUS;
			if(tRadius > 300){ tRadius = 300};
			if(tRadius < 10){ tRadius = 10};
			return tRadius;
		} // END calcDanger()
		
		public function calculateBlur():Number {
			var blurQuantity:Number = MIN_BLUR+MAX_ADD_BLUR*(mapContainer.zoomLevel+1)/maxZoomLevel;
			return blurQuantity;
		} // END calculateBlur()
		
		public function setBlur(_sprite:Sprite, _blurQuantity:Number):void {
			blur.blurX = _blurQuantity;
			blur.blurY = _blurQuantity;
			blur.quality = BitmapFilterQuality.LOW;
			_sprite.filters = [blur];
		} // END setBlur()
		
		public function getColorRatios(_radius:Number) {
			if(_radius>40){
				return [2,100,150,200,255];
			}
			if(_radius>35){				
				return [0,100,150,200,255];
			}
			if(_radius>30){				
				return [0,0,130,200,255];
			}
			if(_radius>25){				
				return [0,0,10,200,255];
			}
			if(_radius>20){
				return [0,0,0,100,255];
			}
			if(_radius>10){
				return [0,0,0,30,255];
			}
			if(_radius<=10){				
				return [0,0,0,0,255];
			}
		} // END getColorRatios
		
		public function addInitTween(_dangerParameter:Object, _scaleX:Number, _scaleY:Number, _delay:Number = 0):void{
			TweenLite.to(this, 1, {delay:_delay, x:_dangerParameter.dangerX, y:_dangerParameter.dangerY, scaleX:_scaleX, scaleY:_scaleY, ease:Strong.easeOut, onComplete:onInitComplete}); 
		} // END addTween()
		
		public function addEndTween(_dangerParameter:Object, _scaleX:Number, _scaleY:Number, _delay:Number = 0):void{
			TweenLite.to(this, 1, {delay:_delay, x:_dangerParameter.dangerX, y:_dangerParameter.dangerY, scaleX:_scaleX, scaleY:_scaleY, ease:Strong.easeOut, onComplete:onEndComplete}); 
		} // END addTween()
		
		public function onInitComplete():void{
			this.scaleX	= .03;
			this.scaleY	= .03;
			this.x			= sourceDangerParameter.dangerX;
			this.y			= sourceDangerParameter.dangerY;
			zoomActive = false;
			drawSourcePoint();
		} // END onFadeComplete();
		
		public function onEndComplete():void{
			zoomActive = false;
		} // END onFadeComplete();
		
		public function fadeDangers(_alpha:Number, _duration:Number = .5):void{
			for(var i:Number = 0; i < dc.dangerLayer.sourceDangers.length; i++){
				dc.dangerLayer.sourceDangers[i].fadeDanger(_alpha, _duration);
			}
		} // END fadeDangers()
		
		public function fadeDanger(_alpha:Number, _duration:Number = .5):void{
			// CHANGED: Animation entfernt
			//TweenLite.to(this, _duration, {alpha:_alpha, ease:Strong.easeOut});
			this.alpha = _alpha;
		} // END fadeBuilding()
		
		public function adaptToBlock(_block):void{
			if (_block != potential.block){
				fadeDanger(.1);
			};
		} // END adaptToBlock()
		
		public function adaptToRow(_row):void{
			if (_row != potential.row){
				fadeDanger(.1);
			};
		} // END adaptToBlock()
		
		public function resetDanger():void{
			fadeDanger(.85);
		} // END resetDanger()
		
		public function callPotential(e:MouseEvent):void{
			switch(e.type){
				case "mouseOver":
				potential.extMouseOver(e);
				break;
				case "mouseOut":
				potential.extMouseOut(e);
				break;
			}
		} // END callPotentials()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMapMode(e:Event):void{
			// View Mode ändern
			viewMode = "mapMode";
			// Source Tooltip entfernen
			dc.sourceTooltip.removeSourceTooltip();
			// Danger Layer in den Hintergrundergrund
			dc.map_container.removeChild(dc.dangerLayer);
			dc.map_container.addChildAt(dc.dangerLayer,2);
			// Source Danger animieren
			// CHANGED: Animation entfernt
			TweenLite.to(sourcePoint, 1, {alpha:0, ease:Strong.easeOut}); 
			//addEndTween(buildingDangerParameter, 1, 1, 1);
			//onEndComplete();
			onEndComplete();
		} // END onMapMode
		
		public function onMouseOver(e:MouseEvent):void{
			if(zoomActive==false){
				callPotential(e);
				extMouseOver(e);
			}
		} // END onMouseOver()
		
		public function extMouseOver(e:MouseEvent):void{
			fadeDangers(.1);
			fadeDanger(1);
			dc.sourceTooltip.addSourceTooltip(this);
		} // END extMouseOver()
		
		public function onMouseOut(e:MouseEvent):void{
			if(zoomActive==false){
				callPotential(e)
				extMouseOut(e);
			}
		} // END onMouseOut()
		
		public function extMouseOut(e:MouseEvent):void{
			fadeDangers(.85);
			dc.sourceTooltip.removeSourceTooltip();
		} // END extMouseOut()
		
		public function onMapZoom(e:Event):void{
			zoomActive = true;
			setBlur(gefahrenquelle, calculateBlur());
		} // END onMapZoom()
		
	} // END BuildingDanger
} // END package
