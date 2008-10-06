//////////////////////////////////////////////////////////////////////////
//  DetailBuilding
//
//  Created by  on 2008-05-18.
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
	import flash.geom.ColorTransform;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import gui.*;
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-18
	 */
	public class DetailBuilding extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc													:Object;
		public var building										:Object;
		public var buildingIcon								:BuildingIcon;
		public var personIcon									:PersonIcon;
		public var secondPersonIcon						:PersonIcon;
		public var infoIcon										:InfoIcon;
		public var container									:Sprite;
		public var link												:Sprite;
		public var buildingName								:TextField;
		public var instituteNames							:TextField;
		public var buildingVariable						:TextField;
		public var instituteVariables					:TextField;
		public var spezificationSubtitels			:TextField;
		public var spezificationTitel					:TextField;
		public var spezifications							:TextField;
		public var safetyOfficersTitel				:TextField;
		public var safetyOfficersSubtitels		:TextField;
		public var safetyOfficers							:TextField;
		public var crisisOfficersTitel				:TextField;
		public var crisisOfficersSubtitels		:TextField;
		public var crisisOfficers							:TextField;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function DetailBuilding(_dc:Object, _building:Object){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc 												= _dc;
			building 									= _building;
			personIcon								= new PersonIcon();
			secondPersonIcon					= new PersonIcon();
			buildingIcon							= new BuildingIcon();
			infoIcon									= new InfoIcon();
			container									= new Sprite();
			link											= new Sprite();
			buildingName							= new TextField();
			instituteNames						= new TextField();
			buildingVariable					= new TextField();
			instituteVariables				= new TextField();
			spezificationSubtitels		= new TextField();
			spezificationTitel				= new TextField();
			spezifications						= new TextField();
			safetyOfficersTitel				= new TextField();
			safetyOfficersSubtitels		= new TextField();
			safetyOfficers						= new TextField();
			crisisOfficersTitel				= new TextField();
			crisisOfficersSubtitels		= new TextField();
			crisisOfficers						= new TextField();
			alpha											= 0;
			x													= 10;
			y													= dc.ui.header.height + 30;
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			drawDetailBuilding(building);
		}
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function setBuildingName():void {
			buildingName.text = building.daten.name;
		} // END setBuildingName()
		public function setBuildingVariable():void {
			buildingVariable.text = building.buildingPotential;
		} // END setBuildingVariable()
		public function setInstituteNames():void {
			instituteNames.text = "";
			for(var i:Number = 0; i<building.institutesData.length; i++){
				instituteNames.appendText(building.institutesDataComplete[i].daten.name+"\n");
			}
		} // END setInstituteNames()
		public function setInstituteVariables():void {
			instituteVariables.text = "";
			for(var i:Number = 0; i<building.institutesData.length; i++){
				instituteVariables.appendText(building.institutesDataComplete[i].potential+"\n");
			}
		} // END setInstituteVariables()
		public function setSpezifications(_target):void {
			spezifications.text = "5\n1835 m2\n176\n18 per day";
		} // END setSpezifications()
		public function setSafetyOfficers(_target):void {
			safetyOfficers.text = "Hans Muster\nPeter Guguseli\n";
		} // END setSafetyOfficers()
		public function setCrisisOfficers(_target):void {
			crisisOfficers.text = "Jürg Blub\n031 456 36 67\n076 653 84 74\n";
		} // END setCrisisOfficers()
		
		public function drawDetailBuilding(_target):void{
			drawContainer();
			configureBuildingName(_target);
			configureInstituteNames(_target);
			configureBuildingVariable(_target);
			configureInstituteVariables(_target);
			configureSpezificationTitel();
			configureSpezificationSubtitels();
			configureSpezifications(_target);
			configureSafetyOfficersTitel();
			configureSafetyOfficersSubtitels();
			configureSafetyOfficers(_target);
			configureCrisisOfficersTitel();
			configureCrisisOfficersSubtitels();
			configureCrisisOfficers(_target);
		} // END drawDetailBuilding()
		
		public function drawContainer():void{
			container.graphics.clear();
			container.graphics.beginFill(0x000000,0);
			container.graphics.drawRect(0, 0, 250, 300);
			container.graphics.endFill();
			addChild(container);
		} // END drawContainer()
		public function addBuildingIcon(_y:Number):void {
			buildingIcon.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 255, 255);
			buildingIcon.x = 0;
			buildingIcon.y = _y;
			addChild(buildingIcon);
		} // END addBuildingIcon()
		public function addInfoIcon(_y:Number):void {
			infoIcon.x = 0;
			infoIcon.y = _y;
			addChild(infoIcon);
		} // END addInfoIcon()
		public function addPersonIcon(_y:Number):void {
			personIcon.x = 0;
			personIcon.y = _y;
			addChild(personIcon);
		} // END addPersonIcon()
		public function addSecondPersonIcon(_y:Number):void {
			secondPersonIcon.x = 0;
			secondPersonIcon.y = _y;
			addChild(secondPersonIcon);
		} // END addSecondPersonIcon()
		public function drawLink(_startY:Number = 0, _target = null, _quantity:Number = undefined):void{
			var offset:Number = 0;
			var correction:Number = 0;
			link.x = container.x+7;
			link.y = 0;
			link.graphics.lineStyle(1, 0xFFFFFF, .75);
			if(_target != null){
				for(var i:Number = 0; i<_target.institutesData.length; i++){
					link.graphics.moveTo(0,_startY+22+offset);
					link.graphics.lineTo(0,_startY+35+offset);
					link.graphics.lineTo(8,_startY+35+offset);
					offset+=13;
				}
			} else {
				for(var j:Number = 0; j<_quantity; j++){
					link.graphics.moveTo(0,_startY+22+offset);
					link.graphics.lineTo(0,_startY+35+offset);
					link.graphics.lineTo(8,_startY+35+offset);
					offset+=13;
				}
			}
			addChildAt(link, 1);
		} // END drawLink()
		public function configureBuildingName(_target):void {
			addBuildingIcon(3);
			setBuildingName();
			buildingName.x = buildingIcon.width+10;
			buildingName.y = 2;
			setTextField(buildingName,TextFieldAutoSize.LEFT, AntiAliasType.ADVANCED);
			buildingName.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setBuildingName();
			addChild(buildingName);
		} // END configureBuildingName()
		public function configureInstituteNames(_target):void {
			drawLink(buildingIcon.y-2, _target);
			setInstituteNames();
			instituteNames.x = buildingName.x;
			instituteNames.y = buildingName.y+25;
			setTextField(instituteNames,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			instituteNames.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setInstituteNames();
			addChildAt(instituteNames, 1);
		} // END configureInstituteNames()
		private function configureBuildingVariable(_target):void {
			setBuildingVariable();
			buildingVariable.x = buildingName.x+buildingName.textWidth+20;
			buildingVariable.y = buildingName.y;
			setTextField(buildingVariable,TextFieldAutoSize.LEFT, AntiAliasType.ADVANCED);
			buildingVariable.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setBuildingVariable();
			addChildAt(buildingVariable, 1);
		} // END configureBuildingVariable()
		private function configureInstituteVariables(_target):void {
			setInstituteVariables();
			instituteVariables.x = buildingName.x+instituteNames.textWidth+20;
			instituteVariables.y = instituteNames.y;
			setTextField(instituteVariables,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			instituteVariables.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setInstituteVariables();
			addChildAt(instituteVariables, 1);
		} // END configureInstituteVariables()
		private function configureSpezificationTitel():void {
			setSpezificationTitel();
			spezificationTitel.x = buildingName.x;
			spezificationTitel.y = instituteNames.y+instituteNames.textHeight+30;
			addInfoIcon(spezificationTitel.y+1);
			setTextField(spezificationTitel,TextFieldAutoSize.LEFT, AntiAliasType.ADVANCED);
			spezificationTitel.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setSpezificationTitel();
			addChildAt(spezificationTitel, 1);
		} // END configureSpezificationTitel()
		public function setSpezificationTitel():void {
			spezificationTitel.text = "Spezifikationen";
		} // END setSpezificationTitel()
		private function configureSpezificationSubtitels():void {
			drawLink(spezificationTitel.y,null,4);
			setSpezificationSubtitels();
			spezificationSubtitels.x = spezificationTitel.x;
			spezificationSubtitels.y = spezificationTitel.y+spezificationTitel.textHeight+10;
			setTextField(spezificationSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			spezificationSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setSpezificationSubtitels();
			addChildAt(spezificationSubtitels, 1);
		} // END configureSpezificationSubtitels()
		public function setSpezificationSubtitels():void {
			spezificationSubtitels.text = "Stockwerke:\nFläche:\nAngestelte:\nBesucher:\n";
		} // END setSpezificationSubtitels()
		private function configureSpezifications(_target):void {
			setSpezifications(_target);
			spezifications.x = spezificationTitel.x+spezificationSubtitels.textWidth+20;
			spezifications.y = spezificationSubtitels.y;
			setTextField(spezifications,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			spezifications.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setSpezifications(_target);
			addChildAt(spezifications, 1);
		} // END configureSpezifications()
		private function configureSafetyOfficersTitel():void {
			setSafetyOfficersTitel();
			safetyOfficersTitel.x = buildingName.x;
			safetyOfficersTitel.y = spezificationSubtitels.y+spezificationSubtitels.textHeight+30;
			addPersonIcon(safetyOfficersTitel.y+1);
			setTextField(safetyOfficersTitel,TextFieldAutoSize.LEFT, AntiAliasType.ADVANCED);
			safetyOfficersTitel.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setSafetyOfficersTitel();
			addChildAt(safetyOfficersTitel, 1);
		} // END configureSafetyOfficersTitel()
		public function setSafetyOfficersTitel():void {
			safetyOfficersTitel.text = "Sicherheitsbeaftragter";
		} // END setSafetyOfficersTitel()
		public function configureSafetyOfficersSubtitels():void {
			drawLink(safetyOfficersTitel.y,null,2);
			setSafetyOfficersSubtitels();
			safetyOfficersSubtitels.x = buildingName.x;
			safetyOfficersSubtitels.y = safetyOfficersTitel.y+safetyOfficersTitel.textHeight+10;
			setTextField(safetyOfficersSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			safetyOfficersSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setSafetyOfficersSubtitels();
			addChildAt(safetyOfficersSubtitels, 1);
		} // END configureSafetyOfficersSubtitels()
		public function setSafetyOfficersSubtitels():void {
			safetyOfficersSubtitels.text = "Haupt:\nStellvertreter:\n";
		} // END setSafetyOfficersSubtitels()
		public function configureSafetyOfficers(_target):void {
			setSafetyOfficers(_target);
			safetyOfficers.x = safetyOfficersSubtitels.x+safetyOfficersSubtitels.textWidth+20;
			safetyOfficers.y = safetyOfficersSubtitels.y;
			setTextField(safetyOfficers,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			safetyOfficers.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setSafetyOfficers(_target);
			addChildAt(safetyOfficers, 1);
		} // END configureSafetyOfficers()
		private function configureCrisisOfficersTitel():void {
			setCrisisOfficersTitel();
			crisisOfficersTitel.x = buildingName.x;
			crisisOfficersTitel.y = safetyOfficersSubtitels.y+safetyOfficersSubtitels.textHeight+30;
			addSecondPersonIcon(crisisOfficersTitel.y+1);
			setTextField(crisisOfficersTitel,TextFieldAutoSize.LEFT, AntiAliasType.ADVANCED);
			crisisOfficersTitel.defaultTextFormat = setStyle("DIN-Bold", 12, 0xFFFFFF);
			setCrisisOfficersTitel();
			addChildAt(crisisOfficersTitel, 1);
		} // END configureCrisisOfficersTitel()
		public function setCrisisOfficersTitel():void {
			crisisOfficersTitel.text = "Krisenverantwortlicher";
		} // END setCrisisOfficersTitel()
		public function configureCrisisOfficersSubtitels():void {
			drawLink(crisisOfficersTitel.y,null,3);
			setCrisisOfficersSubtitels();
			crisisOfficersSubtitels.x = buildingName.x;
			crisisOfficersSubtitels.y = crisisOfficersTitel.y+crisisOfficersTitel.textHeight+10;
			setTextField(crisisOfficersSubtitels,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			crisisOfficersSubtitels.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setCrisisOfficersSubtitels();
			addChildAt(crisisOfficersSubtitels, 1);
		} // END configureCrisisOfficersSubtitels()
		public function setCrisisOfficersSubtitels():void {
			crisisOfficersSubtitels.text = "Name:\nTel:\nNatel:\n";
		} // END setCrisisOfficersSubtitels()
		public function configureCrisisOfficers(_target):void {
			setCrisisOfficers(_target);
			crisisOfficers.x = crisisOfficersSubtitels.x+crisisOfficersSubtitels.textWidth+20;
			crisisOfficers.y = crisisOfficersSubtitels.y;
			setTextField(crisisOfficers,TextFieldAutoSize.LEFT, AntiAliasType.NORMAL);
			crisisOfficers.defaultTextFormat = setStyle("DIN-Medium", 10, 0xFFFFFF);
			setCrisisOfficers(_target);
			addChildAt(crisisOfficers, 1);
		} // END configureCrisisOfficers()
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
	} // END Detail Building
} // END package
