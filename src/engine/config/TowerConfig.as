package engine.config {
	import engine.actors.moving.projectiles.Projectile;
	import engine.actors.towers.TowerType;

	import framework.interfaces.IXMLConfigurable;

	public class TowerConfig implements IXMLConfigurable{
		private var _id:int;
		private var _type:TowerType;
		private var _price:int;
		private var _radius:int;
		private var _fireRate:Number;
		private var _projectiles:Vector.<ProjectileConfig>;

		public function TowerConfig() {
		}

		public function fromXML(config:XML):void {
			_id = int(config.@id[0]);
			_type = TowerType.getTypeById(_id);
			_price = int(config.@price[0]);
			_radius = int(config.@radius[0]);
			_fireRate = Number(config.@fireRate[0]);

			_projectiles = new Vector.<ProjectileConfig>();
			for each(var projectileXML:XML in config.projectile[0]){
				var projectileConfig:ProjectileConfig = new ProjectileConfig();
				projectileConfig.fromXML(projectileXML);
				_projectiles.push(projectileConfig);
			}
		}

		public function get id():int {
			return _id;
		}

		public function get type():TowerType {
			return _type;
		}

		public function get price():int {
			return _price;
		}

		public function get radius():int {
			return _radius;
		}

		public function get fireRate():Number {
			return _fireRate;
		}

		public function get projectiles():Vector.<ProjectileConfig> {
			return _projectiles;
		}
	}
}
