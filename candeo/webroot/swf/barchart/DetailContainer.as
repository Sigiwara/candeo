//////////////////////////////////////////////////////////////////////////
//  DetailContainer
//
//  Created by Benjamin Wiederkehr on 2008-05-09.
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
	import fl.motion.easing.*;
	import gs.TweenLite;
	import tools.Calculations;
	import gui.*;
	
	/**
	 *	Container für das Detail Chart eines Institutes.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-09
	 */
	public class DetailContainer extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var data					:Object;
		public var chart				:Chart;
		public var _btn					:Sprite;
		public var rows					:Array;
		public var potentials		:Array;
		public var rowPotentials:Array;
		public var pXPos				:Number;
		public var pYPos				:Number;
		public var pWidth				:Number;
		public var pHeight			:Number;
		public var closeButton	:CloseButton;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function DetailContainer(_xPos:Number, _yPos:Number, _width:Number, _height:Number, _chart:Chart, _rows:Array, _data:Object){
			//  DEFINITIONS
			//--------------------------------------
			data					= _data;
			chart					= _chart;
			_btn					= new Sprite();
			rows					= _rows;
			pXPos					= _xPos;
			pYPos					= _yPos;
			pWidth				= _width;
			pHeight				= _height;
			
			//  ATTACH
			//--------------------------------------
			addChild(_btn);
			//  LISTENERS
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		
			//  CALLS
			//--------------------------------------
			draw();
			shrink();
			display();
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function draw():void
		{
			_btn.graphics.lineStyle(1, 0xffffff, .5)
			_btn.graphics.beginFill(chart.dc.BACKGROUND, 1);
			_btn.graphics.drawRect(0, 0, pWidth, pHeight);
			_btn.graphics.endFill();
		} // END draw()
		
		public function shrink():void
		{
			this.width	= chart.POT_WIDTH;
			this.x			= data.xPos;
			this.y			= pYPos;
		} // END shrink()
		
		public function display():void
		{
			TweenLite.to(this, .75, {x:pXPos, width:pWidth, onComplete:swapData, onCompleteParams:[data]});
		} // END display()
		
		public function hide():void
		{
			TweenLite.to(this, .75, {x:data.xPos, width:chart.POT_WIDTH, onComplete:removeContainer, onCompleteParams:[data]});
		} // END hide()
		
		public function removeContainer(_data:Object):void
		{
			chart.detailInstitute.closeTab();
			resetTabs();
			chart.detailContainer = null;
			chart.detailInstitute = null;
			chart.removeChild(this)
		} // END removeContainer()
		
		public function swapData(_data:Object):void
		{
			data = _data;
			if(chart.detailInstitute != null){
				chart.detailInstitute.closeTab();
				resetTabs();
			}
			chart.detailInstitute = data.ch;
			data.ch.openTab();
			drawPotentials();
			addCloseButton();
		} // END swapData()
		
		public function drawPotentials():void
		{
			removePotentials();
			clearRowArray();
			for each (var r:Object in data.ch.institute.records){
				distributePotentials(r)
			};
			potentials	= new Array();
			for (var i:int = 0; i<=chart.LINES; i++ ) {
				var hOffset = 0;
				for (var j:int = 0; j<rowPotentials[i].length; j++){
					var pot:DetailPotential;
					pot				= new DetailPotential(rowPotentials[i][j], chart.LINEHEIGHT-chart.V_MARGIN, i, chart, this);
					pot.x			= 2*chart.UI_MARGIN + hOffset;
					pot.y			= height - chart.LINEHEIGHT*(i) - pot.height - chart.C_PADDING - 1;
					pot.block	= Calculations.calcBlock(i);
					pot.index	= chart.detailPotentials.length;
					potentials.push(pot);
					chart.detailPotentials.push(pot);
					hOffset += pot.width + chart.UI_MARGIN;
					addChild(pot);
				};
			};
		} // END drawPotentials()
		
		public function removePotentials():void
		{
			for each(var pot:DetailPotential in potentials){
				removeChild(pot);
			};
		} // END removePotentials()
		
		public function clearRowArray():void{
			rowPotentials = new Array();
			for (var i:int = 0; i<=chart.LINES; i++){
				var arr:Array = new Array();
				rowPotentials.push(arr);
			};
		} // END clearRowArray()
		
		public function distributePotentials(_r:Object):void{
			var tRow:Number = _r.row;
			rowPotentials[tRow].push(_r);
		} // END distributePotentials()
		
		public function resetTabs():void{
			if(chart.detailInstitute.areaHeader != chart.toggledArea){
				chart.detailInstitute.label.textColor = 0xFFFFFF;
				chart.detailInstitute.fade(chart.dc.UI_ALPHA);
			}else{
				chart.detailInstitute.label.textColor = 0x000000;
				chart.detailInstitute.fade(chart.dc.O_ALPHA);
			}
		} // END resetTabs()
		
		public function addCloseButton():void{
			closeButton = new CloseButton(chart.dc);
			closeButton.x = pWidth - closeButton.width - 3;
			closeButton.y = 4;
			addChild(closeButton);
		} // END addCloseButton()
		
		public function removeCloseButton():void{
			removeChild(closeButton);
		} // END removeCloseButton()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		private function onMouseDown(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(e:MouseEvent):void{
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseOver(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseOut(e:MouseEvent):void{
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(e:MouseEvent):void{
			e.updateAfterEvent();
		}
	} // END DetailContainer()
} // END package
