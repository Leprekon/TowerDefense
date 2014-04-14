package engine.actors.moving.projectiles {
	import engine.UpdatePool;
	import engine.actors.Actor;
	import engine.actors.moving.MovingActor;
	import engine.actors.moving.projectiles.ProjectileType;
	import engine.actors.moving.units.Unit;
	import engine.callbacks.Callback;
	import engine.callbacks.RemoveActorCallback;
	import engine.config.ProjectileConfig;
	import engine.damage.DamageType;

	import flash.geom.Vector3D;

	import framework.utils.GeometryUtil;

	public class Projectile extends MovingActor {
		private var _target:Unit;
		private var _explodeRadius:int;
		private var _damage:int;
		private var _damageType:DamageType;
		private var _targetType:TargetType;
		private var _targetPosition:Vector3D;
		private var _type:ProjectileType;
		private var _alive:Boolean = true;
		private var _timeToFade:int;

		public function Projectile(id:int, type:ProjectileType, target:Unit) {
			super(id);
			_type = type;
			_target = target;

			getTargetFromUnit();
		}

		private function getTargetFromUnit():void {
			_targetPosition = _target.position.clone();
			_targetPosition.y = _target.height / 2;
		}

		override public function update(updatePool:UpdatePool):Vector.<Callback> {
			var callbacks:Vector.<Callback> = super.update(updatePool);

			if(_alive){
				if(_targetType == TargetType.UNIT){
					getTargetFromUnit();
				}

				updateMovement(updatePool.elapsedTime, _targetPosition.subtract(_position));
				if (GeometryUtil.calcDistance(_position, _targetPosition) <= 20) {
					_alive = false;
					_timeToFade = 2000;
					if(_targetType == TargetType.UNIT){
						callbacks = callbacks.concat(damageTarget(updatePool));
					} else {
						callbacks = callbacks.concat(explode(updatePool));
					}
				}
			} else {
				_timeToFade -= updatePool.elapsedTime;
				if(_timeToFade <= 0){
					callbacks.push(new RemoveActorCallback(this));
				}
			}
			return callbacks;
		}

		private function damageTarget(updatePool:UpdatePool):Vector.<Callback> {
			var callbacks:Vector.<Callback> = new <Callback>[];
			if(_target.alive){
				_target.damage(_damage, _damageType);
			}
			return callbacks;
		}

		private function explode(updatePool:UpdatePool):Vector.<Callback> {
			var callbacks:Vector.<Callback> = new <Callback>[];

			for each(var actor:Actor in updatePool.actors){
				if(actor is Unit){
					var unit:Unit = Unit(actor);
					if(GeometryUtil.calcDistance(unit.position, position) < _explodeRadius){
						unit.damage(_damage, _damageType);
					}
				}
			}
			return callbacks;
		}

		public function config(config:ProjectileConfig):void {
			_explodeRadius = config.explodeRadius;
			_targetType = config.targetType;
			_damage = config.damage;
			_speed = config.speed;
			_damageType = config.damageType;
		}

		public function get type():ProjectileType {
			return _type;
		}

		public function get alive():Boolean {
			return _alive;
		}
	}
}
