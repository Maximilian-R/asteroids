package commands {
	import SFX.SoundManager;
	import states.World;
	import flash.utils.getTimer;
	import core.Entity;
	import core.Config;
	
	public class AccelerateCommand implements Command {
		private var _soundLoopRate:int = 250;
		private var _lastPlay:int = getTimer();
		
		public function AccelerateCommand() {
		}

		public function execute(player:Entity):void {
			accelerate(player);
		}
		
		private function accelerate(player:Entity):void {
			player.thrust = Config.getNumber("thrust", "ship");
			
			var currentTime:int = getTimer();
			if (currentTime - _lastPlay > _soundLoopRate) {
				SFX.SoundManager.sharedInstance()._thrust.playSound();
				_lastPlay = currentTime;
			}
		}
	}
}