package engine.actors.moving.units {
	import engine.UpdatePool;
	import engine.actors.moving.MovingActor;
	import engine.callbacks.AddMoneyCallback;
	import engine.callbacks.Callback;
	import engine.callbacks.RemoveActorCallback;
	import engine.config.UnitConfig;
	import engine.damage.DamageType;
	import engine.level.Path;

	import flash.geom.Point;
	import flash.geom.Vector3D;

	import framework.utils.CoordUtil;
	import framework.utils.GeometryUtil;

	public class Unit extends MovingActor {
		private var _pathOffset:Number;
		private var _path:Path;
		private var _targetIndex:int;
		private var _target:Vector3D;
		private var _type:UnitType;
		private var _waitTime:int;
		private var _alive:Boolean = true;
		private var _moving:Boolean = false;
		private var _rotation:Number = 0;
		private var _ownPath:Path;
		private var _health:int;
		private var _maxHealth:int;
		private var _physicalResistance:Number;
		private var _magicResistance:Number;
		private var _height:int;
		private var _price:int;

		public function Unit(id:int, unitType:UnitType, path:Path, pathOffset:Number, unitTime:int) {
			super(id);
			_type = unitType;
			_path = path;
			_pathOffset = pathOffset;
			_waitTime = unitTime;
			_ownPath = _path.offset(_pathOffset);
		}

		public function start():void {
			if(!_moving){
				_position = CoordUtil.pointToVector(_ownPath.points[0]);
				_moving = true;
				_targetIndex = 1;
				updateTarget();
			}
		}

		private function updateTarget():void {
			if(_targetIndex < _ownPath.points.length){
				_target = CoordUtil.pointToVector(_ownPath.points[_targetIndex]);
			}
		}

		override public function update(updatePool:UpdatePool):Vector.<Callback> {
			var callbacks:Vector.<Callback> = super.update(updatePool);

			if(_alive){
				updateWaiting(updatePool);

				if(moving){
					if(_targetIndex >= _ownPath.points.length){
						callbacks.push(new RemoveActorCallback(this));
						_moving = false;
					} else {
						updateMovement(updatePool.elapsedTime, _target.subtract(_position));
					}
				}
			} else {
				callbacks.push(new RemoveActorCallback(this));
				callbacks.push(new AddMoneyCallback(_price));
			}
			return callbacks;
		}


		override protected function updateMovement(elapsedTime:int, direction:Vector3D):void {
			super.updateMovement(elapsedTime, direction);
			if (GeometryUtil.calcDistance(_position, _target) <= 10) {
				_targetIndex++;
				updateTarget();
			}

			var newRotation:Number = GeometryUtil.calcVectorAngle(direction);
			_rotation = GeometryUtil.radsToDegree(newRotation);
		}

		private function updateWaiting(updatePool:UpdatePool):void {
			if (_waitTime >= 0) {
				_waitTime -= updatePool.elapsedTime;
				if (_waitTime < 0) {
					start();
				}
			}
		}

		public function get type():UnitType {
			return _type;
		}

		public function get alive():Boolean {
			return _alive;
		}

		public function get moving():Boolean {
			return _moving;
		}

		public function get rotation():Number {
			return _rotation;
		}

		public function set health(health:int):void {
			_health = health;
			if(_health < 0){
				_alive = false;
			}
		}

		public function get health():int {
			return _health;
		}

		public function config(config:UnitConfig):void {
			_maxHealth = _health = config.health;
			_speed = config.speed;
			_physicalResistance = config.physicalResistance;
			_magicResistance = config.magicResistance;
			_height = config.height;
			_price = config.price;
		}

		public function damage(damage:Number, damageType:DamageType):void {
			var resultDamage:Number = damage * (1 - (damageType == DamageType.MAGIC ? _magicResistance : _physicalResistance));
			health -= resultDamage;
		}

		public function get height():Number {
			return _height;
		}
	}
}
