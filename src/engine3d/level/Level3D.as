package engine3d.level {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.MouseEvent3D;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.utils.Cast;

	import engine.level.Level;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class Level3D extends ObjectContainer3D{
		private var _ground:Mesh;

		public function Level3D() {

		}

		public function initLevel(level:Level):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoadComplete);
			loader.load(new URLRequest(level.groundAssetName));
		}

		private function handleLoadComplete(event:Event):void {
			var loader:LoaderInfo = LoaderInfo(event.currentTarget);
			var bitmap:Bitmap = loader.content as Bitmap;
			var material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(bitmap));

			_ground = new Mesh(new PlaneGeometry(2200, 2200), material);
			addChild(_ground);

			_ground.x = 1100;
			_ground.z = 800;

			_ground.mouseEnabled = true;
			_ground.addEventListener(MouseEvent3D.CLICK, handleMouseClick);
//			_ground.addEventListener(MouseEvent3D.MOUSE_MOVE, handleMouseMove);

			dispatchEvent(new Level3DEvent(Level3DEvent.LEVEL_CREATED));
		}

		private function handleMouseClick(event:MouseEvent3D):void {
			dispatchEvent(new Level3DEvent(Level3DEvent.CLICK_GROUND, event.scenePosition));
		}
	}
}
