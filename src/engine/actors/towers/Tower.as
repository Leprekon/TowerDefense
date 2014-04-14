package engine.actors.towers {
	import engine.UpdatePool;
	import engine.actors.Actor;
	import engine.actors.moving.projectiles.Projectile;
	import engine.actors.moving.projectiles.ProjectileType;
	import engine.actors.moving.units.Unit;
	import engine.callbacks.Callback;
	import engine.callbacks.SpawnActorCallback;
	import engine.config.ProjectileConfig;
	import engine.config.TowerConfig;

	import flash.geom.Vector3D;

	import framework.utils.GeometryUtil;

	public class Tower extends Actor{
		private var _type:TowerType;
		private var _fireRate:Number;
		private var _timeToNextShot:int = 0;
		private var _radius:int;
		private var _projectiles:Vector.<ProjectileConfig>;

		public function Tower(id:int, type:TowerType) {
			super(id);
			_type = type;
		}

		public function get type():TowerType {
			return _type;
		}

		override public function update(updatePool:UpdatePool):Vector.<Callback> {
			var callbacks:Vector.<Callback> = super.update(updatePool);

			if(_timeToNextShot >= 0){
				_timeToNextShot -= updatePool.elapsedTime;
			}

			if(_timeToNextShot < 0){
				var possibleTargets:Vector.<Unit> = new <Unit>[];
				for each(var actor:Actor in updatePool.actors){
					if(actor is Unit && (GeometryUtil.calcDistance(Unit(actor).position, position) < _radius)){
						possibleTargets.push(Unit(actor));
					}
				}

				if(possibleTargets.length > 0){
					var target:Unit = possibleTargets[Math.floor(Math.random() * possibleTargets.length)];
					var projectile:Projectile = new Projectile(updatePool.idGenerator.generate(), ProjectileType.TEST, target);
					projectile.config(_projectiles[0]);
					callbacks.push(new SpawnActorCallback(projectile, new Vector3D(position.x, 200, position.z)));
					_timeToNextShot += 1000 / _fireRate;
				}
			}
			return callbacks;
		}

		public function config(config:TowerConfig):void {
			_fireRate = config.fireRate;
			_radius = config.radius;
			_projectiles = config.projectiles;
		}
	}
}
