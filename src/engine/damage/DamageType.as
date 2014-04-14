package engine.damage {
	import framework.enums.BaseEnum;

	public class DamageType extends BaseEnum{
		private static var _allTypes:Vector.<DamageType> = new <DamageType>[];

		public static const PHYSICAL:DamageType = new DamageType("physical");
		public static const MAGIC:DamageType = new DamageType("magic");

		public function DamageType(name:String){
			super(name);

			_allTypes.push(this);
		}

		public static function getTypeByName(name:String):DamageType {
			var result:DamageType;
			for each(var damageType:DamageType in _allTypes){
				if(damageType.name == name){
					result = damageType;
					break;
				}
			}
			return result;
		}
	}
}
