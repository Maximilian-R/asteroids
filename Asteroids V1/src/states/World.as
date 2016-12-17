package states {
	import GUI.GameInfo;
	import SFX.SoundManager;
	import core.Entity;
	import core.Level;
	import core.PowerUpManager;
	import core.Utils;
	import events.AsteroidBreakEvent;
	import events.ShotEvent;
	import gameobjects.Asteroid;
	import gameobjects.Bullet;
	import gameobjects.UFO;
	import gameobjects.gfx.GFX;
	import gameobjects.gfx.GFXSreenShake;
	import gameobjects.gfx.GFXStarShine;
	import gameobjects.gfx.GFXBoom;
	import gameobjects.Ship;
	import gameobjects.superpowers.RapidFire;
	import gameobjects.superpowers.Superpower;
	import blueprints.IRocketDesign;
	import blueprints.Karlavagnen;
	import blueprints.Lejonet;
	import blueprints.Skorpionen;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import core.Config;
	import core.Key;
	import events.WarpEvent;
	
	public class World extends Sprite implements IState {
		
		/* -------------------- Debugging ------------------ */
		public var _collision:Sprite = new Sprite();
		
		/* -------------------- Entities ------------------ */
		private var _bullets:Vector.<Entity> = new Vector.<Entity>;
		private var _asteroids:Vector.<Entity> = new Vector.<Entity>;
		private var _starSigns:Vector.<Entity> = new Vector.<Entity>;
		private var _gfxs:Vector.<Entity> = new Vector.<Entity>;
		private var _ufos:Vector.<Entity> = new Vector.<Entity>;
		private var _superPowers:Vector.<Entity> = new Vector.<Entity>;
		private var _ship:Ship;
		
		/* -------------------- Background Scenery ------------------ */
		private var _background:Graphics;
		private var _stars:Sprite = new Sprite();
		private var _gui:GameInfo = new GameInfo();
		
		/* -------------------- Administration ------------------ */
		private var _returnState:IState;
		private var _powerManager:PowerUpManager;
		private var _spawnUFOIn:Number = core.Utils.randomNum(400, 1000);
		private var _paused:Boolean = false;
		
		/* -------------------- Scoring ------------------ */
		private var _currentLevel:Level;
		private var _score:Number = 0;
		private var _timePassed:Number = 0;
		
		public function World(rocketDesign:IRocketDesign) {
			super();
			addChild(_collision);
			
			_gui = new GameInfo();
			_ship = new Ship(rocketDesign, Config.WORLD_WIDTH * 0.5, Config.WORLD_HEIGHT * 0.5);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		public function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Key.DISPATCHER.addEventListener(Keyboard.ESCAPE + "", backToShipPicker);
			Key.DISPATCHER.addEventListener(Keyboard.P + "", pause);
			_ship.shotCommand._dispatcher.addEventListener(Config.SHOT_EVENT_STRING, onPlayerShot);
			_ship.warpCommand._dispatcher.addEventListener(Config.WARP_EVENT_STRING, onPlayerWarp);
			
			_powerManager = new PowerUpManager(this);
			_background = graphics;
			
			drawStars();
			parent.addChild(_gui);
			addChild(_ship);
			
			setBackgroundColor(Config.getColor("color", "stage"));
			
			nextLevel();
			updateGUI();
		}
		
		private function pause(e:Event):void {
			_paused = !_paused;
			updateGUI();
			if (_paused) {
				SoundManager.sharedInstance().pauseAllSounds();
			} else {
				SoundManager.sharedInstance().resumeAllSounds();
			}
		}
		
		private function setBackgroundColor(color:uint):void {
			_background.beginFill(color, 1);
			_background.drawRect(0, 0, stage.stageWidth, stage.stageHeight)
		}
		
		public function update():IState {
			if (_paused) {
				return null;
			}
			
			if (_returnState) {
				return _returnState;
			}
			
			if (!_ship.isAlive) {
				return new GameOver(_score, 0);
			}
			
			_timePassed++;
			
			if (_spawnUFOIn-- <= 0){
				spawnUFO();
			}
			if (_asteroids.length == 0) {
				nextLevel();
			}
			
			updateEntities();
			collisionDetectEntites();
			removeDeadEntites();
			return null;
		}
		
		public function nextLevel():void {	
			if (_currentLevel == null) {
				_currentLevel = Config.getLevel(1);
			} else {
				_score += _currentLevel.completionScore;
				_currentLevel = Config.getLevel(_currentLevel.level + 1);
				SFX.SoundManager.sharedInstance()._nextLevel.playSound();
				SFX.SoundManager.sharedInstance()._nextLevel.playSound();
			}
			
			if (_currentLevel.level > 3) {
				var bonus:Number = Config.getNumber("max_time_bonus", "score") - _timePassed;
				if (bonus < 0 ) {
					bonus = 0;
				}
				_returnState = new GameOver(_score, bonus);
				return;
			} 
			
			spawnAsteroids(_currentLevel.asteroids);
			updateGUI();
		}
		
		public function updateGUI():void {
			_gui.currentLevel = _currentLevel.level;
			_gui.healthBarText = _ship.health;
			_gui.currentScore = _score;
			_gui.paused = _paused;
		}
		
		public function addEntity(e:Entity):void {
			if (e is Asteroid) {
				_asteroids.push(e);
				e.addEventListener(Config.ASTEROID_BREAK, onAsteroidBreak, false, 0, true);
			} else if (e is Bullet) {
				_bullets.push(e);
			} else if (e is GFX) {
				_gfxs.push(e);
			} else if (e is UFO) {
				_ufos.push(e);
				var ufo:UFO = e as UFO;
				ufo.shoot._dispatcher.addEventListener(Config.SHOT_EVENT_STRING, onPlayerShot);
			} else if (e is Superpower) {
				_superPowers.push(e);
			} else if (e is Entity) {
				_starSigns.push(e);
			}
			addChild(e);
		}
		
		private function backToShipPicker(e:Event):void {
			_returnState = new PickShipState();
		}
		
		private function spawnAsteroids(amount:Number):void {
			var margin:Number = Config.getNumber("no_spawn_zone", "stage");
			var noSpawnZone:Number = _ship.radius + margin;
			for (var i:int = 0; i < amount; i++) {
				var xPos:Number = (Math.random() <= 0.5) ? core.Utils.randomNum(0,_ship.x - noSpawnZone) : core.Utils.randomNum(_ship.x + noSpawnZone, Config.WORLD_WIDTH);
				var yPos:Number = core.Utils.randomNum(0, Config.WORLD_HEIGHT);
				addEntity(new Asteroid(xPos, yPos, Asteroid.TYPE_BIG));
			}
		}
		
		private function spawnUFO():void {
			var y:Number = core.Utils.randomNum(0, Config.WORLD_HEIGHT); 
			addEntity(new UFO(0, y, _ship));
			var spawnIntervalMin:Number = Config.getNumber("spawn_interval_min", "ufo");
			var spawnIntervalMax:Number = Config.getNumber("spawn_interval_max", "ufo");
			_spawnUFOIn = core.Utils.randomNum(spawnIntervalMin, spawnIntervalMax);
			SFX.SoundManager.sharedInstance()._ufo.playSound(0, 3);
		}
		
		public function onAsteroidBreak(e:AsteroidBreakEvent):void {
			var spawnCount:Number = Config.getInt("child_count", e.asteroidType);
			var newType:String = Config.getString("child_type", e.asteroidType);
			var x:Number = 0;
			var y:Number = 0;
			while (spawnCount--) {
				var radius:Number = Config.getNumber("radius", newType);
				x = core.Utils.coinFlip() ? (e.x + radius) : (e.x - radius);
				y = core.Utils.coinFlip() ? (e.y + radius) : (e.y - radius);
				var a:Entity = new Asteroid(x, y, newType);
				addEntity(a);
			}
		}
		
		public function onPlayerShot(e:ShotEvent):void {
			var b:Bullet = new Bullet(e.shooter, e.x, e.y, e.rotation);
			addEntity(b);
		}
		
		public function onPlayerWarp(e:WarpEvent):void {
			addEntity(new GFXStarShine(e.x, e.y));
		}
		
		public function drawStars():void {
			_stars.graphics.beginFill(0xFFFFFF, 1);
			_stars.graphics.lineStyle(0);
			var stars:Number = Config.getNumber("stars", "stage");
			for (var i:int = 0; i < stars; i++) {
				_stars.graphics.drawCircle(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight, 2);
			}
			addChild(_stars);
			
			var starSign1:Entity = new Karlavagnen(700, 300);
			var starSign2:Entity = new Lejonet(700, 700);
			var starSign3:Entity = new Skorpionen(1400, 500)
			addEntity(starSign1);
			addEntity(starSign2);
			addEntity(starSign3);
		}
		
		private function updateEntities():void {
			_ship.update();
			_powerManager.update();
			
			var entites:Vector.<Entity> = _ufos.concat(_bullets, _asteroids, _starSigns, _gfxs, _superPowers);
			for each (var entity:Entity in entites) {
				entity.update();
			}
		}
		
		private function collisionDetectEntites():void {
			for each (var a:Entity in _asteroids) {
				for each (var b:Entity in _bullets) {
					if (b.isColliding(a)) {
						a.onCollision(b);
						b.onCollision(a);
						addEntity(new GFXSreenShake());
						addEntity(new GFXBoom(b.x, b.y));
						_score += Config.getNumber("asteroid", "score");
						updateGUI();
						break;
					}
				}
				if (_ship.isColliding(a)) {
					a.onCollision(_ship);
					_ship.onCollision(a);
					addEntity(new GFXBoom(a.x, a.y));
					addEntity(new GFXStarShine(_ship.x, _ship.y));
					break;
				}
			}
			
			for each (b in _bullets) {
				if (_ship.isColliding(b)) {
					b.onCollision(_ship);
					_ship.onCollision(b);
					addEntity(new GFXBoom(b.x, b.y));
					break;
				}
				for each (var ufo:UFO in _ufos) {
					if (ufo.isColliding(b)) {
						ufo.onCollision(b);
						b.onCollision(ufo);
						addEntity(new GFXBoom(b.x, b.y));
						_score+= Config.getNumber("ufo", "score");
						updateGUI();
						SoundManager.sharedInstance()._ufo.stop();
						break;
					}
				}
			}
			
			for each (var superPower:Superpower in _superPowers) {
				if (_ship.isColliding(superPower)) {
					superPower.onCollision(_ship);
					SFX.SoundManager.sharedInstance()._powerUp.play();
					break;
				}
			}
		}
		
		private function removeDeadEntites():void {
			removeDead(_bullets);
			removeDead(_asteroids);
			removeDead(_gfxs);
			removeDead(_ufos);
			removeDead(_superPowers);
		}
		
		private function removeDead(entities:Vector.<Entity>):void {
			for each (var entity:Entity in entities) {
				if (!entity.isAlive) {
					removeChild(entity);
					var index1:Number = entities.indexOf(entity);
					entities.removeAt(index1);
				}
			}
		}
		
		public function destroy():void {
			removeChildren(0, numChildren - 1);
			parent.removeChild(_gui);
			
			_timePassed = 0;
			_score = 0;
			_spawnUFOIn = 0;
			_currentLevel = null;
			
			_asteroids = new Vector.<Entity>;
			_bullets = new Vector.<Entity>;
			_starSigns = new Vector.<Entity>;
			_gfxs = new Vector.<Entity>;
			_superPowers = new Vector.<Entity>;
			_ufos = new Vector.<Entity>;
			
			_background = null;
			_ship = null;
			_stars = null;
			_gui = null;
			_collision = null;
			
			SoundManager.sharedInstance().stopAllSounds();
		}
	}
}