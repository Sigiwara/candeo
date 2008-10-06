//////////////////////////////////////////////////////////////////////////
//  MapContainer
//
//  Created by Christian Siegrist on 08-04-28.
//  Copyright (c) 2008 Christian Siegrist / Significant.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package map {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.net.*;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	import flash.text.*;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import tools.*;
	import barchart.*;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-04-28
	 */
	public class MapContainer extends Sprite {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc								:Object;
		public var tChart						:Chart;
		public var detailBuilding		:Building;
		public var lastPosition			:Object;
		public var zoomTween				:TweenLite;
		public var zoomLevels				:Array;
		public var overviewZoom			:Boolean;
		public var viewMode					:String;
		public var originalWidth		:Number;
		public var originalHeight		:Number;
		public var zoomLevel				:Number;
		public var zoomInterval			:uint;
		public var areaZooms				:Array;
		public var offsetY					:Number;
		public var acc							:Number;
		public var dec							:Number;
		public var trac							:Number;
		public var maxVel						:Number;
		public var stopVel					:Number;
		public var velR							:Number;
		public var velL							:Number;
		public var velU							:Number;
		public var velD							:Number;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function MapContainer(){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc									= parent.root;
			detailBuilding			= null;
			offsetY							= 2/3;
			streets.alpha				= .1;
			height							= dc.stage.stageHeight*offsetY;
			width								= dc.stage.stageWidth;
			x 									= 0;
			y										= 0;
			scaleX							= 1;
			originalWidth				= width;
			originalHeight			= height;
			overviewZoom				= false;
			doubleClickEnabled	= true;
			viewMode						= "mapMode";
			zoomLevels					= [1, 1.1, 1.3, 1.6, 2, 2.5, 3.1, 3.8, 4.6, 5.5, 6.5, 7.6, 8.8, 10.1, 11.5];
			zoomLevel						= 0;
			acc									= 1.75;
			dec									= 0.5;
			trac								= .75;
			maxVel							= 20;
			stopVel							= 0.4;
			velR = velL = velU = velD = 0;
			cacheAsBitmap				= true;
			areaZooms						= [{xPos: -1169, yPos: -1642}, {xPos: -1577, yPos: -1115}, {xPos: -1319, yPos: -633}, {xPos: -2111, yPos: -1295}, {xPos: 0, yPos: 0}];
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			DispatchController.addEventListener("dcAttached", onDcAttached);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			Key.initialize(stage);
		} // END MapContainer()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onEnterFrame(e:Event):void{
			if(viewMode=="mapMode"){
				keyNavigation();
			}
		} // END onEnterFrame()
		
		public function onMouseDown(event:MouseEvent):void{
			if(viewMode=="mapMode"){
				startDrag();
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		} // END onMouseDown()
		
		public function onMouseUp(event:MouseEvent):void{
				stopDrag();
				removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		} // END onMouseUp()
		
		public function onMouseMove(event:MouseEvent):void{
			TweenLite.removeTween(zoomTween);
			overviewZoom = false;
		} // END onMouseMove()
		
		public function doubleClickHandler(event:MouseEvent):void{
			clearInterval(zoomInterval);
			if(viewMode=="mapMode"){
				if(zoomLevel<zoomLevels.length-2){
					// Parameter: _function, _intervalDuration, _endZoom, _zoomMode
					zoomInterval = setInterval(zoom, 100, zoomLevel+2, "cursor");
				} else {
					// Parameter: _function, _intervalDuration, _endZoom, _zoomMode
					zoomInterval = setInterval(zoom, 100, zoomLevel+1, "cursor");
				}
			}
		} // END doubleClickHandler()
		
		public function keyDownHandler(event:KeyboardEvent):void{
			clearInterval(zoomInterval);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			switch(event.keyCode){
				// Space
				case 32:
				savePosition();
					trace("lastPosition X"+lastPosition.lastX);
					trace("lastPosition Y"+lastPosition.lastY);
					if(viewMode=="mapMode"){
						if(overviewZoom==false){
							savePosition();
						}
						// Parameter: _function, _intervalDuration, _endZoom, _zoomMode
						zoomInterval = setInterval(zoom, 100, 0, "overview");
					}
					break;
			}
		} // END keyDownHandler()
		
		public function keyUpHandler(event:KeyboardEvent):void{
			clearInterval(zoomInterval);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyDownHandler);
			switch(event.keyCode){
				// Space
				case 32:
					resetZoom();
					break;
			}
		} // END keyUpHandler()
		
		public function onMouseWheel(event:MouseEvent) {
			clearInterval(zoomInterval);
			if(viewMode=="mapMode"){
				if(event.delta > 0 && zoomLevel<zoomLevels.length-1){
					// Parameter: _function, _intervalDuration, _endZoom, _zoomMode
					zoomInterval = setInterval(zoom, 100, zoomLevel++, "normal");			
				}
				if(event.delta < 0 && zoomLevel>0){
					// Parameter: _function, _intervalDuration, _endZoom, _zoomMode
					zoomInterval = setInterval(zoom, 100, zoomLevel--, "normal");			
				}
			}
		} // END onMouseWheel()
		
		public function onDcAttached(e:Event):void{
		} // END onDcAttached()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function updateMap():void{
			controlMapPosition();
		} // END updateMap()
		
		public function zoom():void{
			zoomMap(arguments[0], arguments[1]);
			if(zoomLevel<arguments[0]){
				zoomLevel++;
			}
			if(zoomLevel>arguments[0]){
				zoomLevel--;
			}
			if(zoomLevel==arguments[0]){
				clearInterval(zoomInterval);
			}
		} // END zoom()
		
		public function zoomMap(_zoomLevel:Number = 0, zoomCase:String = "normal", _building:Building = null, _area:Number = 0):void{
			DispatchController.dispatchEvent(new Event("zoomMapActive"));
			var zoom:Number = zoomLevels[_zoomLevel];
			var durationTween:Number;
			var newX:Number;
			var newY:Number;
			switch(zoomCase){
				case "normal":
					overviewZoom = false;
					durationTween = 3;
					newX = x+((stage.stageWidth*.5-x)-(stage.stageWidth*.5-x)/scaleX*zoom);
					newY = y+((stage.stageHeight*offsetY*.5-y)-(stage.stageHeight*offsetY*.5-y)/scaleX*zoom);
					break;
				case "cursor":
					overviewZoom = false;
					durationTween = 3;
					newX = stage.stageWidth*.5-mouseX*zoom;
					newY = stage.stageHeight*offsetY*.5-mouseY*zoom;
					break;
				case "overview":
					overviewZoom = true;
					durationTween = 1.5;
					newX = 0;
					newY = 0;
					break;
				case "switch":
					overviewZoom = true;
					durationTween = 3;
					newX = 0;
					newY = -stage.stageHeight*offsetY*.5;
					viewMode = "mapMode";
					DispatchController.dispatchEvent(new Event("mapMode"));
					zoomTween = TweenLite.to(this, durationTween, {scaleX:zoom, scaleY:zoom, x:newX, y:newY, ease:Strong.easeOut, onUpdate:updateMap, onComplete:_building.extMouseUp, onCompleteParams:[new MouseEvent("onMouseUp")]});
					return;
				case "reset":
					durationTween = 3;
					newX = lastPosition.lastX;
					newY = lastPosition.lastY;
					zoom = lastPosition.lastScaleX;
					break;
				case "area":
					overviewZoom = false;
					durationTween = 3;
					// TODO: Area positions debugging
					var tPos:Object = areaZooms[_area];
					newX = tPos.xPos;
					newY = tPos.yPos;
					break;
			}
			zoomTween = TweenLite.to(this, durationTween, {scaleX:zoom, scaleY:zoom, x:newX, y:newY, ease:Strong.easeOut, onUpdate:updateMap, onComplete:onFadeComplete});
		} // END zoomMap()
		
		public function onFadeComplete():void{
			if(dc.dangerLayer.buildingDangers.length==0){
				DispatchController.dispatchEvent(new Event("resetComplete"));
			}
		} // END onFadeComplete()
		
		public function controlMapPosition():void{
			if(x > 0){
				x = 0;
			}
			if(x+width < stage.stageWidth){
				x = stage.stageWidth-width;
			}
			if(y > 0){
				y = 0;				
			}
			if(y+height < stage.stageHeight*offsetY){
				y = (stage.stageHeight*offsetY)-height;
			}
		} // END controlMapPosition()
		
		public function savePosition():void{
			lastPosition = {lastZoom:zoomLevel, lastX:x, lastY:y, lastScaleX:scaleX};
		}	 // END savePosition()
		
		public function zoomToBuilding(target:Sprite, _originalWidth, _originalHeight):void{
			var zoom:Number;
			viewMode="buildingMode";
			DispatchController.dispatchEvent(new Event("buildingMode"));
			if(target.width>target.height){
				var deltaWidth:Number = originalWidth/(_originalWidth*1.8)*offsetY;
				zoom = deltaWidth;
			} else {
				var deltaHeight:Number = originalHeight/(_originalHeight*1)*offsetY;
				zoom = deltaHeight;
			}
			var newX:Number = stage.stageWidth*.5-(target.x+(target.width/2))*zoom;
			var newY:Number = stage.stageHeight*offsetY*.5-(target.y+(target.height/2))*zoom;
			TweenLite.to(this, 3, {scaleX:zoom, scaleY:zoom, x:newX, y:newY, ease:Strong.easeOut, onUpdate:updateMap, onComplete:dc.dangerLayer.displaySourceDanger}); 
			dc.dangerLayer.removeBuildingDanger();
		} // END zoomToBuilding()
		
		public function resetZoom():void{
			viewMode="mapMode";
			DispatchController.dispatchEvent(new Event("mapMode"));
			zoomInterval = setInterval(zoom, 100, lastPosition.lastZoom, "reset");
			// CHANGED:Direkter Zoom zur Übersicht zurück anstatt zu der vorherigen Zoomstufe
			//zoomMap(lastPosition.lastZoom, "reset");
			zoomMap(0, "overview");
			var e:MouseEvent = new MouseEvent("mouseUp");
			if(tChart.detailInstitute != null){
				tChart.detailInstitute.extMouseUp(e);
			};
		} // END resetZoom()
		
		public function keyNavigation():void{
			//Right Control ------------------------------------------------------------
			if(Key.isDown(Keyboard.LEFT) && x < 0) {
				TweenLite.removeTween(zoomTween);
				overviewZoom = false;
				if(velR < maxVel) {					// Is the speed less than the top speed?
					velR += acc;							// If it is, increase speed.
				}
				x += velR;									// Move the current speed
			} else if (x > 0) {	
				x = 0;
				velR *= -1*trac;						// Bounce Effect
			} else {											// If "RIGHT" is no longer pressed.
				if (velR > 0){							// If speed is greater than 0? (Are you still moving?)
					if(velR > stopVel){
					velR -= dec;															// Slow down.
					}else{
					velR = 0;
					}
				}else if(velR < 0){
					if(velR < -stopVel){
					velR += dec;															// Slow down.
					}else{
					velR = 0;
					}
				}
				x += velR;									// Move the current speed.
			}
			// Left Control -------------------------------------------------------------
			if (Key.isDown(Keyboard.RIGHT) && x > stage.stageWidth - width) {
				TweenLite.removeTween(zoomTween);
				overviewZoom = false;
				if (velL < maxVel) {												// Is the speed less than the top speed?
					velL += acc;															// If it is, increase speed.
				}
				x -= velL;									// Move the current speed
			} else if (x < stage.stageWidth - width) {
				x = stage.stageWidth - width;
				velL *= -1*trac;														// Bounce Effect
			} else {																			// If "LEFT" is no longer pressed.
				if (velL > 0){															// If speed is greater than 0? (Are you still moving?)
					if(velL > stopVel){
					velL -= dec;															// Slow down.
					}else{
					velL = 0;
					}
				}else if(velL < 0){
					if(velL < -stopVel){
					velL += dec;															// Slow down.
					}else{
					velL = 0;
					}
				}
				x -= velL;									// Move the current speed.
			}
			// Down Control -------------------------------------------------------------
			if (Key.isDown(Keyboard.UP) && y < 0) {
				TweenLite.removeTween(zoomTween);
				overviewZoom = false;
				if (velD < maxVel) {												// Is the speed less than the top speed?
					velD += acc;															// If it is, increase speed.
				}
				y += velD;									// Move the current speed
			} else if (y > 0) {						// Is this out of bound?
				y = 0;											// And move it back in bounds.
				velD *= -1*trac;														// Bounce Effect
			} else {																			// If "DOWN" is no longer pressed.
				if (velD > 0){															// If speed is greater than 0? (Are you still moving?)
					if(velD > stopVel){
					velD -= dec;															// Slow down.
					}else{
					velD = 0;
					}
				}else if(velD < 0){
					if(velD < -stopVel){
					velD += dec;															// Slow down.
					}else{
					velD = 0;
					}
				}
				y += velD;														// Move the current speed.
			}
			// Up Control ---------------------------------------------------------------
			if (Key.isDown(Keyboard.DOWN) && y > stage.stageHeight*offsetY - height) {
				TweenLite.removeTween(zoomTween);
				overviewZoom = false;
				if (velU < maxVel) {												// Is the speed less than the top speed?
					velU += acc;															// If it is, incease speed.
				}
				y -= velU;									// Move the current speed
			} else if (y < stage.stageHeight*offsetY - height) {
				y = (stage.stageHeight*offsetY) - height;
				velU *= -1*trac;														// Bounce Effect
			} else {																			// If "UP" is no longer pressed.
				if (velU > 0){															// If speed is greater than 0? (Are you still moving?)
					if(velU > stopVel){
					velU -= dec;															// Slow down.
					}else{
					velU = 0;
					}
				}else if(velU < 0){
					if(velU < -stopVel){
					velU += dec;															// Slow down.
					}else{
					velU = 0;
					}
				}
				y -= velU;								// Move the current speed.
			}
		} // END keyNavigation()
	} // END MapContainer
} // END package
