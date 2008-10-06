//////////////////////////////////////////////////////////////////////////
//  AreaHeader
//
//  Created by Benjamin Wiederkehr on 2008-05-08.
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
	 *	Column Header für die Vergleichstabelle
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-02
	 */
	public class AreaHeader extends uiElement {
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		public var pIndex			:Number;
		public var pWidth			:Number;
		public var pHeight		:Number;
		public var pLabel			:String;
		public var institutes	:Array;
		public var toggled		:Boolean;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function AreaHeader(_number:Number, _width:Number, _height:Number, _label:String, _chart:MovieClip){
			//  DEFINITIONS
			//--------------------------------------
			_btn				= new Sprite();
			institutes	= new Array();
			pIndex			= _number;
			pWidth			= _width;
			pHeight			= _height;
			pLabel			= _label;
			toggled			= false;
			
			//  ATTACH
			//--------------------------------------
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addChild(_btn);
			
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

		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		override public function onMouseOver(e:MouseEvent):void{
			var institute:Object;
			if(!toggled){
				if(chart.toggledArea != null){
					// Bereits ein anderes Areal ausgewählt = Potentiale nicht aktivieren
					super.onMouseOver(e);
				}else{
					// Nichts ausgewählt = normales Verhalten
					super.onMouseOver(e);
					for each (institute in institutes){
						institute.ch.extMouseOver(e);
					};
					chart.fadeIn({what:"area", who:[pIndex]})
				};
			}else{
				// Dieses Areal ausgewählt
				super.onMouseOver(e);
				for each (institute in institutes){
					institute.ch.extMouseOver(e);
				};
				chart.fadeIn({what:"area", who:[pIndex]})
			};
		} // END mouseOver()
		
		override public function onMouseOut(e:MouseEvent):void{
			if(!toggled){
				if(chart.toggledArea != null){
					// Bereits ein anderes Areal ausgewählt = Potentiale nicht aktivieren
					super.onMouseOut(e);
				}else{
					// Nichts ausgewählt = normales Verhalten
					super.onMouseOut(e);
					for each (var institute:Object in institutes){
						institute.ch.extMouseOut(e);
					};
					chart.fadeOut();
				};
			}else{
				// Dieses Areal ausgewählt
			};
		} // END mouseOut()
		
		override public function onMouseUp(e:MouseEvent):void{
			super.onMouseUp(e);
			if(chart.detailContainer != null){
				chart.detailContainer.hide();
			}
			if(!toggled){
				// Diese Areal wird ausgewählt
				this.toggled = true;
				chart.toggledArea = this;
				chart.fadeIn({what:"area", who:[pIndex]});
				super.dc.ui.header.addZoom([pLabel]);
				super.dc.map_container.zoomMap(4, "area", null, pIndex);
			}else{
				// Dieses Areal war ausgewählt
				this.toggled = false;
				chart.toggledArea = null;
				super.dc.ui.header.removeZoom();
				super.dc.map_container.zoomMap(0, "overview");
			}
		} // END onMouseUp()
		
		override public function onMouseDown(e:MouseEvent):void{
			super.onMouseDown(e);
			if(!toggled){
				if(chart.toggledArea != null){
					// Ein anderes Areal war ausgewählt = deaktivieren
					var tArea:AreaHeader = chart.toggledArea;
					chart.toggledArea.toggled = false;
					chart.toggledArea = null;
					tArea.onMouseOut(e);
					this.onMouseOver(e);
				}
			}
		} // END onMouseDown()
	} // END AreaHeader
} // END package