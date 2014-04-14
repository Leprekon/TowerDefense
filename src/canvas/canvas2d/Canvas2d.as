package canvas.canvas2d {
	import canvas.*;

	import feathers.themes.MetalWorksMobileTheme;

	import flash.display.Stage3D;

	import forms.GameForm;

	import framework.utils.StageUtil;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Canvas2d extends BaseCanvas{
		private var _starling:Starling;
		private var _container:Sprite;

		public function Canvas2d() {
			init();
		}

		private function init():void {
			_starling = new Starling(Sprite, StageUtil.stage, StageUtil.stage3DProxy.viewPort, StageUtil.stage3DProxy.stage3D);
			_starling.addEventListener(Event.ROOT_CREATED, handleRootCreated);
			_starling.start();
		}

		private function handleRootCreated(event:Event):void {
			new MetalWorksMobileTheme();
			_container = Sprite(_starling.root);
		}

//		private function get container():Sprite {
//			return ;
//		}

		public override function clear():void {
			super.clear();
//			if(container){
			_container.removeChildren();
//			}
		}

		public override function render():void {
			super.render();
			_starling.nextFrame();
		}

		public function showForm(gameForm:GameForm):void {
			_container.addChild(gameForm);
		}
	}
}
