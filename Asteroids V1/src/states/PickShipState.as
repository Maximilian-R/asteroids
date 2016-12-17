package states 
{
	import GUI.GameInfo;
	import GUI.Label;
	import GUI.RocketButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import blueprints.*;
	
	/**
	 * ...
	 * @author Maximilian Rågmo
	 */
	public class PickShipState extends Sprite implements IState 
	{
		private var _chosenDesign:IRocketDesign;
		private var _instructions:Label = new Label("Thrust: W / Up \nRotate: A and Left / D and Right \nTurn: S / Down \nWarp: Shift \nShoot: Space \nPause: P", "Arial", false, 40, 0xFFFFFF, false);
		private var _ship1:RocketButton = new RocketButton(new RocketDesign1());
		private var _ship2:RocketButton = new RocketButton(new RocketDesign2());
		private var _ship3:RocketButton = new RocketButton(new RocketDesign3());
		
		[Embed(source="../../bin/assets/astronaut.png")]
		private var layer0Class:Class;
		private var astronaut:Bitmap = new layer0Class();
		
		public function PickShipState() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_ship1.x = stage.stageWidth * 0.4;
			_ship1.y = stage.stageHeight * 0.5;
			_ship2.x = stage.stageWidth * 0.5;
			_ship2.y = stage.stageHeight * 0.5;
			_ship3.x = stage.stageWidth * 0.6;
			_ship3.y = stage.stageHeight * 0.5;
			
			addChild(_ship1);
			addChild(_ship2);
			addChild(_ship3);
			
			makeButton(_ship1);
			makeButton(_ship2);
			makeButton(_ship3);
			
			_instructions.x = 0;
			addChild(_instructions);
			
			astronaut.width = 60;
			astronaut.height = 80;
			astronaut.y = stage.stageHeight * 0.5;
			addChild(astronaut)
		}
		
		public function chooseDesign(e:Event):void {
			var button:RocketButton = e.currentTarget as RocketButton; 
			_chosenDesign = button._bluePrint; 
		}
		
		private function makeButton(sprite:Sprite):void {
			sprite.graphics.beginFill(0x000000, 0);
			sprite.graphics.lineStyle(0, 0, 0);
			sprite.graphics.drawRect( -sprite.width * 0.5, -sprite.height * 0.5, sprite.width, sprite.height);
			sprite.buttonMode = true;
			sprite.addEventListener(MouseEvent.CLICK, chooseDesign);
		}	
		
		public function update():IState {
			astronaut.x = mouseX - astronaut.width * 0.5;
			if (astronaut.x < stage.stageWidth * 0.4) {
				astronaut.x = stage.stageWidth * 0.4
			} else if (astronaut.x > stage.stageWidth * 0.6) {
				astronaut.x = stage.stageWidth * 0.6;
			}
			
			if (_chosenDesign != null) {
				return new World(_chosenDesign);
			}
			return null;
		}
		
		public function destroy():void {
			removeChildren(0, numChildren -1);
			_ship1.removeEventListener(MouseEvent.CLICK, chooseDesign);
			_ship2.removeEventListener(MouseEvent.CLICK, chooseDesign);
			_ship3.removeEventListener(MouseEvent.CLICK, chooseDesign);
			_ship1 = null;
			_ship2 = null;
			_ship3 = null;
			_instructions = null;
			_chosenDesign = null;
		}
	}
}