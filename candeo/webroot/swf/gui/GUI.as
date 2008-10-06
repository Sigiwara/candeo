//////////////////////////////////////////////////////////////////////////
//  GUI
//
//  Created by  on 2008-05-02.
//  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
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
	import barchart.Chart;
	
	/**
	 *	Sprite sub class description.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *	@author sigiwara
	 *	@since  2008-05-02
	 */
	public class GUI extends Sprite {
		
		//--------------------------------------
		//  Variables
		//--------------------------------------
		public var dc							:Object;
		public var overlay				:Overlay;
		public var chart					:Chart;
		public var header					:Header;
		public var zoomUI					:ZoomUI;
		public var filterUI				:FilterUI;
		public var zoomOutButton	:ZoomOutButton;
		public var zoomInButton		:ZoomInButton;
		public var chartFold			:ChartFold;
		//public var headerFold	:HeaderFold;
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		public function GUI(_dc){
			//--------------------------------------
			//  DEFINITIONS
			//--------------------------------------
			dc						= _dc;
			header				= new Header(dc);
			zoomUI				= new ZoomUI(dc);
			filterUI			= new FilterUI(dc);
			overlay				= new Overlay(dc);
			//--------------------------------------
			//  CALLS
			//--------------------------------------
			addChild(header);
			addChild(zoomUI);
			addChild(filterUI);
			addZoomOutButton();
			addZoomInButton();
			addChild(overlay);
		} // END GUI()
		
		//--------------------------------------
		//  METHODS
		//--------------------------------------
		/*public function addFolder():void{
			//chartFold			= new ChartFold(chart);
			//headerFold		= new HeaderFold(chart);
		} // END addFolder()*/
		
		public function addZoomOutButton():void{
			zoomOutButton = new ZoomOutButton(dc);
			zoomOutButton.x = 20;
			zoomOutButton.y = filterUI.y+filterUI.height-33;
			addChild(zoomOutButton);
		} // END addZoomOutButton()
		
		public function addZoomInButton():void{
			zoomInButton = new ZoomInButton(dc);
			zoomInButton.x = 20;
			zoomInButton.y = filterUI.y+19;
			addChild(zoomInButton);
		} // END addZoomInButton()
		
	}
}
