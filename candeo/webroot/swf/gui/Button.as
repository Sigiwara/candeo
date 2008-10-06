//////////////////////////////////////////////////////////////////////////
//  Button
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
	import fl.transitions.easing.*;
	import gs.TweenLite;
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-22
	 */
	public class Button extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var bg			:Sprite;
		public var dc			:Object;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Button(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			bg							= new Sprite();
			dc							= _dc;
			buttonMode 			= true;
			useHandCursor 	= true;
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			drawBackground();
		} // END Button()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function drawBackground():void{
			bg.graphics.clear();
			bg.graphics.beginFill(0xFFFFFF,1);
			bg.graphics.drawRect(0,0,16,16);
			bg.graphics.endFill()
			bg.alpha = dc.UI_ALPHA;
			addChildAt(bg,0);
		} // END drawBackground()
		
		public function fade(_alpha):void{
			TweenLite.to(bg, 1, {alpha:_alpha, ease:Strong.easeOut});
		} // END fade()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseDown(e:MouseEvent):void{
			alpha = dc.A_ALPHA;
		} // END onMouseDown()
		
		public function onMouseUp(e:MouseEvent):void{
			alpha = dc.O_ALPHA;
		} // END onMouseUp()
		
		public function onMouseOver(e:MouseEvent):void{
			fade(dc.O_ALPHA);
		} // END onMouseOver()
		
		public function onMouseOut(e:MouseEvent):void{
			fade(dc.UI_ALPHA);
		} // END onMouseOut()

	} // END Button
} // END package
