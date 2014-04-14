package engine.actors.moving.units {
	import framework.enums.BaseType;

	public class UnitType extends BaseType{
		private static var _allTypes:Vector.<UnitType> = new <UnitType>[]

		public static const VILLAGER:UnitType = new UnitType(0, "villager")
		public static const MILITIA:UnitType = new UnitType(1, "militia")

		public function UnitType(id:int, name:String) {
			super(id, name);

			_allTypes.push(this);
		}

		public static function getTypeById(id:int):UnitType {
			var result:UnitType;
			for each(var type:UnitType in _allTypes){
				if(type.id == id){
					result = type;
					break;
				}
			}
			return result;
		}

		public static function getTypeByName(name:String):UnitType {
			var result:UnitType;
			for each(var type:UnitType in _allTypes){
				if(type.name == name){
					result = type;
					break;
				}
			}
			return result;
		}
	}
}
