package SFX {
	import SFX.SimpleSound;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer
	;
	public class SoundManager {
		
		private static var _instance:SoundManager = null;
		
		public var _music:SimpleSound; 
		public var _thrust:SimpleSound;
		public var _fire:SimpleSound;
		public var _powerUp:SimpleSound;
		public var _boom:SimpleSound;
		public var _warp:SimpleSound;
		public var _ufo:SimpleSound;
		public var _nextLevel:SimpleSound;
		private var _sounds:Vector.<SimpleSound> = new Vector.<SimpleSound>;
		private var _initCalled:Boolean = false;
		
		public function SoundManager() {}
		
		public static function sharedInstance():SoundManager {
            if (_instance == null) {
                _instance = new SoundManager();
            }
            return _instance;
        }
		
		public function init():void {
			_initCalled = true;
			
			_music = new SFX.SimpleSound("../bin/assets/11 Theme Parks After Dark.mp3");
			_thrust = new SFX.SimpleSound("../bin/assets/thrust.mp3");
			_fire = new SFX.SimpleSound("../bin/assets/shoot.mp3");
			_powerUp = new SFX.SimpleSound("../bin/assets/PowerUp.mp3");
			_boom = new SFX.SimpleSound("../bin/assets/Boom.mp3");
			_warp = new SFX.SimpleSound("../bin/assets/Warp.mp3");
			_ufo = new SFX.SimpleSound("../bin/assets/UFO.mp3");
			_nextLevel = new SFX.SimpleSound("../bin/assets/nextLevel.mp3");
			
			_sounds.push(_music);
			_sounds.push(_thrust);
			_sounds.push(_fire);
			_sounds.push(_powerUp);
			_sounds.push(_boom);
			_sounds.push(_warp);
			_sounds.push(_ufo);
			_sounds.push(_nextLevel);
		}
		
		public function pauseAllSounds():void {
			if (!_initCalled) {
				trace("Call init() on SoundManager once before using sounds.")
				return;
			}
			
			for each (var sound:SimpleSound in _sounds) {
				sound.pause();
			}
		}
		public function resumeAllSounds():void {
			if (!_initCalled) {
				trace("Call init() on SoundManager once before using sounds.")
				return;
			}
			
			for each (var sound:SimpleSound in _sounds) {
				sound.resume();
			}
		}
		
		public function stopAllSounds():void {
			SoundMixer.stopAll();
		}
		
	}
}