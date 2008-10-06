//////////////////////////////////////////////////////////////////////////
//  BlockHeader
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
	
	/**
	 *	Block Header für die Vergleichstabelle
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-02
	 */
	public class BlockHeader extends uiElement {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var rows				:Array;
		public var pIndex			:Number;
		public var pWidth			:Number;
		public var pHeight		:Number;
		public var pLabel			:String;
		public var pTitle			:String;
		public var toggled		:Boolean;
		public var potentials	:Array;
		public var rowHeaders	:Array;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function BlockHeader(_index:Number, _rows:Array, _width:Number, _height:Number, _label:String, _title:String, _chart:MovieClip){
			//  DEFINITIONS
			//--------------------------------------
			_btn				= new Sprite();
			potentials	= new Array();
			rowHeaders	= new Array();
			rows				= _rows;
			pIndex			= _index;
			pWidth			= _width;
			pHeight			= _height;
			pLabel			= _label;
			pTitle			= _title;
			toggled			= false;
			
			//  ATTACH
			//--------------------------------------
			addChild(_btn);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
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
		} // END drawUI()
		
		public function setFold():void{
			if(chart.view != "bf"){
				chart.foldBlocks();
				chart.view = "bf";
			}else{
				chart.expandPotentials();
				chart.view = "ex";
			};
		} // END setFold()
		
		public function toggleBlock():void{
			if(toggled){
				// Diese Block war ausgewählt
				this.toggled = false;
				chart.toggledBlock = null;
				super.dc.ui.header.addFilter([], "block");
				super.dc.dangerLayer.resetDangers();
			}else{
				// Dieser Block wird ausgewählt
				this.toggled = true;
				chart.toggledBlock = this;
				chart.fadeIn({what:"row", who:rows});
				removeToogledRows();
				super.dc.ui.header.addFilter([this], "block");
				super.dc.dangerLayer.fadeBlockDangers(pIndex);
			}
		} // END toggleBlock()
		
		public function removeToogledRows():void{
			if(chart.toggledRows.length > 0){
				for each (var rh:RowHeader in chart.toggledRows){
					rh.toggled = false;
					rh.onMouseOut(new MouseEvent("MouseOut"));
				};
				chart.toggledRows = new Array();
				chart.fadeOut();
			};
		} // END removeToogledRows()
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		override public function onMouseOver(e:MouseEvent):void
		{
			var rh:RowHeader;
			if(!this.toggled){
				if(chart.toggledBlock != null){
					// Bereits ein anderer Block ausgewählt = Potentiale nicht aktivieren
					super.onMouseOver(e);
				}else{
					// Nichts ausgewählt = normales Verhalten
					for each (rh in chart.rowHeaders){
						if(rh.block == pIndex){
							rh.extMouseOver(e);
						};
					};
					super.onMouseOver(e);
					chart.fadeIn({what:"rows", who:rows});
				};
			}else{
				// Dieses Areal ausgewählt
				for each (rh in chart.rowHeaders){
					if(rh.block == pIndex){
						rh.extMouseOver(e);
					};
				};
				super.onMouseOver(e);
				chart.fadeIn({what:"rows", who:rows});
			};
		} // END mouseOver()
		
		override public function onMouseOut(e:MouseEvent):void
		{
			extMouseOut(e);
		} // END mouseOut()
		
		public function extMouseOut(e:MouseEvent):void{
			var rh:RowHeader;
			if(!this.toggled){
				if(chart.toggledBlock != null){
					// Bereits ein anderer Block ausgewählt = Potentiale nicht aktivieren
					super.onMouseOut(e);
				}else{
					// Kein Block ausgewählt
					chart.fadeOut();
					super.onMouseOut(e);
					for each (rh in rowHeaders){
						rh.onMouseOut(e);
					};
				};
			};
		} // END extMouseOut()
		
		override public function onMouseUp(e:MouseEvent):void
		{
			super.onMouseUp(e);
			if(chart.view != "bf"){
				// Expanded = Blocks werden gefolded
				chart.foldBlocks();
				chart.view = "bf";
				toggleBlock();
			}else{
				// Gefolded = Blocks werden expanded
				if(toggled){
					// Dieser Block ist gefolded = Blocks expandieren / Block detoggle
					toggleBlock()
					// CHANGED: Potentiale werden beim deaktivieren nicht gefolded
					//chart.foldPotentials();
					//chart.view = "tf";
					chart.expandPotentials();
					chart.view = "ex";
				}else{
					// Ein anderer Block ist gefolded = Blocks nicht expandieren / Block detoggle
					toggleBlock()
				};
			};
		} // END onMouseUp()
		
		override public function onMouseDown(e:MouseEvent):void{
			super.onMouseDown(e);
			if(!toggled){
				if(chart.toggledBlock != null){
					// Ein anderer Block war ausgewählt = deaktivieren
					var tBlock:BlockHeader = chart.toggledBlock;
					chart.toggledBlock.toggled = false;
					chart.toggledBlock = null;
					tBlock.onMouseOut(e);
					this.onMouseOver(e);
				};
			};
		} // END onMouseDown()
	} // END BlockHeader
} // END package