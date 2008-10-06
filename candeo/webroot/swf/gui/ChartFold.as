//////////////////////////////////////////////////////////////////////////
//  ChartFold
//
//  Created by Benjamin Wiederkehr on 2008-05-22.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package gui{
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import fl.motion.easing.*;
	import gs.TweenLite;
	import barchart.*;
	
	/**
	 *	Chart Folder um das Chart ein-/aus zu blenden
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-07
	 */
	public class ChartFold extends uiElement {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var pWidth			:Number;
		public var pHeight		:Number;
		public var _canvas		:Sprite;
		public var _mask			:Sprite;
		public var _arrow			:Sprite;
		public var btnPos			:Number;
		public var chartOpen	:Boolean;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ChartFold(_width:Number, _height:Number, _chart:MovieClip){
			//  DEFINITIONS
			//--------------------------------------
			_mask			= new Sprite();
			_btn			= new Sprite();
			//_arrow		= new Arrow();
			pWidth		= _width;
			pHeight		= _height;
			chartOpen	= true;
			
			//  ATTACH
			//--------------------------------------
			addChild(_btn);
			addChild(_mask);
			_btn.addChild(_arrow);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			//  CALLS
			//--------------------------------------
			super(_chart, _chart.dc);
			display();
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function display():void{
			drawMask();
			drawBtn();
			positionBtn();
			fade(super.dc.UI_ALPHA);
		} // END display()
		public function drawMask():void{
			_mask.graphics.beginFill(0x000000, .25);
			_mask.graphics.drawRect(0, 0, pWidth, pHeight*2);
			_mask.graphics.endFill();
		} // END drawMask()
		public function drawBtn():void{
			_btn.graphics.beginFill(0xFFFFFF, 1);
			_btn.graphics.drawRect(0, 0, pWidth, pHeight);
			_btn.graphics.endFill();
			_arrow.rotation = 90;
			_arrow.x = _btn.width/2 - _arrow.width/2;
			_arrow.y = 3;
		} // END drawBtn()
		public function positionBtn():void{
			btnPos		= -_btn.height;
			_btn.y		= 0;
			_mask.y		= -_btn.height;;
			_btn.mask	= _mask;
		} // END draw()
		
		public function hide():void{
			label.textColor = super.chart.dc.BACKGROUND;
			var tHiddenPos:Number = - super.chart.C_PADDING;
			TweenLite.to(_btn, 1.5, {y:tHiddenPos, alpha:0, delay: 0, ease:Exponential.easeIn});
		} // END hide()
		
		public function show():void{
			//label.textColor = 0x000000;
			TweenLite.to(_btn, 1.5, {y:btnPos, alpha:super.chart.dc.UI_ALPHA, delay: 0, ease:Exponential.easeOut});
		} // END show()
		
		public function setArrow(_chartOpen:Boolean):void{
			if(_chartOpen){
				TweenLite.to(_arrow, 1, {rotation:-90, delay: 0, ease:Exponential.easeOut});
			}else{
				TweenLite.to(_arrow, 1, {rotation:90, delay: 0, ease:Exponential.easeOut});
			}
		} // END setArrow()
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
			setArrow(chartOpen);
			super.chart.toggleChart(chartOpen);
			chartOpen != chartOpen;
		} // END onMouseUp()
	} // END ChartFold
} // END package