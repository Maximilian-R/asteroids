package commands {
	import core.Entity;
	import core.Config;
	public class RotateRightCommand implements Command {
		
		public function RotateRightCommand() {}
		
		public function execute(player:Entity):void {
			rotate(player);
		}
		
		private function rotate(player:Entity):void {
			player.rVelocity = Config.getNumber("roational_thrust", "ship");
		}
	}
}