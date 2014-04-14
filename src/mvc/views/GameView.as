package mvc.views {
	import canvas.canvas2d.Canvas2d;
	import canvas.canvas3d.Canvas3d;

	import engine.GameEngine;
	import engine.actors.Actor;
	import engine.actors.towers.TowerType;
	import engine.actors.moving.units.UnitType;
	import engine.events.GameEngineEvent;
	import engine.level.Level;
	import engine3d.Engine3D;
	import engine3d.actors.Actor3D;
	import engine3d.actors.constructions.Construction3D;
	import engine3d.events.Engine3DEvent;

	import flash.geom.Vector3D;

	import forms.GameForm;

	import mvc.BaseView;
	import mvc.events.LevelModelEvent;
	import mvc.models.LevelModel;

	public class GameView extends BaseView {
		private var _levelModel:LevelModel;
		private var _engine3D:Engine3D;
		private var _canvas3d:Canvas3d;
		private var _gameEngine:GameEngine;
		private var _gameForm:GameForm;
		private var _canvas2d:Canvas2d;

		public function GameView(canvas3d:Canvas3d, canvas2d:Canvas2d, levelModel:LevelModel) {
			super();
			_canvas3d = canvas3d;
			_canvas2d = canvas2d;
			_engine3D = new Engine3D(canvas3d);
			_gameEngine = new GameEngine();
			_levelModel = levelModel;

			init();
			initGUI();
		}

		private function init():void {
			_levelModel.addEventListener(LevelModelEvent.LEVEL_LOADED, handleLevelLoaded);
			_gameEngine.addEventListener(GameEngineEvent.UPDATED, handleEngineUpdated);
			_engine3D.addEventListener(Engine3DEvent.CLICK_GROUND, handleClickGround);
			_engine3D.addEventListener(Engine3DEvent.CLICK_ACTOR, handleClickActor);
		}

		private function initGUI():void {
			_gameForm = new GameForm();
		}

		private function handleClickActor(event:Engine3DEvent):void {
			var actor:Actor3D = event.data;
			if(actor is Construction3D){
				_gameEngine.createTower(TowerType.TEST_TOWER, actor.actorId);
			}
		}

		private function handleClickGround(event:Engine3DEvent):void {

		}

		private function handleEngineUpdated(event:GameEngineEvent):void {
			_engine3D.update(_gameEngine.actors);
			_gameForm.updateGold(_gameEngine.money);
		}

		private function handleLevelLoaded(event:LevelModelEvent):void {
			var level:Level = Level(event.data);
			_engine3D.initLevel(level);
			_gameEngine.startLevel(level);
		}

		override public function show():void {
			super.show();
			_engine3D.start();
			_gameEngine.start();
			_canvas2d.showForm(_gameForm);
		}

		public function loadLevel(name:String):void {
			_levelModel.loadLevel(name);
		}

		public function get engine3D():Engine3D {
			return _engine3D;
		}

		override public function hide():void {
			super.hide();
			_engine3D.stop();
			_gameEngine.stop();
		}
	}
}
