//
//  DispatchController
//
//  Created by sigiwara on 2008-04-03.
//  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
//
package tools {
	import flash.events.EventDispatcher;
	import flash.events.Event;

	public class DispatchController {
		static var disp:EventDispatcher;

		public static function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
			if (disp == null) { disp = new EventDispatcher(); }
			disp.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
		}

		public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
			if (disp == null) { return; }
			disp.removeEventListener(p_type, p_listener, p_useCapture);
		}

		public static function dispatchEvent(e:Event):void {
			if (disp == null) { return; }
			disp.dispatchEvent(e);
		}

		// Public API that dispatches an event
		public static function loadSomeData():void {
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}