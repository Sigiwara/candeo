//////////////////////////////////////////////////////////////////////////
//  Header
//
//  Created by  on 2008-05-14.
//  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package gui {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.filters.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.geom.Matrix;
	import tools.*;
	import map.*;
	import barchart.*;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-14
	 */
	public class Header extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var bg						 			:Sprite;
		public var dc						 			:Object;
		public var logo								:Sprite;
		public var zoomPaths					:Array;
		public var filterPaths				:Array;
		
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const HEADER_HEIGHT		:int 	= 35;
		public const MARGIN_RIGHT			:int	= 20;
		public const PATH_GAP					:int	= 40;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Header(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc								= _dc;
			bg								= new Sprite();
			logo							= new Sprite();
			zoomPaths					= new Array();
			filterPaths				= new Array();
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
		
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			drawHeader();
			addZoom([]);
		} // END Header()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function drawHeader():void{
			drawBackground();
			drawFilter();
			drawLogo();
		} // END drawHeader()
		
		public function drawBackground():void{
			var matrix = new Matrix();
			matrix.createGradientBox(dc.stage.stageWidth, HEADER_HEIGHT, 0, 0, 0);
			bg.graphics.clear();
			bg.graphics.beginGradientFill(GradientType.LINEAR, [dc.BACKGROUND,dc.BACKGROUND], [1,.75], [0,255], matrix);
			//bg.graphics.beginFill(dc.BACKGROUND, 1);
			bg.graphics.drawRect(0, 0, dc.stage.stageWidth, HEADER_HEIGHT);
			bg.graphics.endFill();
			bg.graphics.lineStyle(1, 0xFFFFFF, .25);
			bg.graphics.moveTo(0, HEADER_HEIGHT-1);
			bg.graphics.lineTo(dc.stage.stageWidth, HEADER_HEIGHT-1);
			addChild(bg);
		} // END drawBackground()
		
		public function drawFilter():void{
			var shadow:BitmapFilter = new DropShadowFilter(5,90,0x000000,1,20,20,.75,BitmapFilterQuality.HIGH,false,false);
			filters = [shadow];
		} // END drawFilter()
		
		public function drawLogo():void{
			var titel = new TextField();
			configureText(titel, .25);
			setText(titel, "CANDEO 0.1");
			logo.addChild(titel);
			logo.x = dc.stage.stageWidth-100;
			logo.y = 10;
			addChild(logo);
		} // END drawLogo()
		
		public function addZoom(_array:Array):void{
			if(zoomPaths.length > 0){
				for each (var path:Sprite in zoomPaths){
					removeChild(path);
				};
				zoomPaths = new Array();
			};
			addRoot(_array);
			var alphaStep:Number = .75 / _array.length;
			for (var i:int = 1; i<=_array.length; i++){
				var tText:String = _array[i-1];
				var arrow:Boolean;
				if(i<_array.length){
					arrow = true;
				}else{
					arrow = false;
				}
				var tPath:Sprite = drawPath(tText, "zoom", .25 + i*alphaStep, arrow);
				zoomPaths.push(tPath);
				addChild(tPath);
			};
			arrangePath();
		} // END addZoom()
		
		public function addRoot(_array:Array):Array{
			_array.unshift("Uni Bern");
			return _array
		} // END addRoot()
		
		public function addFilter(_array:Array, _type:String):void{
			removeFilter();
			var alphaStep:Number = .75 / _array.length;
			for (var i:int = 1; i<=_array.length; i++){
				var tText:String = _array[i-1].pTitle;
				if(_type == "row"){
					tText += " " + _array[i-1].blockHeader.pTitle;
				};
				var arrow:Boolean;
				if(i<_array.length){
					arrow = true;
				}else{
					arrow = false;
				}
				var tAlpha:Number = .25 + i*alphaStep;
				var tPath = drawPath(tText, "filter", tAlpha, arrow);
				filterPaths.push(tPath);
				addChild(tPath);
			};
			arrangePath();
		} // END addFilter()
		
		public function removeZoom():void{
			if(zoomPaths.length > 0){
				for each (var path:Sprite in zoomPaths){
					removeChild(path);
				};
				zoomPaths = new Array();
			};
			arrangePath();
			addZoom([]);
		} // END removeZoom()
		
		public function removeFilter():void{
			if(filterPaths.length > 0){
				for each (var path:Sprite in filterPaths){
					removeChild(path);
				};
				filterPaths = new Array();
			};
			arrangePath();
		} // END removeFilter()
		
		public function drawPath(_text:String, _type:String, _alpha:Number, _arrow:Boolean):Sprite{
			var path			= new Sprite();
			var pathText	= new TextField();
			configureText(pathText, _alpha);
			setText(pathText, _text);
			if(_arrow){
				var arrow			= new Arrow();
				arrow.alpha		= _alpha;
				arrow.x				= pathText.x + pathText.width + MARGIN_RIGHT/2;
				arrow.y				= pathText.y + pathText.height/2 - arrow.height/2;
				path.addChild(arrow);
			};
			path.addChild(pathText);
			return path;
		} // END drawPath()
		
		public function arrangePath():void{
			var tOffset:Number = 10;
			for each (var zPath:Sprite in zoomPaths){
				zPath.x = tOffset;
				zPath.y = 10;
				tOffset += zPath.width + MARGIN_RIGHT/2;
			};
			tOffset += PATH_GAP;
			for each (var fPath:Sprite in filterPaths){
				fPath.x = tOffset;
				fPath.y = 10;
				tOffset += fPath.width + MARGIN_RIGHT/2;
			};
		} // END arrangePath()
		
		private function configureText(_tf:TextField, _alpha:Number):void{
			_tf.autoSize		= TextFieldAutoSize.LEFT;
			_tf.background	= false;
			_tf.border			= false;
			_tf.selectable	= false;
			_tf.defaultTextFormat = styleText("DIN-Regular",16);
			_tf.embedFonts	= true;
			_tf.antiAliasType = AntiAliasType.ADVANCED;
			_tf.alpha = _alpha;
		} // END configureText()
		
		public function setText(_tf:TextField, _text:String):void{
			_tf.text = _text;
		} // END setText()
		
		public function styleText(_font:String, _size:Number):TextFormat{
			var tFormat:TextFormat = new TextFormat();
			tFormat.font				= _font;
			tFormat.color			= 0xFFFFFF;
			tFormat.size				= _size;
			tFormat.underline	= false;
			return tFormat;
		} // END styleText()
		
	} // END Header
} // END package
