package core {
	import states.*;
	import GUI.Label;
	import SFX.SoundManager;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.utils.getTimer;
	
	[SWF(width="1920", height="1080", backgroundColor="0x000000", frameRate="30")]
	
	public class Main extends Sprite {
		
		private var _currentState:IState;
		private var _loadingLabel:Label = new Label("Loading...", "Arial", false, 70);
		
		public function Main() {
			if (!stage) {
				addEventListener(Event.ADDED_TO_STAGE, preload, false, 0 , true);
			} else {
				preload();
			}
		}
		
		private function preload(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, preload);
			
			_loadingLabel.x = Config.WORLD_WIDTH * 0.5 - _loadingLabel.width * 0.5;
			_loadingLabel.y = Config.WORLD_HEIGHT * 0.5 - _loadingLabel.height * 0.5;
			addChild(_loadingLabel);
			
			Config.loadConfig();
			Config.DISPATCHER.addEventListener(Event.COMPLETE, init, false, 0, true);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			removeChild(_loadingLabel);
			
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.addEventListener(Event.RESIZE, resizeOccurred);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			core.Key.init(stage);
			SFX.SoundManager.sharedInstance().init();
			
			setState(new PickShipState());
		}
		
		private function resizeOccurred(e:Event):void{
			stage.scaleMode = StageScaleMode.EXACT_FIT;
		}
		
		public function onEnterFrame(e:Event):void {
			var newState:IState = _currentState.update();
			if (newState != null) {
				setState(newState);
			}
		}
		
		private function setState(state:IState):void {
			if (_currentState != null) {
				_currentState.destroy();
				removeChild(_currentState as DisplayObject);
			}
			_currentState = state;
			addChild(state as DisplayObject);
		}
	}
}