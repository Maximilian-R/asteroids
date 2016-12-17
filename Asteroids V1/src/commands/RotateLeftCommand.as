package commands {
	import core.Config;
	import core.Entity;
	
	public class RotateLeftCommand implements Command {
		
		public function RotateLeftCommand() {}
		
		public function execute(player:Entity):void {
			rotate(player);
		}
		
		private function rotate(player:Entity):void {
			player.rVelocity = -(Config.getNumber("roational_thrust", "ship"));
		}
	}
}