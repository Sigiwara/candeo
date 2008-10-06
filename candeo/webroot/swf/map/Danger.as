//////////////////////////////////////////////////////////////////////////
//  Danger
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
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
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
	public class Danger extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc								:Object;
		public var building					:Object;
		public var mapContainer			:Object;
		public var gefahrenquelle		:Sprite;
		public var matrix						:Matrix;
		public var blur							:BlurFilter
		public var radius						:Number;
		public var maxZoomLevel			:Number;
		public var danger						:Number;
		public var risk							:Number;
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const MIN_BLUR				:int 	= 12;
		public const MAX_ADD_BLUR		:int 	= 40;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Danger(_building, _dc, _mapContainer){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc								= _dc;
			building					= _building;
			mapContainer			= _mapContainer;
			maxZoomLevel			= mapContainer.zoomLevels.length+1;
			radius						= Math.random()*45;
			gefahrenquelle 		= new Sprite();
			matrix 						= new Matrix();
			blur 							= new BlurFilter();
			x									= building.width/2;
			y									= building.height/2;
			danger						= 0;
			risk							= 0;
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			DispatchController.addEventListener("zoomMapActive", onMapZoom);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			super();
			calcDanger();
			draw(radius);
		} // END Danger()
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function draw(_radius:Number):void {
			// Danger zeichnen
			matrix.createGradientBox(_radius*2, _radius*2, 0, -_radius, -_radius);
			var colorRatios_array:Array = getColorRatios(_radius);			
			gefahrenquelle.graphics.beginGradientFill(GradientType.RADIAL, [0xFFFFFF,0xFFE400,0xEA720D,0xFF0000,0xFF0000], [.8,.8,.8,.8,.8], colorRatios_array, matrix);
			gefahrenquelle.graphics.drawCircle(0, 0, _radius);
			gefahrenquelle.graphics.endFill();
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
			blur.quality = BitmapFilterQuality.MEDIUM;
			_sprite.filters = [blur];
		} // END setBlur()
		
		public function getColorRatios(_radius:Number):void {
			if(_radius>40){
				return [10,100,150,200,255];
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
		
		public function displayDanger():void{
			// Danger positionieren & anzeigen 
		} // END displayDanger()
		
		public function removeDanger():void{
			// Danger entfernen
		} // END removeDanger()
		
		public function calcDanger():void{
			// Grösse von Danger ausrechnen
		} // END calcDanger()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMapZoom(e:Event):void{
			setBlur(gefahrenquelle, calculateBlur());
		} // END onMapZoom()
		
	} // END Danger
} // END package
