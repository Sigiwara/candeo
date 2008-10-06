//////////////////////////////////////////////////////////////////////////
//  Overlay
//
//  Created by Benjamin Wiederkehr on 2008-05-26.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package gui {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import gs.TweenLite;
	import fl.transitions.easing.*;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-26
	 */
	public class Overlay extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc					:Object;
		public var overlay		:Sprite;
		public var label			:TextField;
		public var counter		:Number;
		public var graphs			:Array;
		public var bGraph			:Sprite;
		public var iGraph			:Sprite;
		public var rGraph			:Sprite;
		
		public const V_OFFSET:int = 15;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Overlay(_dc:Object){
			//  DEFINITIONS
			//--------------------------------------
			dc				= _dc;
			counter		= 0;
			graphs		= new Array();
			overlay		= new Sprite();
			bGraph		= new Sprite();
			iGraph		= new Sprite();
			rGraph		= new Sprite();
			graphs.push(bGraph, iGraph, rGraph);
			//  ADD
			//--------------------------------------
			overlay.addChild(bGraph);
			overlay.addChild(iGraph);
			overlay.addChild(rGraph);
			//  CALLS
			//--------------------------------------
			draw();
			configureLabel();
		}
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public function draw():void{
			overlay.graphics.clear();
			overlay.graphics.beginFill(0x000000,1);
			overlay.graphics.drawRect(0,0,dc.stage.stageWidth,dc.stage.stageHeight);
			overlay.graphics.endFill();
			overlay.alpha = .8;
			addChild(overlay);
		} // END draw()
		public function hide():void{
			overlay.removeChild(label);
			TweenLite.to(this, 2, {delay: 1, alpha:0, ease:Strong.easeOut, onComplete:removeOL});
		} // END hide()
		public function removeOL():void{
			dc.ui.removeChild(this);
		} // END removeOL()
		public function addGraph():void{
			var tGraph = drawGraph(graphs[counter]);
			counter++;
			tGraph.x = overlay.width/2 - 15;
			tGraph.y = overlay.height/2 + V_OFFSET*counter;
			TweenLite.to(tGraph, 1, {width:30, ease:Strong.easeOut});
			if(counter == graphs.length){
				TweenLite.to(tGraph, 1, {delay: 1, width:30, ease:Strong.easeOut, onStart:dc.displayApp, onComplete:hide});
			};
		} // END addGraph()
		public function drawGraph(_graph:Sprite):Sprite{
			_graph.graphics.clear();
			_graph.graphics.beginFill(0xFFFFFF,1);
			_graph.graphics.drawRect(0,0,30,10);
			_graph.graphics.endFill();
			_graph.alpha = .8;
			_graph.width = 0;
			addChild(_graph);
			return _graph;
		} // END draw()
		public function configureLabel():void{
			label = new TextField();
			label.autoSize		= TextFieldAutoSize.LEFT;
			label.background	= false;
			label.border			= false;
			label.selectable	= false;
			label.defaultTextFormat = styleLabel();
			label.text				= "Wir bitten um ein wenig Geduld um die Daten vollständig zu laden..."
			label.x						= overlay.width/2 - label.width/2;
			label.y						= overlay.height/2 - label.height/2;
			overlay.addChild(label);
		} // END configureLabel()
		public function styleLabel():TextFormat{
			var format:TextFormat = new TextFormat();
			format.font				= "DIN-Regular";
			format.color			= 0xFFFFFF;
			format.size				= 14;
			format.underline	= false;
			return format;
		} // END styleLabel()
	}
}
