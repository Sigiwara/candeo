//////////////////////////////////////////////////////////////////////////
//  Tooltip
//
//  Created by BW on 2008-05-13.
//  Copyright (c) 2008 IAD / ZHDK. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package map {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.geom.*;
	import tools.*;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-13
	 */
	public class Tooltip extends Sprite {
		
		//--------------------------------------
		//  instituteVariables
		//--------------------------------------
		public var dc										:Object;
		public var bg										:Sprite;
		public var pLink								:Sprite;
		public var buildingName					:TextField;
		public var buildingVariable			:TextField;
		public var instituteNames				:TextField;
		public var instituteVariables		:TextField;
		public var buildingIcon					:BuildingIcon;
		public var buildingStyle				:Array;
		public var instituteStyle				:Array;
		public var hoehe								:Number;
		public var weite								:Number;
		public var pTarget							:Object;
		public var pTargetBound					:Rectangle;
		public var targetPoint					:Point;
		
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const PADDING				:int 	= 5;
		public const CORRECTION_X		:int	= 2;
		public const CORRECTION_Y		:int	= 7;
		public const OFFSET_X				:int	=	20;
		public const OFFSET_Y				:int	=	8;
		public const MIN_WIDTH			:int	= 200;
		public const LINE_OFFSET		:int	= 40;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Tooltip(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc										= _dc;
			bg										= new Sprite();
			pLink									= new Sprite();
			buildingIcon					= new BuildingIcon();
			buildingName 					= new TextField();
			buildingVariable	 		= new TextField();
			instituteNames				= new TextField();
			instituteVariables 		= new TextField();
			buildingStyle					= new Array("DIN-Bold",12);
			instituteStyle				= new Array("DIN-Regular",10);
			alpha 								= 0;
			
		}// END Tooltip()
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function addTooltip(_target, _remote:Boolean):void{
			pTarget = _target;
			displayTooltip(_target);
			positionTooltip();
			//TweenLite.to(this, 1, {alpha:1, ease:Strong.easeOut}); 
			alpha = 1;
		} // END addTooltip()
		
		public function removeTooltip():void{
			//TweenLite.to(this, 1, {alpha:0, ease:Strong.easeOut, onComplete:onFadeComplete}); 
			alpha = 0;
			onFadeComplete();
		} // END removeTooltip()
		
		public function displayTooltip(_target):void{
			setNames(_target);
			setVariables(_target);
			drawBackground();
			configureContent(_target);
			layoutContent();
		} // END displayTooltip()
		
		public function positionTooltip():void{
			pTargetBound	= pTarget.getBounds(dc);
			var xLeft			:Number = pTargetBound.x - pTargetBound.width/2;
			var xRight		:Number = xLeft + this.width + LINE_OFFSET;
			var yTop			:Number = pTargetBound.y + pTargetBound.height / 2 - this.height - LINE_OFFSET;
			
			if(xRight > dc.stage.stageWidth){
				// über den rechten rand hinaus
				if(yTop < dc.ui.header.height){
					// über den oberen rand hinaus
					drawLine("bottom_left");
					this.x = pTargetBound.x - this.width - PADDING;
					this.y = pTargetBound.y + pTargetBound.height + PADDING + LINE_OFFSET;
				}else{
					// unter dem oberen rand
					drawLine("top_left");
					this.x = pTargetBound.x - this.width - PADDING;
					this.y = pTargetBound.y - this.height;
				};
			}else{
				// im sichtbaren bereich
				if(yTop < dc.ui.header.height){
					// über den oberen rand hinaus
					drawLine("bottom_right");
					this.x = pTargetBound.x + pTargetBound.width + LINE_OFFSET + PADDING;
					this.y = pTargetBound.y + pTargetBound.height + PADDING + LINE_OFFSET;
				}else{
					// unter dem oberen rand
					drawLine("top_right");
					this.x = pTargetBound.x + pTargetBound.width + LINE_OFFSET + PADDING;
					this.y = pTargetBound.y - this.height;
				};
			};
		} // END positionTooltip()
		
		public function drawBackground():void{
			var matrix = new Matrix();
			hoehe = buildingName.textHeight+instituteNames.textHeight+PADDING+CORRECTION_Y+OFFSET_Y;
			if(buildingName.textWidth > MIN_WIDTH-buildingVariable.textWidth-OFFSET_X-PADDING*3-buildingIcon.width){
				// Buildingname ist grösser
				weite = buildingName.textWidth + PADDING*3+CORRECTION_X*2+OFFSET_X+buildingIcon.width+buildingVariable.textWidth;
			} else if(instituteNames.textWidth > MIN_WIDTH-instituteVariables.textWidth-OFFSET_X-PADDING*3-pLink.width){
				// institutnamen sind grösser
				weite = instituteNames.textWidth + PADDING*3+CORRECTION_X*2+OFFSET_X+pLink.width+instituteVariables.textWidth;
			} else {
				
				weite = instituteVariables.textWidth+PADDING*3+CORRECTION_X+OFFSET_X;
			}
			if(weite<MIN_WIDTH){
				weite = MIN_WIDTH;
			}
			matrix.createGradientBox(weite, hoehe, 0, 0, 0);
			bg.graphics.clear();
			bg.graphics.lineStyle(1, 0xFFFFFF, .75);
			bg.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF,0xFFFFFF], [.75,.5], [0,255], matrix);
			bg.graphics.drawRect(0, 0, weite, hoehe);
			bg.graphics.endFill();
			addChildAt(bg, 0);
		} // END drawBackground()
		
		public function drawLine(_pos:String):void{
			switch(_pos){
				case "bottom_left":
				bg.graphics.moveTo(bg.width + 4, -4);
				bg.graphics.lineTo(bg.width + 4 + LINE_OFFSET, -4 -LINE_OFFSET);
				break;
				case "top_left":
				bg.graphics.moveTo(bg.width + 4, bg.height + 4);
				bg.graphics.lineTo(bg.width + 4 + LINE_OFFSET, bg.height + 4 + LINE_OFFSET);
				break;
				case "bottom_right":
				bg.graphics.moveTo(-4, -4);
				bg.graphics.lineTo(-4 - LINE_OFFSET, -4 - LINE_OFFSET);
				break;
				case "top_right":
				bg.graphics.moveTo(-4, bg.height + 4);
				bg.graphics.lineTo(-4 - LINE_OFFSET, bg.height + 4 + LINE_OFFSET);
				break;
			};
		} // END drawLine()
		
		public function drawLink(_target):void{
			var offset:Number = 0;
			var correction:Number = 0;
			pLink.x = bg.x;
			pLink.y = bg.y;
			pLink.graphics.clear();
			pLink.graphics.lineStyle(1, 0x000000, .75);
			for each( var i in _target.institutesData){
				pLink.graphics.moveTo(12,22+offset);
				pLink.graphics.lineTo(12,35+offset);
				pLink.graphics.lineTo(16,35+offset);
				offset+=13;
			}
			addChildAt(pLink, 1);
		} // END drawLink()
		
		public function addBuildingIcon():void {
			buildingIcon.x = bg.x+PADDING;
			buildingIcon.y = bg.y+PADDING;
			addChild(buildingIcon);
		} // END addBuildingIcon()
		
		public function setNames(_target):void{
			buildingName.text				= _target.daten.name;
			instituteNames.text			= "";
			for each( var i:Object in _target.institutesData){
				instituteNames.appendText(i.name+"\n");
			};
		} // END setNames()
		
		public function setVariables(_target):void{
			buildingVariable.text		= _target.buildingPotential;
			instituteVariables.text	= "";
			for each( var i:Object in _target.institutesDataComplete){
				var tPotential:Number = dc.dangerLayer.orderInstituteBuildingPotential(i, pTarget);
				instituteVariables.appendText(tPotential+"\n");
			};
		} // END setVariables()
		
		public function configureContent(_target):void{
			addBuildingIcon();
			configureTextField(buildingName, buildingStyle);
			drawLink(_target);
			configureTextField(instituteNames, instituteStyle);
			configureTextField(buildingVariable, buildingStyle);
			configureTextField(instituteVariables, instituteStyle);
		} // END configureContent()
		
		public function layoutContent():void{
			buildingName.x				= bg.x+PADDING*2+buildingIcon.width;
			buildingName.y				= bg.y+PADDING;
			instituteNames.x			= buildingName.x;
			instituteNames.y			= buildingName.y+buildingName.textHeight+4;
			buildingVariable.x		= bg.x+bg.width-PADDING*2-CORRECTION_X-buildingVariable.textWidth;
			buildingVariable.y		= buildingName.y;
			instituteVariables.x	= bg.x+bg.width-PADDING*2-CORRECTION_X-instituteVariables.textWidth;
			instituteVariables.y	= instituteNames.y;
		} // END layoutContent()
		
		public function configureTextField(_tf:TextField, _style:Array):void{
			_tf.autoSize					= TextFieldAutoSize.RIGHT;
			_tf.background				= false;
			_tf.border						= false;
			_tf.selectable				= false;
			_tf.defaultTextFormat	= setStyle(_style);
			_tf.embedFonts				= true;
			_tf.antiAliasType			= AntiAliasType.ADVANCED;
			addChild(_tf);
		} // END configureTextField()
		
		public function setStyle(_style:Array):TextFormat{
			var format:TextFormat	= new TextFormat();
			format.font						= _style[0];
			format.color					= 0x000000;
			format.size						= _style[1];
			format.underline			= false;
			format.leading				= 1.3;
			return format;
		} // END setStyle()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		public function onFadeComplete():void{
			hoehe = 0;
			weite = 0;

		} // END onFadeComplete()
		
	}
}
