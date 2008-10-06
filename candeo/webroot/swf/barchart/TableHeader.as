//////////////////////////////////////////////////////////////////////////
//  TableHeader
//
//  Created by Benjamin Wiederkehr on 2008-04-07.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package barchart{
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import fl.motion.easing.*;
	import gs.TweenLite;
	
	/**
	 *	Table Header für die Vergleichsansicht
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-07
	 */
	public class TableHeader extends uiElement {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var pWidth			:Number;
		public var pHeight		:Number;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function TableHeader(_width:Number, _height:Number, _chart:MovieClip){
			//  DEFINITIONS
			//--------------------------------------
			_btn			= new Sprite();
			pWidth		= _width;
			pHeight		= _height;
			
			//  ATTACH
			//--------------------------------------
			addChild(_btn);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			
			//  CALLS
			//--------------------------------------
			super(_chart, _chart.dc);
			super.setLabel("G");
			draw();
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function draw():void{
			_btn.graphics.beginFill(0xFFFFFF, 1);
			_btn.graphics.drawRect(0, 0, pWidth, pHeight);
			_btn.graphics.endFill();
			fade(super.dc.UI_ALPHA);
		} // END draw()
		
		public function removeToggledBlocks(e:MouseEvent):void{
			if(chart.toggledBlock != null){
				chart.toggledBlock.toggled = false;
				var tBlock:BlockHeader = chart.toggledBlock;
				chart.toggledBlock = null;
				tBlock.extMouseOut(e);
				chart.fadeOut();
				super.dc.ui.header.removeFilter();
			};
		} // END removeToggledBlocks()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		override public function onMouseOver(e:MouseEvent):void{
			super.onMouseOver(e);
		} // END onMouseUp()
		override public function onMouseOut(e:MouseEvent):void{
			super.onMouseOut(e);
		} // END onMouseOut()
		override public function onMouseUp(e:MouseEvent):void{
			super.onMouseUp(e);
			if(chart.view != "tf"){
				chart.foldPotentials();
				chart.view = "tf";
			}else{
				chart.expandPotentials();
				chart.view = "ex";
			};
			removeToggledBlocks(e);
		} // END onMouseUp()
	} // END TableHeader
} // END package