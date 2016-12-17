package commands {
	import SFX.SoundManager;
	import core.Entity;
	import events.ShotEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	import core.Config;
	
	public class ShootCommand implements Command {
		public var _dispatcher:EventDispatcher = new EventDispatcher();
		private var _lastShot:int = getTimer();
		private var _entityName:String = "";
		private var _modifiedShotRate:Number = 0;
		
		public function ShootCommand(entityName:String) {
			_entityName = entityName;
		}
		
		public function execute(player:Entity):void {
			shoot(player);
		}
		
		private function shoot(player:Entity):void {
			var currentTime:int = getTimer();
			if (currentTime - _lastShot > Config.getNumber("shoot_rate", _entityName) + _modifiedShotRate) {
				var angle:Number = player.rotation * (Math.PI / 180);
				var xBullet:Number = Math.sin(angle) * player.height * 0.5;
				var yBullet:Number = -(Math.cos(angle)) * player.width * 0.5; 
				_dispatcher.dispatchEvent(new ShotEvent(player, player.x + xBullet, player.y + yBullet, player.rotation));
				SFX.SoundManager.sharedInstance()._fire.playSound();
				_lastShot = currentTime;
			}
		}
		
		public function set modifiedShotRate(value:Number):void {
			_modifiedShotRate = value;
		}
	}
}
