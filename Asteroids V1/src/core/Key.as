package core {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class Key {
		
		public static var DISPATCHER:EventDispatcher = new EventDispatcher();
		
		private static var _initialized:Boolean = false;
		private static var _keys:Object = {};
		
		public function Key() {}
		
		public static function init(stage:Stage):void {
			if (!_initialized) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			_initialized = true;
			}
		}
		
		public static function isDown(keyCode:uint):Boolean {
			return (keyCode in _keys);
		}
				
		private static function onKeyDown(e:KeyboardEvent):void {
			DISPATCHER.dispatchEvent(new Event("" + e.keyCode));
			_keys[e.keyCode] = true;
		}
		
		private static function onKeyUp(e:KeyboardEvent):void {
			delete _keys[e.keyCode];
		}
		
		public static function onDeactivate(e:Event):void {
			_keys = {};
		}
	}
}	