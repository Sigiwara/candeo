//////////////////////////////////////////////////////////////////////////
//  Chart
//
//  Created by Benjamin Wiederkehr on 2008-04-02.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package barchart{

	//--------------------------------------
	//  IMPORT
	//--------------------------------------
	import flash.display.*;
	import fl.motion.easing.*;
	import gs.TweenLite;
	import tools.Calculations;
	import flash.filters.*;
	import gui.*;
	/**
	 *	Barchart Class
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-04-02
	 */
	public class Chart extends MovieClip {
		//--------------------------------------
		//  VARIABLES
		//--------------------------------------
		public var dc								:Object;			// Document Class
		public var chartHeight			:Number;			// Höhe des Charts (Nach der Höhe der Stage)
		public var chartWidth				:Number;			// Breite des Charts (Nach der Breite der Stage)
		public var LINEHEIGHT				:Number;			// Höhe der UI Elemente und maximale Höhe der Potentiale
		public var POT_WIDTH				:Number;			// Breite der Potentiale
		public var INST_WIDTH				:Number;			// Breite der Institute
		public var hOrigo						:Number;			// Nullpunkt der x-Achse des Diagramms
		public var vOrigo						:Number;			// Nullpunkt der y-Achse des Diagramms
		public var columns					:Number;			// Anzahl Institute
		public var view							:String;			// Aktuelle Ansicht des Charts
		public var bg								:Sprite;			// Hintergrund des Charts
		public var detailContainer	:Sprite;			// Detail Container als Overlay
		public var th								:TableHeader;	// Table Header
		public var blockHeaders			:Array;				// Alle Teilgefahren Header
		public var blockRows				:Array;				// Alle Teilgefahren & Einzelgefahren
		public var blockLabels			:Array;				// Alle Labels der Teilgefahren
		public var blockTitles			:Array;				// Alle Titles der Teilgefahren
		public var rowHeaders				:Array;				// Alle Einzelgefahren Header
		public var rowLabels				:Array;				// Alle Labels der Einzelgefahren
		public var rowTitles				:Array;				// Alle Titel der Einzelgefahren
		public var instituteHeaders	:Array;				// Alle Institut Header
		public var areaHeaders			:Array;				// Alle Areal Header
		public var areaInstitutes		:Array;				// Alle Institute und Areale
		public var areaLabels				:Array;				// Alle Labels der Areale
		public var institutes				:Array;				// Alle Institute
		public var institutesData		:Array;				// Alle Informationen zu den Instituten aus der DB
		public var potentials				:Array;				// Alle Potentiale
		public var detailPotentials	:Array;				// Alle Detail Potentiale im Detail Container
		public var toggledRows			:Array;				// Alle aktuell ausgewählten Teilgefahren
		public var toggledArea			:AreaHeader		// Aktuel ausgewählter AreaHeader
		public var toggledBlock			:BlockHeader	// Aktuel ausgewählter BlockHeader
		public var detailInstitute	:ColumnHeader;// Das aktuell geöffnete Institute
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const PADDING_V	:int		= 10
		public const PADDING		:int		= 20;
		public const LINES			:int		= 15;
		public const UI_WIDTH		:int		= 16;
		public const UI_MARGIN	:int		= 2;
		public const V_MARGIN		:int		= 2;
		public const C_PADDING	:int		= 4;
		public const H_MARGIN		:int		= 15;

		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function Chart(_dc, _inst:Array){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc								= _dc;
			institutesData		= _inst;
			chartHeight				= dc.stage.stageHeight / 3;
			chartWidth				= dc.stage.stageWidth;
			columns						= _inst.length;
			LINEHEIGHT				= Math.round((chartHeight - 2*PADDING_V - C_PADDING) / (LINES+3));
			INST_WIDTH				= Math.round((chartWidth - 2*PADDING - 3*UI_WIDTH - 2*UI_MARGIN - (columns)*UI_MARGIN) / columns);
			POT_WIDTH					= INST_WIDTH - H_MARGIN + UI_MARGIN;
			hOrigo						= PADDING + 3*UI_WIDTH + 2*UI_MARGIN + H_MARGIN;
			vOrigo						= chartHeight - PADDING_V - 2*LINEHEIGHT - C_PADDING;
			detailContainer		= null;
			detailInstitute		= null;
			toggledArea				= null;
			toggledBlock			= null;
			toggledRows				= new Array();
			
			view							= "ex";
			
			detailPotentials	= new Array();
			potentials				= new Array();
			institutes				= new Array();
			rowHeaders				= new Array();
			rowLabels					= ["", "N", "Xi", "Xn", "C", "T", "T+", "F", "F+", "O", "E", "3", "2", "1", "C", "O"];
			rowTitles					= ["Hazardous Waste", "Dangerous for the environment", "Irritant", "Harmful", "Corrosive", "Toxic", "Very toxic", "Highly Flammable", "Extremely Flammable", "Oxidizing", "Explosive", "Security Level 3", "Security Level 2", "Security Level 1", "Closed", "Open"];
			blockHeaders			= new Array();
			blockRows					= [[0],[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],[11, 12, 13],[14, 15]];
			blockLabels				= ["S", "C", "B", "A"];
			blockTitles				= ["", "Chemicals", "Biologicals", "Atomics"];
			instituteHeaders	= new Array();
			areaHeaders				= new Array();
			areaInstitutes		= sortInstitutes(institutesData);
			areaLabels				= ["Inselspital", "Buehlplatz", "Tierklinik", "Grosse Schanze", "Sonstige"];
			
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			dc.dangerLayer.tChart = this;
			drawBG();
			drawFilter();
			drawTableHeader();
			drawBlockHeaders();
			drawRowHeaders();
			drawAreaHeaders();
			drawInstitutes();
			setPosition();
			//foldPotentials();
		} // END Barchart()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function setPosition():void
		{
			this.x = 0;
			this.y = dc.stage.stageHeight - chartHeight;
		} // END setPosition()
		public function sortInstitutes(_array:Array):Array{
			var tInstitutes:Array = [[], [], [], [], []];
			for each (var item:Object in _array){
				var tArea:int = item.area -1;
				tInstitutes[tArea].push(item);
			}
			return tInstitutes;
		} // END sortInstitutes()
		
		//--------------------------------------
		//  DRAW
		//--------------------------------------
		public function drawBG():void
		{
			bg = new Sprite();
			bg.graphics.beginFill(dc.BACKGROUND, 1);
			bg.graphics.drawRect(0, 0, chartWidth, chartHeight);
			bg.graphics.endFill();
			bg.graphics.lineStyle(1, 0xffffff, .25);
			bg.graphics.lineTo(chartWidth, 0);
			addChild(bg);
		} // END drawUI()
		
		public function drawFilter():void{
			var shadow:BitmapFilter = new DropShadowFilter(5,-90,0x000000,1,20,20,.75,BitmapFilterQuality.HIGH,false,false);
			filters = [shadow];
		} // END drawFilter()
		public function drawTableHeader():void{
			th			= new TableHeader(UI_WIDTH, LINES*LINEHEIGHT-V_MARGIN, this);
			th.x		= PADDING;
			th.y		= PADDING_V - UI_MARGIN;
			addChild(th);
		} // END drawTableHeader()
		
		public function drawBlockHeaders():void{
			for ( var i=0; i<blockRows.length; i++ ) {
				var bh:BlockHeader;
				var tRows		= blockRows[i];
				var tLabel	= blockLabels[i];
				var tTitle	= blockTitles[i];
				var tHeight:Number = blockRows[i].length*LINEHEIGHT;
				bh = new BlockHeader(i, tRows, UI_WIDTH, tHeight-V_MARGIN, tLabel, tTitle, this);
				bh.x = PADDING + UI_WIDTH + UI_MARGIN;
				bh.y = vOrigo - (tRows[tRows.length-1]*(LINEHEIGHT-V_MARGIN));
				bh.y = vOrigo - tHeight - tRows[0]*LINEHEIGHT;
				blockHeaders.push(bh);
				addChild(bh);
			};
		} // END drawBlockHeaders()
		
		public function drawRowHeaders():void{
			for ( var i=0; i<=LINES; i++ ) {
				var rh:RowHeader;
				var tLabel = rowLabels[i];
				var tTitle = rowTitles[i];
				rh = new RowHeader(i, UI_WIDTH, LINEHEIGHT-V_MARGIN, tLabel, tTitle, this);
				rh.x			= PADDING + 2*UI_WIDTH + 2*UI_MARGIN;
				rh.y			= vOrigo - LINEHEIGHT*(i+1);
				rh.block	= Calculations.calcBlock(i);
				rh.registerBlocks();
				rowHeaders.push(rh);
				addChild(rh);
			};
		} // END drawRowHeaders()
		
		public function drawAreaHeaders():void{
			var tOffset:Number = 0;
			for ( var i=0; i<areaLabels.length; i++ ) {
				var ah:AreaHeader;
				var tLabel = areaLabels[i];
				var tWidth = areaInstitutes[i].length * POT_WIDTH + (areaInstitutes[i].length) * H_MARGIN - UI_MARGIN;
				ah = new AreaHeader(i, tWidth , LINEHEIGHT-V_MARGIN, tLabel, this);
				ah.x = hOrigo + tOffset - Math.round((INST_WIDTH - POT_WIDTH)/2);
				ah.y = vOrigo + LINEHEIGHT + C_PADDING;
				areaHeaders.push(ah);
				addChild(ah);
				tOffset += tWidth + UI_MARGIN;
			};
		} // END drawAreaHeaders()
		
		public function drawInstitutes():void
		{
			for ( var i:int = 0; i < institutesData.length; i++ ){
				var institute:Object	= new Object();
				institute.potential		= 0;
				institute.daten				= institutesData[i];
				institute.ch					= drawInstituteHeader(i);
				institute.records			= dc.dangerLayer.getRecordsRemote(institute);
				institute.potentials	= drawPotentials(i, institute);
				combineInstitute(institute);
				registerAreaHeader(institute);
				institutes.push(institute);
			}
			definePotentials();
		} // END drawInstitutes()
		public function combineInstitute(_institute:Object):void
		{
			_institute.ch.institute = _institute;
			_institute.ch.daten.potentials = _institute.potentials;
		} // END combineInstitute()
		
		public function registerAreaHeader(_institute:Object):void
		{
			for each (var ah:AreaHeader in areaHeaders){
				if(_institute.ch.area == ah.pIndex){
					_institute.areaHeader = ah;
					_institute.ch.areaHeader = ah;
					ah.institutes.push(_institute);
					for each (var pot in _institute.potentials){
						pot.areaHeader = ah;
					};
				};
			};
		} // END registerAreaHeader()
		
		public function drawInstituteHeader(_i:int):ColumnHeader
		{
			var ch:ColumnHeader;
			ch						= new ColumnHeader(_i, INST_WIDTH, LINEHEIGHT-V_MARGIN, this, institutesData[_i]);
			ch.x					= hOrigo + (INST_WIDTH + UI_MARGIN) * _i - Math.round((INST_WIDTH - POT_WIDTH)/2);
			ch.y					= vOrigo + C_PADDING;
			ch.daten.xPos	= ch.x;
			instituteHeaders.push(ch);
			addChild(ch);
			return ch;
		} // END drawInstituteHeader()
		
		public function drawPotentials(_i:Number, _institute:Object):Array
		{
			var iPos					:Number	= _i;
			var tPotentials		:Array	= new Array();
			var tRecordPots		:Array	= dc.dangerLayer.orderInstitutePotentials(_institute);
			for ( var i=0; i<=LINES; i++ ) {
				var pot:Potential;
				pot				= new Potential(this, POT_WIDTH, LINEHEIGHT-V_MARGIN, i, tRecordPots[i]);
				pot.institute = _institute;
				pot.x			= hOrigo + (POT_WIDTH + H_MARGIN) * iPos;
				pot.index	= potentials.length;
				pot.block	= Calculations.calcBlock(i);
				pot.dType	= Calculations.calcType(i);
				pot.area	= institutesData[iPos].area -1;
				pot.registerHeader();
				tPotentials.push(pot);
				potentials.push(pot);
				_institute.potential += tRecordPots[i];
				dc.dangerLayer.setMax(i, tRecordPots[i]);
				addChildAt(pot, 1);
			};
			return tPotentials;
		} // END drawPotentials()
		
		public function definePotentials():void
		{
			for each (var _i:Object in institutes){
				var fPos					:Number	= vOrigo;
				var bOffset				:Number	= 0;
				for ( var i=0; i<=LINES; i++ ) {
					var pot:Potential = _i.potentials[i];
					pot.ini();
					pot.y			= vOrigo - LINEHEIGHT*(i) - pot.height - V_MARGIN;
					pot.ePos	= pot.y;
					pot.fPos	= fPos - pot.height - V_MARGIN;
					pot.bfPos	= vOrigo - blockRows[pot.block][0]*LINEHEIGHT - pot.height - bOffset - V_MARGIN;
					fPos			-= Calculations.calcFPos(i, pot.height);
					bOffset		-= Calculations.calcBlockOffset(i, bOffset, pot.height);
					pot.drawCon();
					pot.fadeCon(dc.F_ALPHA);
				};
			};
		} // END definePotentials()
		
		public function drawDetailContainer(_data:Object):void
		{
			if(detailContainer != null){
				removeChild(detailContainer);
			};
			var tXPos		:Number = PADDING + 3*UI_WIDTH + 3*UI_MARGIN;
			var tYPos		:Number = PADDING_V - V_MARGIN - C_PADDING/2 - 2;
			var tWidth	:Number = chartWidth - tXPos - PADDING + 3*UI_MARGIN;
			var tHeight	:Number = vOrigo - 2;
			detailContainer = new DetailContainer( tXPos, tYPos, tWidth, tHeight, this, rowLabels, _data );
			detailContainer.name = "detailContainer";
			addChild(detailContainer);
		} // END drawDetailContainer()
		//--------------------------------------
		//  FADE
		//--------------------------------------
		public function fadeIn(p:Object):void
		{
			var inst		:Object;
			var pot			:Potential;
			var dPot		:DetailPotential;
			var tIndex	:Number;
			var rh			:RowHeader;
			switch(p.what){
			case "rows":
				for each (pot in potentials){
					pot.fade(dc.F_ALPHA);
					for each (var _row:Number in p.who){
						if(pot.row == _row){
							pot.fade(dc.O_ALPHA);
						};
					};
					fadeToggledRows(pot);
					fadeToggledAreas(pot);
					fadeToggledBlocks(pot);
				};
				break;
			case "columns":
				tIndex = 0;
				for each (inst in institutes){
					for each (pot in inst.potentials){
						if(tIndex == p.who){
							pot.fade(dc.O_ALPHA);
							pot.fadeCon(dc.F_ALPHA);
						}else{
							pot.fade(dc.F_ALPHA);
						};
						fadeToggledRows(pot);
						fadeToggledBlocks(pot);
					};
					tIndex += 1;
				};
				break;
			case "potential":
				tIndex = 0;
				for each (pot in potentials){
					if(tIndex == p.who){
						pot.fade(dc.O_ALPHA);
						pot.fadeCon(dc.F_ALPHA);
					}else{
						pot.fade(dc.F_ALPHA);
					};
					fadeToggledRows(pot);
					fadeToggledBlocks(pot);
					tIndex += 1;
				};
				break;
			case "detailPotential":
				tIndex = 0;
				for each (dPot in detailPotentials){
					if(tIndex == p.who){
						dPot.fade(dc.O_ALPHA);
					}else{
						dPot.fade(dc.F_ALPHA);
					};
					tIndex += 1;
				};
				break;
			case "area":
				for each (pot in potentials){
					pot.fade(dc.F_ALPHA);
					if(pot.area == p.who){
						pot.fade(dc.O_ALPHA);
						pot.fadeCon(dc.F_ALPHA);
					};
					fadeToggledRows(pot);
					fadeToggledBlocks(pot);
				};
				break;
			};
		} // END fadeIn()
		
		public function fadeOut():void
		{
			for each (var pot:Potential in potentials){
				if(toggledRows.length == 0 && toggledArea == null && toggledBlock == null){
					pot.fade(dc.P_ALPHA);
				}else{
					pot.fade(dc.F_ALPHA);
				}
				fadeToggledRows(pot);
				fadeToggledBlocks(pot);
				fadeToggledAreas(pot)
			};
			for each (var dPot:DetailPotential in detailPotentials){
				dPot.fade(dc.P_ALPHA);
			};
		} // END fadeOut()
		public function fadeToggledRows(pot:Potential):void{
			for each (var rh:RowHeader in toggledRows){
				if(pot.row == rh.row){
					pot.fade(dc.O_ALPHA);
				};
			};
		} // END fadeToggledRows()
		
		public function fadeToggledBlocks(pot:Potential):void{
			if(toggledBlock != null){
				if(pot.blockHeader == toggledBlock){
					pot.fade(dc.O_ALPHA);
				};
			};
		} // END fadeToggledAreas()
		
		public function fadeToggledAreas(pot:Potential):void{
			if(toggledArea != null){
				if(pot.area == toggledArea.pIndex){
					pot.fade(dc.O_ALPHA);
					pot.fadeCon(dc.F_ALPHA);
				};
			};
		} // END fadeToggledAreas()
		
		//--------------------------------------
		//  FOLDING
		//--------------------------------------
		public function foldPotentials():void
		{
			for each (var inst:Object in institutes){
				for (var j:Number = 0; j < inst.potentials.length; j++){
					var tPot:Potential = inst.potentials[j];
					TweenLite.to(tPot, 1, {y:tPot.fPos, delay: 0*j, ease:Exponential.easeOut, onUpdate:tPot.drawCon});
				};
			};
		} // END foldPotentials()
		
		public function foldBlocks():void
		{
			for each (var inst:Object in institutes){
				for (var j:Number = 0; j < inst.potentials.length; j++){
					var tPot:Potential = inst.potentials[j];
					TweenLite.to(tPot, 1, {y:tPot.bfPos, delay: 0*j, ease:Exponential.easeOut, onUpdate:tPot.drawCon});
				};
			};
		} // END foldPotentials()
		
		public function expandPotentials():void
		{
			for each (var inst:Object in institutes){
				for (var j:Number = 0; j < inst.potentials.length; j++){
					var tPot:Potential = inst.potentials[j];
					var tPos:Number = tPot.ePos;
					TweenLite.to(tPot, 1, {y:tPos, delay: 0*j, ease:Exponential.easeOut, onUpdate:tPot.drawCon});
				};
			};
		} // END expandPotentials()
	} // END Barchart
} // END package