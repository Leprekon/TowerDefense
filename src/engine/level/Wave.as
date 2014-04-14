package engine.level {
	public class Wave {
		private var _unitGroups:Vector.<UnitGroup> = new <UnitGroup>[];
		private var _path:Path;
		private var _id:int;

		public function Wave() {
		}

		public function addUnitGroup(unitGroup:UnitGroup):void {
			_unitGroups.push(unitGroup);
		}

		public function set path(path:Path):void {
			_path = path;
		}

		public function get unitGroups():Vector.<UnitGroup> {
			return _unitGroups;
		}

		public function get path():Path {
			return _path;
		}

		public function set id(id:int):void {
			_id = id;
		}

		public function get id():int {
			return _id;
		}
	}
}
