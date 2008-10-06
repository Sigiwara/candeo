//////////////////////////////////////////////////////////////////////////
//  DangerLayer
//
//  Created by Benjamin Wiederkehr on 2008-05-21.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package map {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import fl.transitions.easing.*;
	import gs.TweenLite;
	import barchart.*;
	import tools.*;
	import gui.*;
	
	/**
	 *	Manager für alle Gefahren auf der Map. zuständig für die 
	 *	Kommunikation untereinander und zu den UI-Elemenmten und Chart
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-21
	 */
	public class DangerLayer extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc								:Object;
		public var mapContainer			:MapContainer;
		public var tChart						:Chart;
		public var buildingDangers	:Array;
		public var sourceDangers		:Array;
		public var sourceContainers	:Array;
		public var sourceGlowLayer	:Sprite;
		public var sourcePointLayer	:Sprite;
		public var records_data			:XML;
		public var recordsData			:Array;
		public var rowValues				:Array;
		public var rowMaxs					:Array;
		public var fadeActive				:Boolean;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function DangerLayer(_dc:Object){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc								= _dc;
			mapContainer			= dc.mapContainer_mc;
			sourceDangers			= new Array();
			sourceContainers	= new Array();
			sourceGlowLayer		= new Sprite();
			sourcePointLayer	= new Sprite();
			fadeActive 				= false;
			records_data			= dc.records_data;
			rowValues					= ["Waste", "Dangerous", "Irritant", "Harmful", "Corrosive", "Toxic", "Very", "Highly", "Extremely", "Oxidizing", "Explosive", "3", "2", "1", "Closed", "Open"];
			rowMaxs						= new Array();
			addChild(sourceGlowLayer);
			addChild(sourcePointLayer);
			//--------------------------------------
			//  LISTENERS
			//--------------------------------------
			DispatchController.addEventListener("resetComplete", onResetComplete);
			DispatchController.addEventListener("mapMode", onFadeComplete);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			addRecords();
			setRowMaxs();
		} // END DangerLayer()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		public function addRecords():void{
			recordsData		= new Array();
			var rList:XMLList = records_data.item;
			for(var i:uint = 0; i<rList.length(); i++){
				var daten:XML = new XML(rList[i]);
				recordsData.push(daten);
			};
			recordsData.sortOn('insituteid');
		} // END addRecords()
		
		public function getRecordsRemote(_i:Object):Array{
			var tRecords:Array = new Array();
			for each (var daten:XML in recordsData){
				if(_i.daten.id.toString() == daten.instituteid.toString()){
					var tR:Object = new Object();
					tR.daten = daten;
					tRecords.push(tR);
				};
			};
			return tRecords;
		} // END getRecordsRemote()
		
		public function expandRecord(_r:XML, _pot:Number):void{
			for each (var r:XML in recordsData){
				if(_r.id.toString() == r.id.toString()){
					r.potential = _pot;
				};
			};
		} // END expandRecord()
		
		public function mapDangers():void{
			buildingDangers		= new Array();
			for each (var b:Building in dc.buildings_mc){
				b.buildingDanger = null;
				var tRecords:Array = new Array();
				for each (var daten:XML in recordsData){
					if(b.daten.id.toString() == daten.buildingid.toString()){
						attachBuildingDangers(b, daten);
						tRecords.push(daten);
					};
				};
				b.recordsData = tRecords;
			};
			iniBuildingDangers();
		} // END mapDangers()
		
		public function attachBuildingDangers(_b:Building, _r:XML):void{
			fadeActive = true;
			if(_b.buildingDanger == null){
				var tBuildingDanger:BuildingDanger = new BuildingDanger(dc, _b);
				buildingDangers.push(tBuildingDanger);
				addChild(tBuildingDanger);
				TweenLite.to(tBuildingDanger, 2, {alpha:.5, ease:Strong.easeOut, onComplete:onFadeComplete});
			};
			var rObject	:Object	= new Object();
			rObject							= orderRecordPotentials(_r);
			rObject.row					= Calculations.calcRow(rObject.rowname);
			rObject.block				= Calculations.calcBlock(rObject.row);
			_b.buildingDanger.rowsRadius[rObject.row] += rObject.potential;
			_b.buildingDanger.blocksRadius[rObject.block] += rObject.potential;
			_b.buildingDanger.danger += rObject.potential;
			_b.buildingPotential += rObject.potential;
		} // END attachBuildingDangers()
		
		public function iniBuildingDangers():void{
			for each (var bd:BuildingDanger in buildingDangers){
				bd.ini();
			};
		} // END iniBuildingDangers()
		
		public function removeBuildingDanger():void{
			for each (var i:BuildingDanger in buildingDangers){
				removeChild(i);
			};
			buildingDangers = [];
		} // END removeBuildingDanger()
		
		public function addSourceDanger(_building, _potential):SourceDanger{
			var tSourceDanger:SourceDanger = new SourceDanger(dc, _building, _potential);
			var tSourceContainer:Sprite = new Sprite();
			tSourceDanger.sourceContainer = tSourceContainer;
			sourceDangers.push(tSourceDanger);
			sourceGlowLayer.addChild(tSourceDanger);
			sourcePointLayer.addChild(tSourceContainer);
			return tSourceDanger;
		}
		
		public function displaySourceDanger():void{
			for each (var _sd:SourceDanger in sourceDangers){
				_sd.ini();
			}
		} // END displaySourceDangers()
		
		public function removeSourceDanger():void{
			for each (var sd:SourceDanger in sourceDangers){
				sourceGlowLayer.removeChild(sd);
			};
			sourceDangers = [];
			for each (var sc:Sprite in sourceContainers){
				sourcePointLayer.removeChild(sc);
			};
			sourceContainers = [];
		} // END removeSourceDanger()
		
		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		public function onResetComplete(e:Event):void{
			mapDangers();
		} // END onResetComplete()
		public function onFadeComplete(e:Event = null):void{
			removeSourceDanger();
			fadeActive = false;
		} // END onFadeComplete();
		//--------------------------------------
		//  FADE DANGER
		//--------------------------------------
		public function fadeBlockDangers(_block:Number):void{
			var _bd:BuildingDanger;
			for each (_bd in buildingDangers){
				_bd.adaptSize(_bd.blocksRadius[_block]);
			};
			var _sd:SourceDanger;
			for each (_sd in sourceDangers){
				_sd.resetDanger();
				_sd.adaptToBlock(_block);
			};
		} // END fadeBlockDangers()
		public function fadeRowDangers(_row:Number):void{
			var _bd:BuildingDanger;
			for each (_bd in buildingDangers){
				_bd.adaptSize(_bd.rowsRadius[_row]);
			};
			var _sd:SourceDanger;
			for each (_sd in sourceDangers){
				_sd.resetDanger();
				_sd.adaptToRow(_row);
			};
		} // END fadeRowDangers()
		public function fadeFilterDangers(_d:Object):void{
			var _bd:BuildingDanger;
			for each (_bd in buildingDangers){
				_bd.adaptToFilter(_d);
			};
		} // END fadeFilterDangers()
		public function resetDangers():void{
			iniBuildingDangers();
			var _sd:SourceDanger;
			for each (_sd in sourceDangers){
				_sd.resetDanger();
			};
		} // END resetDangers()
		//--------------------------------------
		//  POTENTIAL CALCULATIONS
		//--------------------------------------
		public function getMax():Number{
			var tMax:Number = 0;
			for each (var bd:BuildingDanger in buildingDangers){
				if(bd.danger > tMax){
					tMax = bd.danger;
				};
			};
			return tMax;
		} // END getMax()
		public function orderInstitutePotentials(_institute:Object):Array{
			var tPotentials = new Array();
			for (var i:int = 0; i<rowValues.length; i++){
				var base:Number = 0;
				tPotentials.push(base);
			};
			for each (var r:Object in _institute.records){
				var tPot:Number;
				var tPos:Number;
				var rObject:Object = new Object();
				rObject = orderPotentialByType(r.daten);
				tPot = Math.ceil(rObject.potential);
				tPos = calcPos(rObject.rowname);
				tPotentials[tPos] += tPot;
				r.potential = tPot;
				r.row = tPos;
				expandRecord(r.daten, tPot);
			};
			return tPotentials;
		} // END orderInstitutePotentials()
		public function orderRecordPotentials(_r:XML):Object{
			var rObject	:Object = new Object();
			var tPot		:Number;
			var tPos		:Number;
			rObject			= orderPotentialByType(_r);
			tPot				= Math.ceil(rObject.potential);
			tPos				= calcPos(rObject.rowname);
			return rObject;
		} // END orderRecordPotentials()
		public function orderPotentialByType(_r:XML):Object{
			var rObject	:Object = new Object();
			var tId			:String;
			var tPot		:Number;
			switch(_r.sourcetype.toString()){
				case "Atomic":
				if(_r.atomicopen == 0){
					tId		= "Closed";
					tPot	= calcAPotential(_r, tId);
				}else{
					tId		= "Open";
					tPot	= calcAPotential(_r, tId);
				};
				break;
				case "Biological":
				tId			= _r.biologicalclass.toString();
				tPot		= calcBPotential(_r, tId);
				break;
				case "Chemical":
				var arr:Array 	= _r.chemicalname.split(" ");
				tId			= arr[0].toString();
				tPot		= calcCPotential(_r, tId);
				break;
				case "Waste":
				tId			= _r.sourcetype.toString()
				tPot		= calcWPotential(_r, tId);
				break;
			};
			rObject.rowname = tId;
			rObject.potential = tPot;
			return rObject;
		} // END orderPotentialByType()
		public function calcAPotential(_r:XML, _id:String):Number{
			switch(_id){
				case "Open" :
					tPot = _r.amount * 100;
				break;
				case "Closed" :
					tPot = _r.amount * 250;
				break;
			}
			var tPot:Number = _r.amount * 1000;
			return tPot;
		} // END calcAPotential()
		public function calcBPotential(_r:XML, _id:String):Number{
			var tPot:Number;
			switch(_id){
				case "1" :
					tPot = _r.amount * 100;
				break;
				case "2" :
					tPot = _r.amount * 250;
				break;
				case "3" :
					tPot = _r.amount * 500;
				break;
			}
			return tPot;
		} // END calcBPotential()
		public function calcCPotential(_r:XML, _id:String):Number{
			var tPot:Number;
			switch(_id){
				case "Dangerous" :
					tPot = _r.amount * 2;
				break;
				case "Irritant" :
					tPot = _r.amount * 0.0067;
				break;
				case "Harmful" :
					tPot = _r.amount * 0.0167;
				break;
				case "Corrosive" :
					tPot = _r.amount * 0.08;
				break;
				case "Toxic" :
					tPot = _r.amount * 0.625;
				break;
				case "Very" :
					tPot = _r.amount * 6;
				break;
				case "Highly" :
					tPot = _r.amount * 0.002;
				break;
				case "Extremely" :
					tPot = _r.amount * 0.0033;
				break;
				case "Oxidizing" :
					tPot = _r.amount * 0.0033;
				break;
				case "Explosive" :
					tPot = _r.amount * 1.75;
				break;
			};
			return tPot;
		} // END calcCPotential()
		public function calcWPotential(_r:XML, _id:String):Number{
			var tPot:Number = _r.amount * 1;
			return tPot;
		} // END calcWPotential()
		public function orderInstituteBuildingPotential(_i:Object, _b:Building):Number{
			var tPot:Number = 0;
			for each (var r:Object in _i.records){
				if(r.daten.buildingid.toString() == _b.daten.id.toString()){
					tPot += r.potential;
				};
			};
			return tPot;
		} // END orderInstituteBuildingPotential()
		public function calcPos(_Id:String):int{
			return rowValues.indexOf(_Id);
		} // END calcPos()
		public function calcHeight(_row:Number, _potential:Number):Number{
			var lineHeight:Number		= tChart.LINEHEIGHT - tChart.V_MARGIN
			var rowMaxHeight:Number	= rowMaxs[_row];
			var einheit:Number			= lineHeight / rowMaxHeight;
			var tHeight:Number			= 0;
			if(rowMaxHeight == 0){
				return 0;
			};
			if(_potential != 0){
				tHeight = lineHeight / rowMaxHeight * _potential;
			};
			return tHeight;
		} // END calcHeight()
		public function setRowMaxs():void{
			for (var i:int = 0; i<=15; i++){
				rowMaxs.push(0);
			}
		} // END setRowMaxs()
		public function setMax(_row:int, _pot:Number):void{
			var tPot:Number = Math.ceil(_pot);
			if(_pot > rowMaxs[_row]){
				rowMaxs[_row] = _pot;
			};
		} // END setMax()
	} // END DangerLayer
} // package
