//////////////////////////////////////////////////////////////////////////
//  Candeo
//
//  Created by Benjamin Wiederkehr on 08-04-28.
//  Copyright (c) 2008 IAD / ZHDK. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////
package  {

	//--------------------------------------
	//  IMPORT
	//--------------------------------------
	import flash.ui.Keyboard;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import barchart.*;
	import tools.*;
	import gui.*;
	import map.*;
	/**
	 *	DocumentClass für Candeo
	 *	
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  08-04-28
	 */
	public class CandeoDC extends MovieClip {
		//--------------------------------------
		//  VARIABLES
		//--------------------------------------
		public static var stage			:Stage;
		public static var root			:DisplayObject;
		public var ui								:GUI;
		public var chart						:Chart;
		public var tooltip					:Tooltip;
		public var sourceTooltip		:SourceTooltip;
		public var potentialTooltip	:PotentialTooltip;
		public var map_container		:MapContainer;
		public var buildings_mc			:Array;
		public var buildings_data		:XML;
		public var institutes_data	:XML;
		public var records_data			:XML;
		public var loaders					:Array;
		public var Buildingloader		:URLLoader;
		public var Instituteloader	:URLLoader;
		public var Recordloader			:URLLoader;
		public var dangerLayer			:DangerLayer;
		//--------------------------------------
		//  CONSTANTS
		//--------------------------------------
		public const BACKGROUND			:int			= 0x0e0e0e;	// Hintergrundfarbe für Header und Chart
		public const F_ALPHA				:Number		= .1;				// Ausgeblendeter Alphawert
		public const P_ALPHA				:Number		= .5;				// Normaler Alphawert der Potentiale und Gebäude
		public const UI_ALPHA				:Number		= .25;			// Normaler Alphawert der UI Elemente
		public const O_ALPHA				:Number		= .85;			// Hover Alphawert
		public const A_ALPHA				:Number		= 1;				// Active Alphawert
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function CandeoDC(){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			CandeoDC.stage		= this.stage;
			CandeoDC.root			= this;
			map_container			= mapContainer_mc;
			buildings_mc			= new Array();
			ui								= new GUI(this);
			tooltip 					= new Tooltip(this);
			sourceTooltip			= new SourceTooltip(this);
			potentialTooltip	= new PotentialTooltip(this);
			loaders						= new Array();
			Buildingloader		= new URLLoader();
			Instituteloader		= new URLLoader();
			Recordloader			= new URLLoader();
			//--------------------------------------
			//  ARRAYS
			//--------------------------------------
			loaders.push(Buildingloader, Instituteloader, Recordloader);
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			Buildingloader.addEventListener(Event.COMPLETE, onBLoaded);
			Instituteloader.addEventListener(Event.COMPLETE, onILoaded);
			Recordloader.addEventListener(Event.COMPLETE, onRLoaded);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			//--------------------------------------
			//  ATTACHMENTS
			//--------------------------------------
			addChild(tooltip);
			addChild(sourceTooltip);
			addChild(potentialTooltip);
			addChild(ui);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			Key.initialize(stage);
			DispatchController.dispatchEvent(new Event("dcAttached"));
			MacMouseWheel.setup(stage);
			ini();
		}
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function ini():void{
			Buildingloader.load(	new URLRequest("http://artillery.ch/BachelorApp/buildings/data"));
			Instituteloader.load(	new URLRequest("http://artillery.ch/BachelorApp/institutes/data"));
			Recordloader.load(		new URLRequest("http://artillery.ch/BachelorApp/records/data"));
		} // END ini()
		public function onBLoaded(e:Event):void{
			buildings_mc.sort();
			buildings_data = new XML(e.target.data);
			ui.overlay.addGraph();
		} // END onBLoaded()
		public function onILoaded(e:Event):void{
			institutes_data = new XML(e.target.data);
			ui.overlay.addGraph();
		} // END onILoaded()
		public function onRLoaded(e:Event):void{
			records_data = new XML(e.target.data);
			ui.overlay.addGraph();
		} // END onRLoaded()
		public function displayApp():void{
			addBuildings();
			addDangerLayer();
			addinstitutes();
			registerConnections();
			addDangers();
			configureUI();
			mapContainer_mc.tChart = chart;
			ui.chart = chart;
			//ui.addFolder();
		} // END displayApp()
		public function keyDownHandler(event:KeyboardEvent):void{
			switch(event.keyCode){
				// Enter
				case 16:
				//stage.displayState = StageDisplayState.FULL_SCREEN;
				//ini();
				break;
			};
		} // END keyDownHandler()
		
		public function addBuildings():void{
			var bList:XMLList = buildings_data.item;
			for(var i:uint = 0; i<bList.length(); i++){
				buildings_mc[i].daten = new XML(bList[i]);
				var inst:XMLList = buildings_mc[i].daten.institutes.institute;
				for each (var tInst:XML in inst){
					buildings_mc[i].institutesData.push(tInst);
				};
			};
		} // END addBuildings()
		public function addinstitutes():void{
			var institutesData = new Array();
			var iList:XMLList = institutes_data.item;
			for(var j:uint = 0; j<iList.length(); j++){
				var daten:XML = new XML(iList[j]);
				if(daten.records != undefined){
					institutesData.push(daten);
				};
			};
			institutesData.sortOn('area');
			addChart(institutesData);
		} // END addinstitutes()
		public function addDangerLayer():void{
			dangerLayer	= new DangerLayer(this);
			map_container.addChildAt(dangerLayer,2);
		} // END addDangers()
		public function addChart(_inst:Array):void{
			chart	= new Chart(this, _inst);
			// CHANGED: hard coded index
			addChildAt(chart, 3);
			dangerLayer.tChart = chart;
		} // END addChart()
		public function registerConnections():void{
			for each (var building_mc:Building in buildings_mc){
				for each (var institute:XML in building_mc.institutesData){
					for each (var instituteObject:Object in chart.institutes){
						if(instituteObject.ch.daten.db.id == institute.id){
							instituteObject.ch.registerBuilding(building_mc);
							building_mc.registerInstitute(instituteObject);
						};
					};
				};
			};
		} // END registerConnections()
		public function addDangers():void{
			dangerLayer.mapDangers();
		} // END addDangers()
		public function configureUI():void{
			var tMax = dangerLayer.getMax();
			ui.filterUI.configureLabel(tMax);
		} // END configureUI()
	} // END CandeoDC
} // END package