package engine.actors.moving.projectiles {
	import engine.actors.towers.*;
	import framework.enums.BaseType;

	public class ProjectileType extends BaseType{
		private static var _allTypes:Vector.<ProjectileType> = new <ProjectileType>[];

		public static const TEST:ProjectileType = new ProjectileType(0, "testProjectile");

		public function ProjectileType(id:int, name:String) {
			super(id, name);

			_allTypes.push(this);
		}

		public static function getTypeById(id:int):ProjectileType {
			var result:ProjectileType;
			for each(var type:ProjectileType in _allTypes){
				if(type.id == id){
					result = type;
					break;
				}
			}
			return result;
		}

		public static function getTypeByName(name:String):ProjectileType {
			var result:ProjectileType;
			for each(var type:ProjectileType in _allTypes){
				if(type.name == name){
					result = type;
					break;
				}
			}
			return result;
		}
	}
}
