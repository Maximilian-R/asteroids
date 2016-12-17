package core {
	import core.Config;
	import gameobjects.superpowers.Shield;
	import gameobjects.superpowers.HealthPack;
	import gameobjects.superpowers.Superpower;
	import gameobjects.superpowers.RapidFire;
	import gameobjects.superpowers.ShieldPower;
	import states.World;
	
	public class PowerUpManager {
		
		private var _world:World;
		private var _spawnInFrames:Number;
		private var _luckyRate:Number;
		
		public function PowerUpManager(world:World) {
			_world = world;
			_spawnInFrames = Config.getNumber("frames_between_spawns", "powermanager");
			_luckyRate = Config.getNumber("lucky_rate", "powermanager");
		}
		
		public function spawnPower():void {
			var number:Number = Math.random();
			var power:Superpower;
			if (number < 0.3) {
				power = new HealthPack();
			} else if (number < 0.6) {
				power = new ShieldPower()
			} else {
				power = new RapidFire();
			}
			
			power.x = Math.random() * Config.WORLD_WIDTH;
			power.y = Math.random() * Config.WORLD_HEIGHT;
			_world.addEntity(power);
		}
		
		public function update():void {
			if (_spawnInFrames-- == 0) {
				spawnPower();
				_spawnInFrames = Config.getNumber("frames_between_spawns", "powermanager");
			}
			if (Math.random() < _luckyRate) {
				spawnPower();
			}
		}
	}
}