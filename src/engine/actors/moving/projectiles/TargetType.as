package engine.actors.moving.projectiles {
	import engine.damage.*;
	import framework.enums.BaseEnum;

	public class TargetType extends BaseEnum{
		private static var _allTypes:Vector.<TargetType> = new <TargetType>[];

		public static const UNIT:TargetType = new TargetType("unit");
		public static const GROUND:TargetType = new TargetType("ground");

		public function TargetType(name:String){
			super(name);

			_allTypes.push(this);
		}

		public static function getTypeByName(name:String):TargetType {
			var result:TargetType;
			for each(var type:TargetType in _allTypes){
				if(type.name == name){
					result = type;
					break;
				}
			}
			return result;
		}
	}
}
