package framework.console {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import framework.utils.StageUtil;

	public class ConsoleManager {
		private var _container:Sprite;
		private var _developerConsole:DeveloperConsole;

		public function ConsoleManager(container:Sprite) {
			_container = container;
		}

		public function init():void {
			_developerConsole = new DeveloperConsole(new ConsoleCommands(), _container);
			_container.addChild(_developerConsole);

			StageUtil.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		}

		private function handleKeyUp(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.BACKQUOTE){
				_developerConsole.toggle();
			}
		}
	}
}
