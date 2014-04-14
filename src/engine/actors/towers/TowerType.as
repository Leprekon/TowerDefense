package engine.actors.towers {
	import framework.enums.BaseType;

	public class TowerType extends BaseType{
		private static var _allTypes:Vector.<TowerType> = new <TowerType>[];

		public static const TEST_TOWER:TowerType = new TowerType(0, "testTower");

		public function TowerType(id:int, name:String) {
			super(id, name);

			_allTypes.push(this);
		}

		public static function getTypeById(id:int):TowerType {
			var result:TowerType;
			for each(var type:TowerType in _allTypes){
				if(type.id == id){
					result = type;
					break;
				}
			}
			return result;
		}

		public static function getTypeByName(name:String):TowerType {
			var result:TowerType;
			for each(var type:TowerType in _allTypes){
				if(type.name == name){
					result = type;
					break;
				}
			}
			return result;
		}
	}
}
