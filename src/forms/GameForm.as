package forms {
	import feathers.controls.Label;
	import feathers.controls.Panel;

	import starling.text.TextField;

	public class GameForm extends BaseForm{
		private var _text:TextField;
//		private var _label:Label;
//		private var _panel:Panel;

		public function GameForm() {
			init();
		}

		private function init():void {
			_text = new TextField(200, 50, "Gold: 0");
			_text.fontSize = 14;
			_text.bold = true;
			_text.color = 0xDDDD00;
			_text.x = 120;
			addChild(_text);
		}

		public function updateGold(money:int):void {
			_text.text = "Gold: " + money;
		}
	}
}
