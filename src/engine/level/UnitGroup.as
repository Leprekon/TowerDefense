package engine.level {
	import engine.actors.moving.units.UnitType;

	public class UnitGroup {
		private var _unitType:UnitType;
		private var _count:int;
		private var _startTime:int;
		private var _endTime:int;

		public function UnitGroup() {
		}

		public function set unitType(unitType:UnitType):void {
			_unitType = unitType;
		}

		public function set count(count:int):void {
			_count = count;
		}

		public function set startTime(startTime:int):void {
			_startTime = startTime;
		}

		public function set endTime(endTime:int):void {
			_endTime = endTime;
		}

		public function get unitType():UnitType {
			return _unitType;
		}

		public function get count():int {
			return _count;
		}

		public function get startTime():int {
			return _startTime;
		}

		public function get endTime():int {
			return _endTime;
		}
	}
}
