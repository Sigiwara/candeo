//////////////////////////////////////////////////////////////////////////
//  CloseButton
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
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-22
	 */
	public class CloseButton extends Button {
		//--------------------------------------
		//  Variables
		//--------------------------------------
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function CloseButton(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			super(_dc);
		}
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		override public function onMouseOver(e:MouseEvent):void{
			super.onMouseOver(e);
			buttonIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -255, -255, -255);
		} // END mouseOver()
		
		override public function onMouseOut(e:MouseEvent):void{
			buttonIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 255);
			super.onMouseOut(e);
		} // END mouseOut()
		
		override public function onMouseUp(e:MouseEvent):void{
			super.onMouseUp(e);
			if(super.dc.ui.zoomOutButton.viewMode=="buildingMode"){
				dc.map_container.resetZoom();
			};
		} // END onMouseUp()
	
	}
}
