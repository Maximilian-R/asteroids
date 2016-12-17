package commands {
	import commands.Command;
	import core.Entity;
	import flash.utils.getTimer;
	import core.Config;
	
	public class TurnCommand implements Command {
		private var _lastTurn:int = getTimer();
		
		public function TurnCommand() {	}
		
		public function execute(player:Entity):void {
			brake(player);
		}
		
		private function brake(player:Entity):void {
			var currentTime:int = getTimer();
			if (currentTime - _lastTurn > Config.getNumber("turn_rate", "ship")) {
				player.rotation += 180;
				_lastTurn = currentTime;
			}
		}
	}
}