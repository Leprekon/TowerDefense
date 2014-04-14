package framework.console {
	import away3d.entities.Mesh;

	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.events.Event;

	import framework.utils.StageUtil;

	import mvc.Facade;
	import mvc.enums.ViewType;
	import mvc.views.GameView;
	import mvc.views.GameView;

	public class ConsoleCommands {
		public function get stage():Stage {
			return StageUtil.stage;
		}

		public function get stage3D():Stage3D {
			return StageUtil.stage3D;
		}

		public function get facade():Facade {
			return Facade.instance;
		}

		public function get width():int {
			return facade.canvas3d.width;
		}

		public function set width(value:int):void {
			facade.canvas3d.width = value;
			facade.canvas2d.width = value;
		}

		public function get height():int {
			return facade.canvas3d.height;
		}

		public function set height(value:int):void {
			facade.canvas3d.height = value;
			facade.canvas2d.height = value;
		}

		public function loadLevel(name:String):void {
			GameView(Facade.instance.getView(ViewType.GAME)).loadLevel(name);
		}

		public function get debug():Boolean {
			return GameView(Facade.instance.getView(ViewType.GAME)).engine3D.debug;
		}

		public function set debug(value:Boolean):void {
			GameView(Facade.instance.getView(ViewType.GAME)).engine3D.debug = value;
		}

		public function restart():void {
			Facade.instance.gameConfig.addEventListener(Event.COMPLETE, handleConfigLoaded);
			Facade.instance.gameConfig.loadConfig();
		}

		private function handleConfigLoaded(event:Event):void {
			Facade.instance.gameConfig.removeEventListener(Event.COMPLETE, handleConfigLoaded);
			GameView(Facade.instance.getView(ViewType.GAME)).loadLevel("testLevel");
		}


	}
}