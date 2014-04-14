package engine.config {
	import engine.actors.moving.units.UnitType;

	import framework.interfaces.IXMLConfigurable;

	public class UnitConfig implements IXMLConfigurable{
		private var _id:int;
		private var _type:UnitType;
		private var _speed:int;
		private var _health:int;
		private var _physicalResistance:Number;
		private var _magicResistance:Number;
		private var _price:int;
		private var _height:int;

		public function UnitConfig() {
		}

		public function fromXML(config:XML):void {
			_id = int(config.@id[0]);
			_type = UnitType.getTypeById(_id);
			_speed = int(config.@speed[0]);
			_health = int(config.@health[0]);
			_physicalResistance = Number(config.@physicalResistance[0]);
			_magicResistance = Number(config.@magicResistance[0]);
			_price = int(config.@price[0]);
			_height = int(config.@height[0]);
		}

		public function get id():int {
			return _id;
		}

		public function get type():UnitType {
			return _type;
		}

		public function get speed():int {
			return _speed;
		}

		public function get health():int {
			return _health;
		}

		public function get physicalResistance():Number {
			return _physicalResistance;
		}

		public function get magicResistance():Number {
			return _magicResistance;
		}

		public function get price():int {
			return _price;
		}

		public function get height():int {
			return _height;
		}
	}
}
