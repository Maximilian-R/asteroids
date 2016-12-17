package gameobjects {
	import blueprints.IRocketDesign;
	import blueprints.RocketFlame;
	import commands.*;
	import core.Entity;
	import core.Key;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import core.Config;
	import gameobjects.superpowers.Shield;
	import states.World;
	
	public class Ship extends core.Entity {	
		
		/* Need a reference to the command for world to listen at */ 
		private var _shotCommand:ShootCommand =  new ShootCommand("ship");
		private var _warpCommand:WarpCommand =  new WarpCommand();
		
		private var _keyUp:Command = new AccelerateCommand();
		private var _keyDown:Command = new TurnCommand();
		private var _keyLeft:Command = new RotateLeftCommand();
		private var _keyRight:Command = new RotateRightCommand();
		private var _keyShift:Command = _warpCommand;
		private var _keySpace:Command = _shotCommand;
		
		private var _flames:RocketFlame = new RocketFlame();
		private var _desgin:IRocketDesign = null;
		private var _shield:Shield = null;
		private var _immortal:Number = 0;
		private var _health:Number = 0;
		private var _friction:Number = 0;
		
		public function Ship(design:IRocketDesign, x:Number = 0, y:Number = 0) {
			super(x, y);
			_desgin = design;
			draw();
			_flames.y = _desgin.getFlamePosition();
			_health = Config.getNumber("lives", "ship");
			_friction = Config.getNumber("friction", "ship");
		}
		
		private function thrustForward():void {
			/* Negative cos, ship drawed vertically. */
			var angle:Number = this.rotation * (Math.PI / 180);
			var xAcceleration:Number = Math.sin(angle) * _thrust;
			var yAcceleration:Number = -(Math.cos(angle)) * _thrust; 
			
			_xVelocity += xAcceleration;
			_yVelocity += yAcceleration;
			
			_xVelocity *= _friction;
			_yVelocity *= _friction;
			
			// Gravity!
			_yVelocity += Config.getNumber("gravity", "ship");
			
			flames();
		}
		
		private function flames():void {
			if (_thrust != 0 ) {
				addChild(_flames);
				_flames._isAdded = true;
				_flames.drawThrust();
			} else if (_flames._isAdded) {
				_flames._isAdded = false;
				_flames.visible = false;
				removeChild(_flames);
			}
		}
	
		override public function update():void {
			_immortal--;
			if (_immortal == 0) {
				alpha = 1.0;
			}
			
			_thrust = 0;
			_rVelocity = 0;
			
			checkInput();
			thrustForward();
			super.update();
		}
		
		override protected function checkInput():void {
			if (Key.isDown(Keyboard.UP) || Key.isDown(Keyboard.W)) {
				_keyUp.execute(this);
			}
			
			if (Key.isDown(Keyboard.LEFT) || Key.isDown(Keyboard.A)) {
				_keyLeft.execute(this);
			}
			
			if (Key.isDown(Keyboard.RIGHT) || Key.isDown(Keyboard.D)) {
				_keyRight.execute(this);
			}
			
			if (Key.isDown(Keyboard.SPACE)) {
				_keySpace.execute(this);
			}
			
			if (Key.isDown(Keyboard.DOWN) || Key.isDown(Keyboard.S)) {
				_keyDown.execute(this);
			}
			
			if (Key.isDown(Keyboard.SHIFT)) {
				_keyShift.execute(this);
			}
		}
		
		override protected function draw():void {
			_desgin.draw(this);
			cacheAsBitmap = true;
		}
		
		private function isImmortal():Boolean {
			if (_immortal > 0) {
				return true;
			}
			return false;
		}
		
		private function goImmortal():void {
			_immortal = Config.getNumber("spawn_immortal_time", "immortal");
			alpha = Config.getNumber("opacity", "immortal");
		}
		
		override public function isColliding(that:Entity):Boolean {
			if (isImmortal()) {
				return false;
			}
			if (that is Bullet) {
				var bullet:Bullet = Bullet(that);
				if (bullet.shooter == this) {
					return false;
				}
			}
			return super.isColliding(that);
		}
		
		override public function onCollision(e:Entity):void {
			/* Dont call super, dont set isAlive to false */ 	
			
			if (isImmortal()) {
				return;
			}
			if (_shield != null && _shield.isAlive) {
				_shield.hit();
				return;
			}
			health -= 1;
			respawn();
			if (_health == 0) {
				_isAlive = false;
			}
		}
		
		private function respawn():void {
			x = Config.WORLD_WIDTH * 0.5;
			y = Config.WORLD_HEIGHT * 0.5;
			_yVelocity = 0;
			_xVelocity = 0;
			goImmortal();
		}
		
		override protected function worldWrap():void {
			/* Using shipheight on both axis since it's always larger than width. 
			That way, ship will always be fully out of view before teleporting */
			if (x - (shipHeight * 0.5) > stage.stageWidth) {
				x = 0 - (shipHeight * 0.5);
			} else if (x + (shipHeight * 0.5) < 0) {
				x = stage.stageWidth + (shipHeight * 0.5);
			} 
			
			if (y - (shipHeight * 0.5) > stage.stageHeight) {
				y = 0 - (shipHeight * 0.5);
			} else if (y + (shipHeight * 0.5) < 0) {
				y = stage.stageHeight + (shipHeight * 0.5);
			}
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get health():Number { return _health; }
		public function get shield():Shield { return _shield; }
		public function get desgin():IRocketDesign {return _desgin; }
		public function get shipWidth():Number { return _desgin.getWidth(); }
		public function get shipHeight():Number { return _desgin.getHeight(); }
		public function get shotCommand():ShootCommand { return _shotCommand; }
		public function get warpCommand():WarpCommand { return _warpCommand; }
		override public function get radius():Number {return 0.5 * Math.sqrt(_desgin.getWidth() * _desgin.getWidth() + _desgin.getHeight() * _desgin.getHeight()); }
		
		/* ------------------ SETTERS ----------------------*/ 
		public function set desgin(value:IRocketDesign):void { _desgin = value; }
		
		public function set health(value:Number):void { 
			_health = value;
			var world:World = World(parent);
			world.updateGUI();
		}
		
		public function set shield(value:Shield):void { 
			if (_shield != null) {
				removeChild(_shield);
				_shield = null;
			}
			_shield = value;
			addChild(_shield);
		}
	}
}