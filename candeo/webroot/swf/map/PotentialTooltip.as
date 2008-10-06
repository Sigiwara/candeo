//////////////////////////////////////////////////////////////////////////
//  PotentialTooltip
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
	 *	PotentialTooltip
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-13
	 */
	public class PotentialTooltip extends Sprite {
		
		//--------------------------------------
		//  instituteVariables
		//--------------------------------------
		public var dc									:Object;
		public var bg									:Sprite;
		public var pLink							:Sprite;
		public var dangerName					:TextField;
		public var dangerVariable			:TextField;
		public var buildingStyle			:Array;
		
		public var dangerIcon					:Sprite;
		public var atomicIcon					:AtomicIcon;
		public var bioIcon						:BioIcon;
		public var chemieIcon					:ChemieIcon;
		public var wasteIcon					:WasteIcon;
		
		public var hoehe							:Number;
		public var weite							:Number;
		public var pTarget						:Object;
		public var pTargetBound				:Rectangle;
		public var targetPoint				:Point;
		
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
		public function PotentialTooltip(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc								= _dc;
			bg								= new Sprite();
			pLink							= new Sprite();
			dangerName 				= new TextField();
			dangerVariable		= new TextField();
			buildingStyle			= new Array("DIN-Bold",12);
			dangerIcon				= new Sprite();
			addChild(dangerIcon);
			
			alpha 						 = 0;
			
		}// END Tooltip()
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function addPotentialTooltip(_target:Object):void{
			pTarget = _target.building;
			displayTooltip(_target);
			positionTooltip();
			TweenLite.to(this, 1, {alpha:1, ease:Strong.easeOut}); 
		} // END addTooltip()
		
		public function removePotentialTooltip():void{
			TweenLite.to(this, 1, {alpha:0, ease:Strong.easeOut, onComplete:onFadeComplete}); 
		} // END removeTooltip()
		
		public function displayTooltip(_target:Object):void{
			setNames(_target);
			setVariables(_target);
			drawBackground();
			configureContent(_target);
			setNames(_target);
			setVariables(_target);
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
			hoehe = dangerName.textHeight+PADDING+CORRECTION_Y;
			weite = dangerName.textWidth + PADDING*3+CORRECTION_X*2+OFFSET_X+dangerIcon.width+dangerVariable.textWidth;
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
		
		public function addDangerIcon(_dangerCase:String):void {
			if(dangerIcon !=null){
				removeChild(dangerIcon);
			}
			dangerIcon = new Sprite();
			addChild(dangerIcon);
			dangerIcon.x = bg.x+PADDING;
			dangerIcon.y = bg.y+PADDING;
			switch(_dangerCase){
				case "atomic":
					atomicIcon = new AtomicIcon();
					dangerIcon.addChild(atomicIcon);
					break;
				case "biological":
					bioIcon = new BioIcon();
					dangerIcon.addChild(bioIcon);
					break;
				case "chemical":
					chemieIcon = new ChemieIcon();
					dangerIcon.addChild(chemieIcon);
					break;
				case "waste":
					wasteIcon = new WasteIcon();
					dangerIcon.addChild(wasteIcon);
					break;
			}
			dangerIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -255, -255, -255);
		} // END addDangerIcon()
		
		public function setNames(_target:Object):void{
			dangerName.text = _target.name;
		} // END setNames()
		
		public function setVariables(_target:Object):void{
			dangerVariable.text = _target.potential;
		} // END setVariables()
		
		public function configureContent(_target:Object):void{
			switch(_target.sourcetype.toString()){
				case "Atomic":
				addDangerIcon("atomic");
				break;
				case "Biological":
				addDangerIcon("biological");
				break;
				case "Chemical":
				addDangerIcon("chemical");
				break;
				case "Waste":
				addDangerIcon("waste");
				break;
			};
			configureTextField(dangerName, buildingStyle);
			configureTextField(dangerVariable, buildingStyle);
		} // END configureContent()
		
		public function layoutContent():void{
			dangerName.x				= bg.x+PADDING*3+dangerIcon.width;
			dangerName.y				= bg.y+PADDING;
			dangerVariable.x		= bg.x+bg.width-PADDING*3-CORRECTION_X-dangerVariable.textWidth;
			dangerVariable.y		= dangerName.y;
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
