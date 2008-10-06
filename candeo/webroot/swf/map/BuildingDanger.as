//////////////////////////////////////////////////////////////////////////
//  BuildingDanger
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
	
	/**
	 *	Dnager Klasse – Zeichnungsfunktionen und 
	 *	grundsätzliches Verhalten von Gefahren auf der Map
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-21
	 */
	public class BuildingDanger extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc								:Object;
		public var building					:Object;
		public var mapContainer			:Object;
		public var gefahrenquelle		:Sprite;
		public var matrix						:Matrix;
		public var blur							:BlurFilter
		public var maxZoomLevel			:Number;
		public var danger						:Number;
		public var risk							:Number;
		public var pBuildingBound		:Rectangle;
		public var blocksRadius			:Array;
		public var rowsRadius				:Array;
		public var tRadius					:Number;
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const MIN_BLUR				:int 	= 18;
		public const MAX_ADD_BLUR		:int 	= 50;
		public const RADIUS_FACTOR	:int 	= 200;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function BuildingDanger(_dc, _building){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc								= _dc;
			mapContainer			= dc.root.mapContainer_mc;
			building					= _building;
			maxZoomLevel			= mapContainer.zoomLevels.length+1;
			gefahrenquelle 		= null;
			matrix 						= new Matrix();
			blur 							= new BlurFilter();
			blocksRadius			= new Array();
			rowsRadius				= new Array();
			danger						= 0;
			risk							= 0;
			alpha							= 0;
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			DispatchController.addEventListener("zoomMapActive", onMapZoom);
			DispatchController.addEventListener("buildingMode", onMapZoom);
			building.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			building.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			building.buildingDanger = this;
			setRadius();
		} // END BuildingDanger()
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function ini():void{
			fadeDanger(.5);
			calcRadius(danger);
			drawDanger(tRadius);
			positionDanger();
		} // END ini()
		public function setRadius():void{
			for (var i:int = 0; i<=15; i++){
				rowsRadius.push(0);
			}
			for (var j:int = 0; j<4; j++){
				blocksRadius.push(0);
			}
		} // END setRadius()
		public function calcRadius(_danger):void{
			tRadius = _danger/RADIUS_FACTOR;
			if(tRadius < 10){ tRadius = 10 };
		} // END calcRadius()
		public function drawDanger(_radius:Number):void {
			// Danger zeichnen
			if(gefahrenquelle != null){
				removeChild(gefahrenquelle);
			};
			gefahrenquelle 		= new Sprite();
			matrix.createGradientBox(_radius*2, _radius*2, 0, -_radius, -_radius);
			gefahrenquelle.graphics.clear();
			gefahrenquelle.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF,0xFFE400,0xEA720D,0xFF0000,0xFF0000], [1,1,1,1,1], getColorRatios(_radius), matrix);
			gefahrenquelle.graphics.drawCircle(0, 0, _radius);
			gefahrenquelle.graphics.endFill();
			gefahrenquelle.cacheAsBitmap = true;
			gefahrenquelle.blendMode = BlendMode.SCREEN;
			setBlur(gefahrenquelle, calculateBlur());
			addChild(gefahrenquelle);
		} // END draw()
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
		
		public function positionDanger():void {
			pBuildingBound = building.getBounds(dc);
			x = pBuildingBound.x + pBuildingBound.width/2;
			y = pBuildingBound.y + pBuildingBound.height/2;
		} // END setPosition()
		
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
		
		public function fadeDangers(_alpha:Number, _duration:Number = .5):void{
			for(var i:Number = 0; i < dc.dangerLayer.buildingDangers.length; i++){
				dc.dangerLayer.buildingDangers[i].fadeDanger(_alpha, _duration);
			}
		} // END fadeBuildings()
		
		public function fadeDanger(_alpha:Number, _duration:Number = .5):void{
			//TweenLite.to(this, _duration, {alpha:_alpha, ease:Strong.easeOut});
			this.alpha = _alpha;
		} // END fadeBuilding()
		
		public function adaptSize(_size:Number):void{
			calcRadius(_size);
			//TweenLite.to(gefahrenquelle, 1, {width:tRadius, height:tRadius, ease:Strong.easeOut, onComplete:reDraw}); 
			reDraw();
		} // END adaptSize()
		
		public function adaptToFilter(_d:Object):void{
			if(danger > _d.max || danger < _d.min){
				fadeDanger(.1);
			};
		} // END adaptToFilter()
		
		public function reDraw():void{
			drawDanger(tRadius);
			positionDanger();
		} // END reDraw()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseOver(e:MouseEvent):void{
			if(dc.dangerLayer.fadeActive==false){
				fadeDangers(.04);
				fadeDanger(.85);
			}
		} // END extMouseOver()
		
		public function onMouseOut(e:MouseEvent):void{
			if(dc.dangerLayer.fadeActive==false){
				fadeDangers(.5);
			}
		} // END onMouseOut()
		
		public function onMapZoom(e:Event):void{
			setBlur(gefahrenquelle, calculateBlur());
		} // END onMapZoom()
		
	} // END BuildingDanger
} // END package
