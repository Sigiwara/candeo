//////////////////////////////////////////////////////////////////////////
//  ColumnHeader
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
	import flash.text.*;
	import map.*;
	
	/**
	 *	Column Header für die Vergleichstabelle
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-02
	 */
	public class ColumnHeader extends uiElement {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var daten				:Object;
		public var _tab					:Sprite;
		public var institute		:Object;
		public var buildingsMC	:Array;
		public var column				:Number;
		public var area					:Number;
		public var areaHeader		:AreaHeader;
		public var pWidth				:Number;
		public var pHeight			:Number;
		public var pLabel				:String;
		public var expanded			:Boolean;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function ColumnHeader(_number:Number, _width:Number, _height:Number, _chart:MovieClip, _db){
			//  DEFINITIONS
			//--------------------------------------
			daten				= new Object();
			daten.ch		= this;
			daten.db		= _db;
			buildingsMC	= new Array();
			area				= daten.db.area-1;
			_btn				= new Sprite();
			_tab				= new Sprite();
			column			= _number;
			pWidth			= _width;
			pHeight			= _height;
			pLabel			= daten.db.shortcut;
			expanded		= false;
			//  LISTENER
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addChild(_btn);
			addChild(_tab);
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
		public function drawTab():void{
			_tab.graphics.clear();
			_tab.graphics.lineStyle(1, 0xffffff, .5)
			_tab.graphics.drawRect(0, -2, pWidth, pHeight+2);
			_tab.graphics.lineStyle(1, chart.dc.BACKGROUND, 1);
			_tab.graphics.moveTo(1, -2);
			_tab.graphics.lineTo(pWidth, -2);
			fade(0);
		} // END drawTab()
		public function openTab():void{
			chart.setChildIndex(chart.detailInstitute, chart.numChildren-1);
			drawTab();
			super.label.textColor = 0xFFFFFF;
			expanded = true;
		} // END openTab()
		public function closeTab():void{
			_tab.graphics.clear();
			super.onMouseOver(new MouseEvent("MouseOver"));
			expanded = false;
		} // END closeTab()
		public function registerBuilding(_building):void{
			buildingsMC.push(_building);
		} // END registerBuilding()
		
		public function callBuildings(e:MouseEvent):void{
			//for each (var building:Building in buildingsMC){
				var building:Building = buildingsMC[0];
				switch(e.type){
					case "mouseOver":
					building.extMouseOver(e, true);
					break;
					case "mouseOut":
					building.extMouseOut(e);
					break;
					case "mouseUp":
					if(expanded){
						// Dieses Institut ist in der Detailansicht und wird geschlossen
						var tE:KeyboardEvent = new KeyboardEvent("KEY_UP");
						tE.keyCode = 32;
						super.dc.map_container.keyUpHandler(tE);
					}else{
						// Dieses Institut wird in der Detailansicht geöffnet
						if(chart.detailContainer != null){
							// Detailansicht ist bereits offen
							building.detailInstitute = institute;
							super.dc.map_container.zoomMap(0, "switch", building);
						}else{
							// Detailansicht wird erst geöffnet
							building.detailInstitute = institute;
							building.extMouseUp(e);
						};
					}
					break;
					default:
					break;
				}
			//}
		} // END callBuildings()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		override public function onMouseOver(e:MouseEvent):void{
			extMouseOver(e)
			callBuildings(e);
		} // END onMouseOver()
		
		public function extMouseOver(e:MouseEvent):void{
			if(expanded){return;}
			super.onMouseOver(e);
			if(chart.toggledArea == null){
				chart.fadeIn({what:"columns", who:[column]})
			}
		} // END extMouseOver()
		
		override public function onMouseOut(e:MouseEvent):void{
			extMouseOut(e);
			callBuildings(e);
		} // END onMouseOut()
		
		public function extMouseOut(e:MouseEvent):void{
			if(expanded){return;}
			if(chart.toggledArea == null){
				super.onMouseOut(e);
				chart.fadeOut();
			}else{
				if(chart.toggledArea != areaHeader){
					super.onMouseOut(e);
				}
			}
		} // END extMouseOut()
		
		override public function onMouseDown(e:MouseEvent):void{
			if(expanded){return;}
			super.onMouseDown(e);
		} // END onMouseOver()
		
		override public function onMouseUp(e:MouseEvent):void{
			callBuildings(e);
			extMouseUp(e);
		} // END onMouseUp()
		public function extMouseUp(e:MouseEvent):void{
			if(expanded){
				// Diese Institut ist in der Detailansicht und wird geschlossen
				chart.detailContainer.hide();
				super.dc.ui.header.removeZoom();
			}else{
				// Dieses Institut wird in der Detailansicht geöffnet
				super.onMouseUp(e);
				super.dc.ui.header.addZoom([areaHeader.pLabel, daten.db.name]);
				if(chart.detailContainer != null){
					// DetailContainer ist bereits offen
					chart.detailContainer.swapData(daten);
				}else{
					// DetailContainer wird erst geöffnet
					chart.drawDetailContainer(daten);
				};
				if(chart.toggledArea != areaHeader && chart.toggledArea != null){
					// Ein anderes Areal war ausgewählt = deaktivieren
					var tArea:AreaHeader = chart.toggledArea;
					chart.toggledArea.toggled = false;
					chart.toggledArea = null;
					tArea.onMouseOut(e);
				};
			}
		} // END onMouseUp()
	} // END ColumnHeader
} // END package