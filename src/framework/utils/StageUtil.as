package framework.utils {
	import away3d.core.managers.Stage3DProxy;

	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class StageUtil {
		private static var _stage3D:Stage3D;
		private static var _stage:Stage;
		private static var _fpsMeter:FpsMeter;
		private static var _stage3DProxy:Stage3DProxy;

		public static function init(stage:Stage, stage3d:Stage3D, stage3DProxy:Stage3DProxy):void {
			_stage = stage;
			_stage3DProxy = stage3DProxy;
			_stage3D = stage3d;

			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align = StageAlign.TOP_LEFT;

			_fpsMeter = new FpsMeter();
		}

		public static function get stage3D():Stage3D {
			return _stage3D;
		}

		public static function get stage():Stage {
			return _stage;
		}

		public static function get fpsMeter():FpsMeter {
			return _fpsMeter;
		}

		public static function get stage3DProxy():Stage3DProxy {
			return _stage3DProxy;
		}
	}
}
