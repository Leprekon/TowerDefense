package {

	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.events.Stage3DEvent;
	import away3d.loaders.misc.SingleFileLoader;
	import away3d.loaders.parsers.Parsers;
	import away3d.loaders.parsers.ParticleGroupParser;

	import engine3d.fabric.ActorsFabric;

	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;

	import framework.console.ConsoleManager;
	import framework.utils.StageUtil;
	import framework.utils.StageUtil;
	import mvc.Facade;
	import mvc.enums.ViewType;
	import mvc.views.GameView;

	[SWF(backgroundColor='#202020', width='1280', height='720', frameRate='60')]
	public class TowerDefense extends Sprite {
		private var _consoleManager:ConsoleManager;

		public function TowerDefense() {
			if(stage != null){
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			}

		}

		private function handleAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			init();
		}

		private function init():void {
			Parsers.enableAllBundled();
			SingleFileLoader.enableParser(ParticleGroupParser);

			var stage3DManager:Stage3DManager = Stage3DManager.getInstance(stage);

			var stage3DProxy:Stage3DProxy = stage3DManager.getFreeStage3DProxy();
			StageUtil.init(stage, stage.stage3Ds[0], stage3DProxy);
			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
			stage3DProxy.antiAlias = 8;
			stage3DProxy.color = 0x0;
		}

		private function onContextCreated(event:Event):void
		{
			start();
		}

		private function start():void {
			Facade.instance.init();
			ActorsFabric.instance.addEventListener(Event.COMPLETE, handleActorsLoaded);
			ActorsFabric.instance.loadAssets();
		}

		private function handleActorsLoaded(event:Event):void {
			Facade.instance.gameConfig.addEventListener(Event.COMPLETE, handleConfigLoaded);
			Facade.instance.gameConfig.loadConfig();
		}

		private function handleConfigLoaded(event:Event):void {
			Facade.instance.gameConfig.removeEventListener(Event.COMPLETE, handleConfigLoaded);
			addChild(Facade.instance.canvas3d);
			addChild(Facade.instance.canvas2d);

			StageUtil.fpsMeter.start(stage.frameRate);

//			stage.addEventListener(Event.RESIZE, handleResize);

			StageUtil.stage3DProxy.addEventListener(Event.ENTER_FRAME, handleEnterFrame);

			_consoleManager = new ConsoleManager(this);
			_consoleManager.init();

			Facade.instance.activeView = ViewType.GAME;
			GameView(Facade.instance.getView(ViewType.GAME)).loadLevel("testLevel");
		}

		private function handleEnterFrame(event:Event):void {
			Facade.instance.canvas3d.render();
			Facade.instance.canvas2d.render();
			StageUtil.fpsMeter.update();
		}

		private function handleResize(event:Event):void {
			Facade.instance.canvas3d.width = Facade.instance.canvas2d.width = stage.stageWidth;
			Facade.instance.canvas3d.height = Facade.instance.canvas2d.height = stage.stageHeight;
		}
	}
}
