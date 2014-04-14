package engine3d.fabric {
	import away3d.entities.Mesh;
	import away3d.entities.ParticleGroup;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.library.assets.IAsset;
	import away3d.loaders.AssetLoader;
	import away3d.loaders.misc.AssetLoaderContext;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SphereGeometry;

	import engine.actors.Actor;
	import engine.actors.ActorType;
	import engine.actors.construction.Construction;
	import engine.actors.moving.projectiles.Projectile;
	import engine.actors.moving.projectiles.ProjectileType;
	import engine.actors.towers.Tower;
	import engine.actors.towers.TowerType;
	import engine.actors.moving.units.Unit;
	import engine.actors.moving.units.UnitType;

	import engine3d.actors.Actor3D;
	import engine3d.actors.constructions.Construction3D;
	import engine3d.actors.projectiles.Projectile3D;
	import engine3d.actors.towers.Tower3D;
	import engine3d.actors.units.Unit3D;

	import flash.events.Event;

	import flash.events.EventDispatcher;

	import flash.utils.Dictionary;

	import framework.errors.AssetLoadError;
	import framework.errors.SingletonInstantiationViolationError;

	public class ActorsFabric extends EventDispatcher{
		[Embed(source="../../../assets/peasant.awd", mimeType="application/octet-stream")]
		private var _villagerUnitClass:Class;
		[Embed(source="../../../assets/militiaman.awd", mimeType="application/octet-stream")]
		private var _militiaUnitClassClass:Class;
		[Embed(source="../../../assets/tower_test.awd", mimeType="application/octet-stream")]
		private var _towerTestClass:Class;
		[Embed(source="../../../assets/tower_construction.awd", mimeType="application/octet-stream")]
		private var _constructionClass:Class;

		private var _assetByType:Dictionary = new Dictionary();
		private var _assetLoader:AssetLoader;
		private var _loadingQueue:Vector.<LoadingAsset> = new <LoadingAsset>[]

		private var _context:AssetLoaderContext;

		private static var _instance:ActorsFabric;
		private static var _allowInstantiation:Boolean = false;

		public function ActorsFabric() {
			if(!_allowInstantiation){
				throw new SingletonInstantiationViolationError();
			}
		}

		public function createActor(actor:Actor):Actor3D {
			var result:Actor3D;
			if(actor is Unit){
				var unit:Unit = Unit(actor);
				result = new Unit3D(actor.id, getUnitAsset(unit.type));
			} else if(actor is Tower){
				var tower:Tower = Tower(actor);
				result = new Tower3D(actor.id, getTowerAsset(tower.type));
			} else if(actor is Projectile){
				var projectile:Projectile = Projectile(actor);
				result = new Projectile3D(actor.id, getProjectileAsset(projectile.type));
			} else if(actor is Construction){
				var construction:Construction = Construction(actor);
				result = new Construction3D(actor.id, Mesh(_assetByType[ActorType.CONSTRUCTION].clone()));
			}
			return result;
		}

		private function getUnitAsset(type:UnitType):Mesh {
			var result:Mesh = Mesh(_assetByType[type].clone());
			result.castsShadows = true;
			result.rotationY = 90;
			return result;
		}

		private function getTowerAsset(type:TowerType):Mesh {
			var result:Mesh = Mesh(_assetByType[type].clone());
			return result;
		}

		private function getProjectileAsset(type:ProjectileType):ParticleGroup {
			var result:ParticleGroup = ParticleGroup(_assetByType[type].clone());
			result.animator.start();
			return result;
		}

		public function loadAssets():void {
			_context = EffectsAssets.createLoaderContext();

			_loadingQueue.push(new LoadingAsset(UnitType.VILLAGER, new _villagerUnitClass()));
			_loadingQueue.push(new LoadingAsset(UnitType.MILITIA, new _militiaUnitClassClass()));
			_loadingQueue.push(new LoadingAsset(TowerType.TEST_TOWER, new _towerTestClass()));
			_loadingQueue.push(new LoadingAsset(ActorType.CONSTRUCTION, new _constructionClass()));
			_loadingQueue.push(new LoadingAsset(ProjectileType.TEST, new EffectsAssets.testProjectileClass()));
			loadNextElement();
		}

		private function handleСompleteLoad(event:LoaderEvent):void {
			_assetLoader.removeEventListener(AssetEvent.ASSET_COMPLETE, handleAssetLoad);
			_assetLoader.removeEventListener(LoaderEvent.RESOURCE_COMPLETE, handleСompleteLoad);
			_assetLoader.removeEventListener(LoaderEvent.LOAD_ERROR, handleErrorLoadModel);

			_loadingQueue.shift();
			if(_loadingQueue.length > 0){
				loadNextElement();
			} else {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		private function loadNextElement():void {
			_assetLoader = new AssetLoader();
			_assetLoader.addEventListener(AssetEvent.ASSET_COMPLETE, handleAssetLoad);
			_assetLoader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, handleСompleteLoad);
			_assetLoader.addEventListener(LoaderEvent.LOAD_ERROR, handleErrorLoadModel);

			_assetLoader.loadData(currentLoadingAsset.data, null, _context);
		}

		private function get currentLoadingAsset():LoadingAsset {
			return _loadingQueue[0];
		}

		private function handleErrorLoadModel(event:LoaderEvent):void {
			throw new AssetLoadError(event.message);
		}

		private function handleAssetLoad(event:AssetEvent):void {
			var asset:IAsset = event.asset;
			if (asset.assetType == AssetType.MESH) {
				var mesh:Mesh = asset as Mesh;

				_assetByType[currentLoadingAsset.key] = mesh;
			} else if(asset.assetType == AssetType.CONTAINER && asset is ParticleGroup){
				var particleGroup:ParticleGroup = asset as ParticleGroup;
				_assetByType[currentLoadingAsset.key] = particleGroup;
			}
		}

		public static function get instance():ActorsFabric {
			if(_instance == null){
				_allowInstantiation = true;
				_instance = new ActorsFabric();
				_allowInstantiation = false;
			}
			return _instance;
		}
	}
}
