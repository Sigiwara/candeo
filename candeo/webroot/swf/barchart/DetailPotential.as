//////////////////////////////////////////////////////////////////////////
//  DetailPotential
//
//  Created by Benjamin Wiederkehr on 2008-05-14.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package barchart {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import tools.Calculations;
	import map.*;
	import barchart.*;
	
	/**
	 *	Potential in the Detail Container.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-14
	 */
	public class DetailPotential extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var chart			:Chart;
		public var container	:DetailContainer;
		public var rowHeader	:RowHeader;
		public var index			:Number;
		public var _rect			:Sprite;
		public var record			:Object;
		public var danger_mc	:SourceDanger;
		public var row				:Number;
		public var institute	:Number;
		public var area				:Number;
		public var block			:Number;
		public var pWidth			:Number;
		public var pHeight		:Number;
		public var pos				:Number;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function DetailPotential(_record:Object, _height:Number, _row:int, _chart:Chart, _container:DetailContainer){
			//  DEFINITIONS
			//--------------------------------------
			chart				= _chart;
			container		= _container;
			record			= _record;
			rowHeader		= chart.rowHeaders[_row];
			_rect				= new Sprite();
			row					= _row;
			pWidth			= calcWidth(record);
			pHeight			= _height;
			
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			//  ATTACH
			//--------------------------------------
			addChild(_rect);
			
			//  CALLS
			//--------------------------------------
			super();
			draw();
			fade(chart.dc.P_ALPHA);
			danger_mc = chart.dc.dangerLayer.addSourceDanger(chart.dc.map_container.detailBuilding, this);
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function draw():void
		{
			_rect.graphics.beginFill(0xFFFFFF, 1);
			_rect.graphics.drawRect(0, 0, pWidth, pHeight);
			_rect.graphics.endFill();
		} // END draw()
		
		public function fade(_alpha:Number):void
		{
			_rect.alpha	= _alpha;
		} // END fadeOut()
		
		public function calcWidth(_record:Object):Number
		{
			var tWidth = _record.potential;
			if(tWidth < 1 && tWidth > 0){ tWidth = 1};
			if(tWidth > 100){ tWidth = 100};
			return tWidth;
		} // END calcWidth()
		public function callDanger(e:MouseEvent):void{
			switch(e.type){
				case "mouseOver":
				if(chart.toggledArea == null){
					if(chart.toggledRows.length == 0){
						danger_mc.extMouseOver(e);
					};
				};
				break;
				case "mouseOut":
				if(chart.toggledArea == null){
					if(chart.toggledRows.length == 0){
						danger_mc.extMouseOut(e);
					};
				};
				break;
			}
		} // END callDanger()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onMouseOver(e:MouseEvent):void{
			callDanger(e);
			extMouseOver(e);
		} // END onMouseOver()
		public function extMouseOver(e:MouseEvent):void{
			// FIXME: Debugging der hover und out funktionen
			if(chart.toggledArea == null){
				if(chart.toggledRows.length == 0){
					chart.fadeIn({what:"detailPotential", who:[index]});
				};
			}else{
				if(chart.toggledArea.pIndex != block){
					fade(chart.dc.O_ALPHA);
				};
			};
		} // END extMouseOver()
		public function onMouseOut(e:MouseEvent):void{
			callDanger(e);
			extMouseOut(e);
		} // END onMouseOut()
		public function extMouseOut(e:MouseEvent):void{
			if(chart.toggledArea == null){
				if(chart.toggledRows.length == 0){
					chart.fadeOut();
				}else{
					if(rowHeader.toggled){
						fade(chart.dc.O_ALPHA);
					}else{
						fade(chart.dc.F_ALPHA);
					};
				};
			}else{
				if(chart.toggledArea.pIndex != block){
					fade(chart.dc.F_ALPHA);
				};
			};
		} // END ()
	} // END DetailPotential
} // END package