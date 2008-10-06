//////////////////////////////////////////////////////////////////////////
//  Records
//
//  Created by  on 2008-05-20.
//  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
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
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-20
	 */
	public class Records extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc										:Object;
		public var building							:Object;
		public var container						:Sprite;
		public var link									:Sprite;
		public var atomicArray					:Array;
		public var biologicalArray			:Array;
		public var chemicalArray				:Array;
		public var wasteArray						:Array;
		public var atomicPot						:Number;
		public var biologicalPot				:Number;
		public var chemicalPot					:Number;
		public var wastePot							:Number;
		public var atomicTitle					:TextField;
		public var atomicSumDanger			:TextField;
		public var atomicSubtitels			:TextField;
		public var atomicDangers				:TextField;
		public var biologicalTitle			:TextField;
		public var biologicalSumDanger	:TextField;
		public var biologicalSubtitels	:TextField;
		public var biologicalDangers		:TextField;
		public var chemicalTitle				:TextField;
		public var chemicalSumDanger		:TextField;
		public var chemicalSubtitels		:TextField;
		public var chemicalDangers			:TextField;
		public var wasteTitle						:TextField;
		public var wasteSumDanger				:TextField;
		public var wasteSubtitels				:TextField;
		public var wasteDangers					:TextField;
		public var atomicIcon						:AtomicIcon;
		public var chemieIcon						:ChemieIcon;
		public var bioIcon							:BioIcon;
		public var wasteIcon						:WasteIcon;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Records(_dc:Object, _building:Object){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc 							  	= _dc;
			building 				  	= _building;
			container				  	= new MovieClip();
			link						  	= new Sprite();
			
			atomicArray					= new Array();
			biologicalArray			= new Array();
			chemicalArray				= new Array();
			wasteArray					= new Array();
			
			atomicPot						= 0;
			biologicalPot				= 0;
			chemicalPot					= 0;
			wastePot						= 0;
			
			atomicTitle			  	= new TextField();
			atomicSumDanger			= new TextField();
			atomicSubtitels	  	= new TextField();
			atomicDangers		  	= new TextField();
			biologicalTitle	  	= new TextField();
			biologicalSumDanger	= new TextField();
			biologicalSubtitels	= new TextField();
			biologicalDangers		= new TextField();
			chemicalTitle				= new TextField();
			chemicalSumDanger		= new TextField();
			chemicalSubtitels		= new TextField();
			chemicalDangers			= new TextField();
			wasteTitle					= new TextField();
			wasteSumDanger			= new TextField();
			wasteSubtitels			= new TextField();
			wasteDangers				= new TextField();
			atomicIcon					= new AtomicIcon();
			chemieIcon					= new ChemieIcon();
			wasteIcon						= new WasteIcon();
			bioIcon							= new BioIcon();
			alpha								= 0;
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			orderRecords();
			drawRecords(building);
		} // END Records()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		
		public function drawRecords(_target):void{
			drawContainer();
			configureAtomicTitle();
			configureAtomicSumDanger(_target);
			configureAtomicSubtitels(_target);
			configureAtomicDangers(_target);
			configureBiologicalTitle();
			configureBiologicalSumDanger(_target);
			configureBiologicalSubtitels(_target);
			configureBiologicalDangers(_target);
			configureChemicalTitle();
			configureChemicalSumDanger(_target);
			configureChemicalSubtitels(_target);
			configureChemicalDangers(_target);
			configureWasteTitle();
			configureWasteSumDanger(_target);
			configureWasteSubtitels(_target);
			configureWasteDangers(_target);
			setNewPosition();
		} // END drawRecords()
		
		public function orderRecords():void{
			for each (var r:XML in building.recordsData){
				var tPot:Number = new Number(0);
				switch(r.sourcetype.toString()){
					case "Atomic":
					if(r.instituteid.toString() == building.detailInstitute.daten.id.toString()){
						atomicArray.push(r);
						tPot = r.potential;
						atomicPot += Number(tPot);
					};
					break;
					case "Biological":
					if(r.instituteid.toString() == building.detailInstitute.daten.id.toString()){
						biologicalArray.push(r);
						tPot = r.potential;
						biologicalPot += Number(tPot);
					};
					break;
					case "Chemical":
					if(r.instituteid.toString() == building.detailInstitute.daten.id.toString()){
						chemicalArray.push(r);
						tPot = r.potential;
						chemicalPot += Number(tPot);
					};
					break;
					case "Waste":
					if(r.instituteid.toString() == building.detailInstitute.daten.id.toString()){
						wasteArray.push(r);
						tPot = r.potential;
						wastePot += Number(tPot);
					};
					break;
				};
			};
		} // END orderRecords()
		
		public function setAtomicSumDanger(_target):void {
			atomicSumDanger.text = atomicPot.toString();
		} // END setAtomicSumDanger()
		private function setAtomicSubtitels(_target):void{
			drawLink(atomicTitle.y,null,atomicArray.length);
			atomicSubtitels.text = "";
			for(var i:Number = 0; i<atomicArray.length; i++){
				atomicSubtitels.appendText(atomicArray[i].name+"\n");
			}
		} // END setAtomicSubtitels()
		private function setAtomicDangers(_target):void{
			atomicDangers.text = "";
			for(var i:Number = 0; i<atomicArray.length; i++){
				atomicDangers.appendText(atomicArray[i].potential+"\n");
			}
		} // END setAtomicDangers()
		
		public function setBiologicalSumDanger(_target):void {
			biologicalSumDanger.text = biologicalPot.toString();
		} // END setBiologicalSumDanger()
		private function setBiologicalSubtitels(_target):void{
			drawLink(biologicalTitle.y,null,biologicalArray.length);
			biologicalSubtitels.text = "";
			for(var i:Number = 0; i<biologicalArray.length; i++){
				biologicalSubtitels.appendText(biologicalArray[i].name+"\n");
			}
		} // END setBiologicalSubtitels()
		private function setBiologicalDangers(_target):void{
			biologicalDangers.text = "";
			for(var i:Number = 0; i<biologicalArray.length; i++){
				biologicalDangers.appendText(biologicalArray[i].potential+"\n");
			}
		} // END setBiologicalDangers()
		
		public function setChemicalSumDanger(_target):void {
			chemicalSumDanger.text = chemicalPot.toString();
		} // END setChemicalSumDanger()
		private function setChemicalSubtitels(_target):void{
			drawLink(chemicalTitle.y,null,chemicalArray.length);
			chemicalSubtitels.text = "";
			for(var i:Number = 0; i<chemicalArray.length; i++){
				chemicalSubtitels.appendText(chemicalArray[i].name+"\n");
			}
		} // END setChemicalSubtitels()
		private function setChemicalDangers(_target):void{
			chemicalDangers.text = "";
			for(var i:Number = 0; i<chemicalArray.length; i++){
				chemicalDangers.appendText(chemicalArray[i].potential+"\n");
			}
		} // END setChemicalDangers()
		
		public function setWasteSumDanger(_target):void {
			wasteSumDanger.text = wastePot.toString();
		} // END setWasteSumDanger()
		private function setWasteSubtitels(_target):void{
			drawLink(wasteTitle.y,null,wasteArray.length);
			wasteSubtitels.text = "";
			for(var i:Number = 0; i<wasteArray.length; i++){
				wasteSubtitels.appendText("Sondermüll Gefahr "+"\n");
			}
		} // END setWasteSubtitels()
		private function setWasteDangers(_target):void{
			wasteDangers.text = "";
			for(var i:Number = 0; i<wasteArray.length; i++){
				wasteDangers.appendText(wasteArray[i].potential+"\n");
			}
		} // END setWasteDangers()
		
		public function setNewPosition():void{
			x	= dc.stage.stageWidth - container.width - 10;
			y	= dc.ui.header.height + 30;
		} // END setNewPosition()
		
		public function drawContainer():void{
			container.graphics.clear();
			container.graphics.beginFill(0x000000,0);
			container.graphics.drawRect(0, 0, 200, 420);
			container.graphics.endFill();
			addChild(container);
		} // END drawContainer()
		
		public function drawLink(_startY:Number = 0, _target = null, _quantity:Number = undefined):void{
			var offset:Number = 0;
			var correction:Number = 0;
			link.x = container.x+7;
			link.y = 0;
			link.graphics.lineStyle(1, 0xFFFFFF, .75);
			/*for(var i:Number = 0; i<_target.institutesData.length; i++){
				link.graphics.moveTo(0,_startY+22+offset);
				link.graphics.lineTo(0,_startY+35+offset);
				link.graphics.lineTo(8,_startY+35+offset);
				offset+=13;
			}*/
			for(var j:Number = 0; j<_quantity; j++){
				link.graphics.moveTo(0,_startY+22+offset);
				link.graphics.lineTo(0,_startY+35+offset);
				link.graphics.lineTo(8,_startY+35+offset);
				offset+=13;
			}
			container.addChild(link);
		} // END drawLink()
		
		public function addAtomicIcon(_y:Number):void {
			atomicIcon.x = 0;
			atomicIcon.y = _y;
			container.addChild(atomicIcon);
		} // END addAtomicIcon()
		public function addBioIcon(_y:Number):void {
			bioIcon.x = 0;
			bioIcon.y = _y;
			container.addChild(bioIcon);
		} // END addBioIcon()
		public function addChemieIcon(_y:Number):void {
			chemieIcon.x = 0;
			chemieIcon.y = _y;
			container.addChild(chemieIcon);
		} // END addChemieIcon()
		public function addWasteIcon(_y:Number):void {
			wasteIcon.x = 0;
			wasteIcon.y = _y;
			container.addChild(wasteIcon);
		} // END addWasteIcon()
		
		public function configureAtomicTitle():void {
			atomicTitle.x = atomicIcon.width+10;
			atomicTitle.y = 2;
			addAtomicIcon(atomicTitle.y+1);
			setTextField(atomicTitle,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			atomicTitle.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			atomicTitle.text = "Atomare Gefahren"
			container.addChild(atomicTitle);
		} // END configureAtomicTitle()
		public function configureAtomicSumDanger(_target):void {
			atomicSumDanger.x = atomicTitle.x+atomicTitle.textWidth+20;
			atomicSumDanger.y = atomicTitle.y;
			setTextField(atomicSumDanger,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			atomicSumDanger.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setAtomicSumDanger(_target);
			container.addChild(atomicSumDanger);
		} // END configureAtomicSumDanger()
		private function configureAtomicSubtitels(_target):void {
			setAtomicSubtitels(_target);
			atomicSubtitels.x = atomicTitle.x;
			atomicSubtitels.y = atomicTitle.y+atomicTitle.textHeight+10;
			setTextField(atomicSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			atomicSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setAtomicSubtitels(_target);
			container.addChild(atomicSubtitels);
		} // END configureAtomicSubtitels()
		private function configureAtomicDangers(_target):void {
			setAtomicDangers(_target);
			atomicDangers.x = atomicTitle.x+atomicSubtitels.textWidth+20;
			atomicDangers.y = atomicSubtitels.y;
			setTextField(atomicDangers,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			atomicDangers.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setAtomicDangers(_target);
			container.addChild(atomicDangers);
		} // END configureAtomicDangers()
		
		public function configureBiologicalTitle():void {
			biologicalTitle.x = atomicTitle.x;
			biologicalTitle.y = atomicDangers.y+atomicDangers.textHeight+30;
			addBioIcon(biologicalTitle.y+1);
			setTextField(biologicalTitle,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			biologicalTitle.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			biologicalTitle.text = "Biologische Gefahren"
			container.addChild(biologicalTitle);
		} // END configureBiologicalTitle()
		public function configureBiologicalSumDanger(_target):void {
			biologicalSumDanger.x = biologicalTitle.x+biologicalTitle.textWidth+20;
			biologicalSumDanger.y = biologicalTitle.y;
			setTextField(biologicalSumDanger,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			biologicalSumDanger.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setBiologicalSumDanger(_target);
			container.addChild(biologicalSumDanger);
		} // END configureBiologicalSumDanger()
		private function configureBiologicalSubtitels(_target):void {
			setBiologicalSubtitels(_target);
			biologicalSubtitels.x = atomicTitle.x;
			biologicalSubtitels.y = biologicalTitle.y+biologicalTitle.textHeight+10;
			setTextField(biologicalSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			biologicalSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setBiologicalSubtitels(_target);
			container.addChild(biologicalSubtitels);
		} // END configureBiologicalSubtitels()
		private function configureBiologicalDangers(_target):void {
			setBiologicalDangers(_target);
			biologicalDangers.x = atomicTitle.x+biologicalSubtitels.textWidth+20;
			biologicalDangers.y = biologicalSubtitels.y;
			setTextField(biologicalDangers,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			biologicalDangers.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setBiologicalDangers(_target);
			container.addChild(biologicalDangers);
		} // END configureBiologicalDangers()
		
		public function configureChemicalTitle():void {
			chemicalTitle.x = atomicTitle.x;
			chemicalTitle.y = biologicalDangers.y+biologicalDangers.textHeight+30;
			addChemieIcon(chemicalTitle.y+1);
			setTextField(chemicalTitle,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			chemicalTitle.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			chemicalTitle.text = "Chemische Gefahren"
			container.addChild(chemicalTitle);
		} // END configureChemicalTitle()
		public function configureChemicalSumDanger(_target):void {
			chemicalSumDanger.x = chemicalTitle.x+chemicalTitle.textWidth+20;
			chemicalSumDanger.y = chemicalTitle.y;
			setTextField(chemicalSumDanger,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			chemicalSumDanger.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setChemicalSumDanger(_target);
			container.addChild(chemicalSumDanger);
		} // END configureChemicalSumDanger()
		private function configureChemicalSubtitels(_target):void {
			setChemicalSubtitels(_target);
			chemicalSubtitels.x = atomicTitle.x;
			chemicalSubtitels.y = chemicalTitle.y+chemicalTitle.textHeight+10;
			setTextField(chemicalSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			chemicalSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setChemicalSubtitels(_target);
			container.addChild(chemicalSubtitels);
		} // END configureChemicalSubtitels()
		private function configureChemicalDangers(_target):void {
			setChemicalDangers(_target);
			chemicalDangers.x = atomicTitle.x+chemicalSubtitels.textWidth+20;
			chemicalDangers.y = chemicalSubtitels.y;
			setTextField(chemicalDangers,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			chemicalDangers.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setChemicalDangers(_target);
			container.addChild(chemicalDangers);
		} // END configureChemicalDangers()
		
		public function configureWasteTitle():void {
			wasteTitle.x = atomicTitle.x;
			wasteTitle.y = chemicalDangers.y+chemicalDangers.textHeight+30;
			addWasteIcon(wasteTitle.y+1);
			setTextField(wasteTitle,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			wasteTitle.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			wasteTitle.text = "Sondermüll Gefahren"
			container.addChild(wasteTitle);
		} // END configureWasteTitle()
		public function configureWasteSumDanger(_target):void {
			wasteSumDanger.x = wasteTitle.x+wasteTitle.textWidth+20;
			wasteSumDanger.y = wasteTitle.y;
			setTextField(wasteSumDanger,TextFieldAutoSize.LEFT,AntiAliasType.ADVANCED);
			wasteSumDanger.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setWasteSumDanger(_target);
			container.addChild(wasteSumDanger);
		} // END configureWasteSumDanger()
		private function configureWasteSubtitels(_target):void {
			setWasteSubtitels(_target);
			wasteSubtitels.x = atomicTitle.x;
			wasteSubtitels.y = wasteTitle.y+wasteTitle.textHeight+10;
			setTextField(wasteSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			wasteSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setWasteSubtitels(_target);
			container.addChild(wasteSubtitels);
		} // END configureWasteSubtitels()
		private function configureWasteDangers(_target):void {
			setWasteDangers(_target);
			wasteDangers.x = atomicTitle.x+wasteSubtitels.textWidth+20;
			wasteDangers.y = wasteSubtitels.y;
			setTextField(wasteDangers,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			wasteDangers.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setWasteDangers(_target);
			container.addChild(wasteDangers);
		} // END configureWasteDangers()
		
		public function setTextField(_textfield:TextField, _autoSize, _antiAliasType):void{
			_textfield.autoSize = _autoSize;
			_textfield.antiAliasType = _antiAliasType;
			_textfield.background	= false;
			_textfield.border			= false;
			_textfield.selectable	= false;
			_textfield.embedFonts	= true;
		} // END setTextField()
		
		public function setStyle(_font:String, _size:Number, _color:uint):TextFormat{
			var format:TextFormat = new TextFormat();
			format.font				= _font;
			format.color			= _color;
			format.size				= _size;
			format.underline	= false;
			format.leading		= 1.3;
			return format;
		} // END setStyle()

	} // END Records
} // END package
