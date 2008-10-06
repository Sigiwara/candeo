//////////////////////////////////////////////////////////////////////////
//  Potential
//
//  Created by Benjamin Wiederkehr on 2008-04-01.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package barchart{
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import gs.TweenLite;
	import tools.Calculations;
	import map.*;
	
	/**
	 *	Repräsentant für ein Gefahrenpotential
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-01
	 */
	public class Potential extends Sprite {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var dc					:Object;
		public var chart			:MovieClip;
		public var index			:Number;
		public var _rect			:Sprite;
		public var _con				:Sprite;
		public var row				:Number;
		public var dangerpot	:Number
		public var rowHeader	:RowHeader;
		public var blockHeader:BlockHeader;
		public var institute	:Object;
		public var areaHeader	:AreaHeader;
		public var area				:Number;
		public var block			:Number;
		public var dType			:String;
		public var pMaxHeight	:Number;
		public var pWidth			:Number;
		public var pHeight		:Number;
		public var ePos				:Number;	// Expanded Position
		public var fPos				:Number;	// Folded Position
		public var bfPos			:Number;	// Folded Block Position
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Potential(_chart:MovieClip, _width:Number, _height:Number, _row:Number, _potential:Number){
			//  DEFINITIONS
			//--------------------------------------
			dc					= _chart.dc;
			chart				= _chart;
			_rect				= new Sprite();
			_con				= new Sprite();
			
			row					= _row;
			dangerpot		= _potential;
			pMaxHeight	= _height;
			pWidth			= _width;
			//  ATTACH
			//--------------------------------------
			addChild(_rect);
			addChild(_con);
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//  CALLS
			//--------------------------------------
			//super();
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function ini():void{
			setHeight();
			draw();
			fade(dc.P_ALPHA);
		} // END init()
		public function draw():void
		{
			_rect.graphics.beginFill(0xFFFFFF, 1);
			_rect.graphics.drawRect(0, 0, pWidth, pHeight);
			_rect.graphics.endFill();
		} // END draw()
		
		public function drawCon():void
		{
			_con.graphics.clear();
			var tPot:Potential = chart.potentials[index-16];
			if(!tPot){
				_con.graphics.beginFill(0xFFFFFF, .5);
				_con.graphics.moveTo(rowHeader.x + chart.UI_WIDTH - x, rowHeader.y - y);
				_con.graphics.lineTo(0, 0);
				_con.graphics.lineTo(0, pHeight);
				_con.graphics.lineTo(rowHeader.x + chart.UI_WIDTH - x, rowHeader.y + chart.LINEHEIGHT - chart.V_MARGIN - y);
				_con.graphics.lineTo(rowHeader.x + chart.UI_WIDTH - x, rowHeader.y - y);
				_con.graphics.endFill();
			}else{
				_con.graphics.beginFill(0xFFFFFF, .5);
				_con.graphics.moveTo(tPot.x + tPot.pWidth - x, tPot.y - y);
				_con.graphics.lineTo(0, 0);
				_con.graphics.lineTo(0, pHeight);
				_con.graphics.lineTo(tPot.x + tPot.pWidth - x, tPot.y + tPot.pHeight - y);
				_con.graphics.lineTo(tPot.x + tPot.pWidth - x, tPot.y - y);
				_con.graphics.endFill();
			}
		} // END draw()
		
		public function registerHeader():void
		{
			rowHeader = chart.rowHeaders[row];
			rowHeader.potentials.push(this);
			blockHeader = chart.blockHeaders[block];
			blockHeader.potentials.push(this);
		} // END registerRowHeader()
		
		public function setHeight():void{
			pHeight = dc.dangerLayer.calcHeight(row, dangerpot);
			if(pHeight < 1 && pHeight > 0){ pHeight = 1};
		} // END setHeight()
		
		public function fade(_alpha:Number):void
		{
			_rect.alpha	= _alpha;
			_con.alpha	= _alpha/3;
		} // END fadeOut()
		
		public function fadeCon(_alpha:Number):void
		{
			_con.alpha	= _alpha;
		} // END fadeOut()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		private function onMouseDown(e:MouseEvent):void{
		} // END onMouseDown()
		private function onMouseUp(e:MouseEvent):void{
		} // END onMouseUp()
		private function onMouseOver(e:MouseEvent):void{
			if(chart.toggledArea == null){
				chart.fadeIn({what:"potential", who:[index]});
			}else{
				if(chart.toggledArea != areaHeader){
					fade(dc.O_ALPHA);
					fadeCon(dc.F_ALPHA);
				}
			}
			var tTarget:Object = new Object();
			tTarget.sourcetype = dType;
			tTarget.name = chart.rowTitles[row] + " " + dType;
			tTarget.potential = dangerpot;
			tTarget.building = institute.ch.buildingsMC[0];
			dc.potentialTooltip.addPotentialTooltip(tTarget);
		} // END onMouseOver()
		private function onMouseOut(e:MouseEvent):void{
			if(chart.toggledArea == null){
				if(chart.toggledRows.length == 0){
					chart.fadeOut();
				}else{
					if(rowHeader.toggled){
						fade(dc.O_ALPHA)
					}else{
						fade(dc.F_ALPHA)
					};
				};
			}else{
				if(chart.toggledArea != areaHeader){
					fade(dc.F_ALPHA)
				};
			};
			dc.potentialTooltip.removePotentialTooltip()
		} // END onMouseOut()
	} // END Potential
} // END package