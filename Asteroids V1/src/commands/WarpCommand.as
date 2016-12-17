package commands {
	import SFX.SoundManager;
	import core.Entity;
	import events.WarpEvent;
	import states.World;
	import flash.utils.getTimer;
	import core.Config;
	import core.Utils;
	import flash.events.EventDispatcher;
	
	public class WarpCommand implements Command {
		public var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _lastShot:int = getTimer();
		
		public function WarpCommand() {}

		public function execute(player:Entity):void {
			warp(player);
		}
		
		private function warp(player:Entity):void {
			var currentTime:int = getTimer();
			if (currentTime - _lastShot > Config.getNumber("warp_rate", "ship")) {
				_lastShot = currentTime;
				player.x = Utils.randomNum(0, Config.WORLD_WIDTH);
				player.y = Utils.randomNum(0, Config.WORLD_HEIGHT);
				SFX.SoundManager.sharedInstance()._warp.playSound();
				_dispatcher.dispatchEvent(new WarpEvent(player.x, player.y));
			}
		}
	}
}