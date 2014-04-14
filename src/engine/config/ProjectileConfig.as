package engine.config {
	import engine.actors.moving.projectiles.TargetType;
	import engine.damage.DamageType;

	import framework.interfaces.IXMLConfigurable;

	public class ProjectileConfig implements IXMLConfigurable{
		private var _damage:int;
		private var _speed:int;
		private var _explodeRadius:int;
		private var _damageType:DamageType;
		private var _targetType:TargetType;

		public function ProjectileConfig() {
		}

		public function fromXML(config:XML):void {
			_damage = int(config.@damage[0]);
			_speed = int(config.@speed[0]);
			_explodeRadius = int(config.@explodeRadius[0]);
			_damageType = DamageType.getTypeByName(config.@damageType[0]);
			_targetType = TargetType.getTypeByName(config.@targetType[0]);
		}

		public function get damage():int {
			return _damage;
		}

		public function get speed():int {
			return _speed;
		}

		public function get explodeRadius():int {
			return _explodeRadius;
		}

		public function get damageType():DamageType {
			return _damageType;
		}

		public function get targetType():TargetType {
			return _targetType;
		}
	}
}
