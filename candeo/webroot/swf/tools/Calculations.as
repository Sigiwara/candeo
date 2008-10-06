//////////////////////////////////////////////////////////////////////////
//  Calculations
//
//  Created by Benjamin Wiederkehr on 2008-05-14.
//  Copyright (c) 2008 Benjamin Wiederkehr / Artillery.ch. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////

package tools {
	
	//--------------------------------------
	// IMPORT
	//--------------------------------------
	
	/**
	 *	Calculations for the Chart Grid
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author Benji
	 *	@since  2008-05-14
	 */
	public class Calculations {
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		public static function calcRow(_id:String):Number{
			switch(_id){
				case "Open":
				return 15;
				break;
				case "Closed":
				return 14;
				break;
				case "1":
				return 13;
				break;
				case "2":
				return 12;
				break;
				case "3":
				return 11;
				break;
				case "Explosive":
				return 10;
				break;
				case "Oxidizing":
				return 9;
				break;
				case "Extremely":
				return 8;
				break;
				case "Highly":
				return 7;
				break;
				case "Very":
				return 6;
				break;
				case "Toxic":
				return 5;
				break;
				case "Corrosive":
				return 4;
				break;
				case "Harmful":
				return 3;
				break;
				case "Irritant":
				return 2;
				break;
				case "Dangerous":
				return 1;
				break;
				case "Waste":
				return 0;
				break;
				default:
				return 0;
				break
			}
		} // END calcRow()
		
		public static function calcBlock(_i:int):Number{
			if(_i<1){		return 0;}
			if(_i<11){	return 1;}
			if(_i<14){	return 2;}
			if(_i<=15){	return 3;}
			return 0;
		} // END calcBlock()
		
		public static function calcType(_i:int):String{
			if(_i<1){		return "Waste";}
			if(_i<11){	return "Chemical";}
			if(_i<14){	return "Biologic";}
			if(_i<=15){	return "Atomic";}
			return "";
		} // END calcBlock()
		
		public static function calcFPos(_i:int, _height:int):Number{
			if(_i==0){	return _height + 2;}
			if(_i==10){	return _height + 2;}
			if(_i==13){	return _height + 2;}
			return _height;
		} // END calcFPos()
		
		public static function calcBlockOffset(_i:int, _bOffset:int, _height:int):Number{
			if(_i==0){	return _bOffset;}
			if(_i==10){	return _bOffset;}
			if(_i==13){	return _bOffset;}
			return -_height;
		} // END calcBlockOffset()
		
		public static function getRandom(_min, _max):Number{
			var tNumber:Number;
			tNumber = Math.round(Math.random()*(_max-_min))+_min;
			return tNumber;
		} // END getRandom()
		
		public static function print_a(_obj):void {
			var item:Object;
			switch (typeof(_obj)){
				case "object":
				trace("–––––––––––––––––––––––––––––––––––––" + "[ Object ]");
				for each (item in _obj){
					trace("––––––––––––––––––" + "[ Item ]");
					trace("Type: " + typeof(item));
					trace("Value: " + item);
					trace("––––––––––––––––––" + "[ / Item ]");
				}
				trace("–––––––––––––––––––––––––––––––––––––" + "[ / Object ]");
				break;
				case "array":
				trace("–––––––––––––––––––––––––––––––––––––" + "[ Array ]");
				for each (item in _obj){
					trace("––––––––––––––––––" + "[ Item ]");
					trace("Type: " + typeof(item));
					trace("Value: " + item);
					trace("––––––––––––––––––" + "[ / Item ]");
				}
				trace("–––––––––––––––––––––––––––––––––––––" + "[ / Array ]");
				break;
				case "xml":
				trace("–––––––––––––––––––––––––––––––––––––" + "[ XML ]");
				trace(_obj);
				trace("–––––––––––––––––––––––––––––––––––––" + "[ / XML ]");
				break;
				default:
				trace("Type: " + typeof(_obj));
				trace(_obj);
				break
			}
		} // print_a()
	} // END Calculations
} // END package
