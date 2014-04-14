package mvc {
	import canvas.canvas2d.Canvas2d;
	import canvas.canvas3d.Canvas3d;

	import engine.config.GameConfig;

	import flash.utils.Dictionary;

	import framework.errors.SingletonInstantiationViolationError;

	import mvc.enums.ControllerType;
	import mvc.enums.ModelType;

	import mvc.enums.ViewType;
	import mvc.models.LevelModel;
	import mvc.views.GameView;

	public class Facade {
		private static var _allowInstantiation:Boolean = false;
		private static var _instance:Facade;

		private var _views:Dictionary = new Dictionary();
		private var _models:Dictionary = new Dictionary();
		private var _controllers:Dictionary = new Dictionary();

		private var _canvas3d:Canvas3d;
		private var _canvas2d:Canvas2d;

		private var _activeView:ViewType;

		private var _gameConfig:GameConfig;

		public function Facade() {
			if(!_allowInstantiation){
				throw new SingletonInstantiationViolationError();
			}
		}

		public static function get instance():Facade {
			if(_instance == null){
				_allowInstantiation = true;
				_instance = new Facade();
				_allowInstantiation = false;
			}

			return _instance;
		}

		public function getView(viewType:ViewType):BaseView {
			return _views[viewType];
		}

		public function getModel(modelType:ModelType): BaseModel {
			return _models[modelType];
		}

		public function getСontroller(controllerType:ControllerType):BaseController {
			return _controllers[controllerType];
		}

		public function get gameConfig():GameConfig {
			return _gameConfig;
		}

		public static function get config():GameConfig {
			return instance.gameConfig;
		}

		public function get canvas2d():Canvas2d {
			return _canvas2d;
		}

		public function get canvas3d():Canvas3d {
			return _canvas3d;
		}

		public function get activeView():ViewType {
			return _activeView;
		}

		public function set activeView(value:ViewType):void {
			if(_activeView != value){
				_canvas2d.clear();
				_canvas3d.clear();

				if(_activeView != null){
					getView(_activeView).hide();
				}
				_activeView = value;
				getView(_activeView).show();
			}
		}

		public function init():void{
			_canvas3d = new Canvas3d();
			_canvas2d = new Canvas2d();
			_gameConfig = new GameConfig();

			initModels();
			initControllers();
			initViews();
		}

		private function initModels():void {
			_models[ModelType.LEVEL] = new LevelModel();
		}

		private function initControllers():void {

		}

		private function initViews():void {
			_views[ViewType.GAME] = new GameView(_canvas3d, _canvas2d, LevelModel(getModel(ModelType.LEVEL)));
		}
	}
}
