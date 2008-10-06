//////////////////////////////////////////////////////////////////////////
//  ZoomUIElement
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
	public class ZoomUIElement extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var zoomUI						:Object;
		public var dc								:Object;
		public var mapContainer			:Object;
		public var id								:Number;
		public var fadeElementActive:Boolean;
		public var viewMode					:String;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		public function ZoomUIElement(){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			alpha							= .2;
			id								= parent.getChildIndex(this)-1;
			fadeElementActive = false;
			viewMode					= "mapMode";
			buttonMode				= true;
			useHandCursor			= true;
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			parent.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			parent.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			DispatchController.addEventListener("zoomUIAttached", registrateElements);
			DispatchController.addEventListener("zoomMapActive", resetFadeElementActivity);
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
		}
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onEnterFrame(e:Event):void{
			checkZoomLevel();
		} // END ()
		
		public function onMouseDown(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		} // END onMouseDown()
		
		public function onMouseUp(e:MouseEvent):void{
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		} // END onMouseUp()
		
		public function onMouseMove(e:MouseEvent):void{
			if(viewMode=="mapMode"){
				fadeElements(.2);
				fadeElement(1);
				mapContainer.zoomLevel = id;	
				mapContainer.zoomMap(id, "normal");
			}
		} // END onMouseOver()
		
		public function resetFadeElementActivity(e:Event):void{
			fadeElementActive=false;
		} // END resetFadeElementActivity()
		
		public function registrateElements(e:Event):void{
			dc	= CandeoDC.root;
			mapContainer = dc.root.mapContainer_mc;
			zoomUI = parent;
			zoomUI.elements.push(this);
			if(id==0){
				fadeElements(.2);
				fadeElement(1);
			}
		} // END registrateElements()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function fadeElements(_alpha:Number, _delay:Number = 0):void{
			for(var i:Number = 0; i < zoomUI.elements.length; i++){
				zoomUI.elements[i].fadeElement(_alpha, _delay);
			}
		} // END fadeElements()
		
		public function fadeElement(_alpha:Number, _delay:Number = 0):void{
			fadeElementActive=true;
			TweenLite.to(this, .5, {alpha:_alpha, delay:_delay, ease:Strong.easeOut}); 
		} // END fadeElement()
		
		public function checkZoomLevel():void{
			if(fadeElementActive==false){
				if(id==mapContainer.zoomLevel){
					fadeElements(.2);
					fadeElement(1);
				}
			}
		} // END checkZoomLevel()
		
	} // END ZoomUIElement
} // END package
