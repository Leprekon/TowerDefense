package canvas.canvas3d {
	import canvas.*;
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.OrthographicOffCenterLens;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.debug.AwayStats;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.lights.shadowmaps.NearDirectionalShadowMapper;
	import away3d.materials.MaterialBase;
	import away3d.materials.SinglePassMaterialBase;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FilteredShadowMapMethod;
	import away3d.materials.methods.NearShadowMapMethod;

	import flash.geom.Vector3D;

	import framework.utils.StageUtil;

	public class Canvas3d extends BaseCanvas{
		private var _view:View3D;
		private var _rootContainer:ObjectContainer3D;
		private var _camera:Camera3D;
		private var _lightPicker:StaticLightPicker;
		private var _shadowMethod:NearShadowMapMethod;
		private var _light:DirectionalLight;

		public function Canvas3d() {
			init();
		}

		public override function clear():void {
			super.clear();
			while(_rootContainer.numChildren){
				_rootContainer.removeChildAt(0);
			}
		}

		private function init():void {
			_view = new View3D();
			_view.stage3DProxy = StageUtil.stage3DProxy;
			_view.shareContext = true;
			addChild(_view);

			_camera = _view.camera;
			_camera.lens = new OrthographicOffCenterLens(-1100, 1100, -565, 567);
			_camera.lens.far = 5000;
			_camera.lens.near = 10;
			_view.antiAlias = 2;

			_light = new DirectionalLight();
			_light.y = 1200;
			_light.x = 500;
			_light.lookAt(new Vector3D(1100, 0, 1100));
			_light.ambient = 0.3;
			_light.diffuse = 0.7;

			var nearDirectionalShadowMapper:NearDirectionalShadowMapper = new NearDirectionalShadowMapper();
			nearDirectionalShadowMapper.coverageRatio = 0.6;
			_light.shadowMapper = nearDirectionalShadowMapper;

			_view.scene.addChild(_light);
			_lightPicker = new StaticLightPicker([ _light]);

			_shadowMethod = new NearShadowMapMethod(new FilteredShadowMapMethod(_light));
			_shadowMethod.fadeRatio = 2;

			_rootContainer = new ObjectContainer3D();
			_view.scene.addChild(_rootContainer);

			AwayStats.instance.registerView(_view);
			addChild(AwayStats.instance);
			resize();
		}

		protected override function resize():void {
			super.resize();
			_view.width = width;
			_view.height = height;
		}

		public function addModel(object3d:ObjectContainer3D):void {
			updateMaterials(object3d);
			_rootContainer.addChild(object3d);
		}

		public function updateMaterials(object3d:ObjectContainer3D):void {
			var materials:Vector.<MaterialBase> = collectMaterials(object3d);
			for each(var material:MaterialBase in materials){
				material.lightPicker = _lightPicker;
				if(material is SinglePassMaterialBase){
					SinglePassMaterialBase(material).shadowMethod = _shadowMethod;
				}
			}
		}

		private function collectMaterials(object3d:ObjectContainer3D):Vector.<MaterialBase> {
			var result:Vector.<MaterialBase> = new <MaterialBase>[];
			if(object3d is Mesh){
				result.push(Mesh(object3d).material);
			}
			for (var i:int = 0; i < object3d.numChildren; i++){
				var child:ObjectContainer3D = object3d.getChildAt(i);
				result = result.concat(collectMaterials(child));
			}
			return result;
		}

		public function get camera():Camera3D {
			return _camera;
		}

		public override function render():void {
			_view.render();
		}

		public function removeModel(model:ObjectContainer3D):void {
			_rootContainer.removeChild(model);
		}

		public function get lens():OrthographicOffCenterLens{
			return OrthographicOffCenterLens(_camera.lens);
		}

		public function get shadowMethod():NearShadowMapMethod {
			return _shadowMethod;
		}

		public function get light():DirectionalLight {
			return _light;
		}

		public function get shadowMapper():NearDirectionalShadowMapper {
			return NearDirectionalShadowMapper(_light.shadowMapper);
		}
	}
}
