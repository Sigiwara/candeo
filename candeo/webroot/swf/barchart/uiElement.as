//////////////////////////////////////////////////////////////////////////
//  uiElement
//
//  Created by Benjamin Wiederkehr on 2008-04-03.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package barchart{
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import tools.Calculations;
	
	/**
	 *	User Interface Basis Klasse
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-03
	 */
	public class uiElement extends Sprite {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var dc				:Object;
		public var _btn			:Sprite;
		public var chart		:MovieClip;
		public var label		:TextField;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function uiElement(_chart:MovieClip, _dc:Object){
			//  DEFINITIONS
			//--------------------------------------
			dc						= _dc;
			chart					= _chart;
			useHandCursor	= true;
			buttonMode		= true;
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//  CALLS
			//--------------------------------------
			_btn.addChild(configureLabel());
		}
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function configureLabel():TextField {
			if(label){removeChild(label);}
			label = new TextField();
			label.autoSize		= TextFieldAutoSize.LEFT;
			label.background	= false;
			label.border			= false;
			label.selectable	= false;
			label.defaultTextFormat = styleLabel();
			label.y = -1;
			return label;
		} // END configureLabel()
		public function setLabel(str:String):void {
			label.text = str;
		} // END setLabel()
		public function styleLabel():TextFormat{
			var format:TextFormat = new TextFormat();
			format.font				= "DIN-Regular";
			format.color			= 0xFFFFFF;
			format.size				= 10;
			format.underline	= false;
			return format;
		} // END styleLabel()
		public function fade(_alpha):void{
			_btn.alpha = _alpha;
		} // END fade()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseDown(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			fade(dc.A_ALPHA);
		} // END onMouseDown()
		public function onMouseUp(e:MouseEvent):void{
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			fade(dc.O_ALPHA);
		} // END onMouseUp()
		public function onMouseOver(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			label.textColor = 0x000000;
			fade(dc.O_ALPHA);
		} // END onMouseOver()
		public function onMouseOut(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			label.textColor = 0xFFFFFF;
			fade(dc.UI_ALPHA);
		} // END onMouseOut()
		public function onMouseMove(e:MouseEvent):void{
			e.updateAfterEvent();
		} // END onMouseMove()
	} // END uiElement
} // END package
