//////////////////////////////////////////////////////////////////////////
//  RowHeader
//
//  Created by Benjamin Wiederkehr on 2008-04-02.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package barchart{
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import tools.*;
	
	/**
	 *	Row Header für die Vergleichstabelle
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-02
	 */
	public class RowHeader extends uiElement {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var row				:Number;
		public var block			:Number;
		public var pWidth			:Number;
		public var pHeight		:Number;
		public var pLabel			:String;
		public var pTitle			:String;
		public var toggled		:Boolean;
		public var potentials	:Array;
		public var blockHeader:BlockHeader;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function RowHeader(_number:Number, _width:Number, _height:Number, _label:String, _title:String, _chart:MovieClip){
			//  DEFINITIONS
			//--------------------------------------
			_btn				= new Sprite();
			potentials	= new Array();
			row					= _number;
			pWidth			= _width;
			pHeight			= _height;
			pLabel			= _label;
			pTitle			= _title;
			toggled			= false;
			
			//  ATTACH
			//--------------------------------------
			addChild(_btn);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//  CALLS
			//--------------------------------------
			super(_chart, _chart.dc);
			super.setLabel(pLabel);
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
		
		public function toggleRow(e:MouseEvent):void{
			if(this.toggled == true){
				// Diese Row ist bereits ausgewählt = muss enttoggled werden
				if(chart.toggledRows.length > 0){
					var tIndex:int = chart.toggledRows.indexOf(this);
					chart.toggledRows.splice(tIndex,1);
				};
				if(chart.toggledRows.length == 0){
					// CHANGED: Potentiale werden beim deaktivieren nicht gefolded
					//chart.foldPotentials();
					//chart.view = "tf";
					chart.expandPotentials();
					chart.view = "ex";
				};
				this.toggled = false;
				super.dc.ui.header.addFilter(chart.toggledRows, "row");
				super.dc.dangerLayer.resetDangers();
			}else{
				// Diese Row wurde ausgewählt = muss getoggled werden
				if(chart.toggledRows.length > 0){
					// Es wurden schon Rows getoggled
					if(chart.toggledRows[0].block != this.block){
						// Die toggledRows gehören zu einem andern Block = werden entfernt
						removeToogledRows();
					};
					if(chart.dc.map_container.viewMode != "mapMode"){
						// Die Detailanscht ist geöffnet = keine mehrfach toggles möglich
						removeToogledRows();
					};
				}else{
					chart.expandPotentials();
					chart.view = "ex";
				};
				chart.toggledRows.push(this);
				this.toggled = true;
				super.dc.ui.header.addFilter(chart.toggledRows, "row");
				super.dc.dangerLayer.fadeRowDangers(row);
			};
		} // END toggle()
		
		public function registerBlocks():void{
			for each (var bh:BlockHeader in chart.blockHeaders){
				if(bh.pIndex == this.block){
					bh.rowHeaders.push(this);
					blockHeader = bh;
				};
			};
		} // END registerBlocks()
		
		public function removeToogledRows():void{
			if(chart.toggledRows.length > 0){
				for each (var rh:RowHeader in chart.toggledRows){
					rh.toggled = false;
					rh.onMouseOut(new MouseEvent("MouseOut"));
				};
				chart.toggledRows = new Array();
				chart.fadeOut();
				chart.fadeIn({what:"rows", who:[row]});
			}
		};
		
		public function removeToggledBlocks(e:MouseEvent):void{
			if(chart.toggledBlock != null){
				chart.toggledBlock.toggled = false;
				var tBlock:BlockHeader = chart.toggledBlock;
				chart.toggledBlock = null;
				tBlock.extMouseOut(e);
				chart.fadeIn({what:"rows", who:[row]});
			};
		} // END removeToggledBlocks()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		override public function onMouseOver(e:MouseEvent):void{
			extMouseOver(e);
		} // END mouseOver()
		
		public function extMouseOver(e:MouseEvent):void{
			super.onMouseOver(e);
			if(chart.toggledBlock == null){
				chart.fadeIn({what:"rows", who:[row]});
			}
		} // END extMouseOver()
		
		override public function onMouseOut(e:MouseEvent):void{
			if(!this.toggled){
				// Diese Row ist nicht ausgewählt
				if(chart.toggledBlock == null){
					// Es ist kein Block ausgewählt
					super.onMouseOut(e);
				}else{
					// Ein Block ist ausgewählt
					if(chart.toggledBlock != blockHeader){
						// Diese Row gehört nicht zum ausgewählten Block
						super.onMouseOut(e);
					};
				};
			};
			chart.fadeOut();
		} // END mouseOut()
		
		override public function onMouseUp(e:MouseEvent):void{
			super.onMouseUp(e);
			removeToggledBlocks(e);
			toggleRow(e);
		} // END onMouseUp()
	} // END RowHeader
} // END package