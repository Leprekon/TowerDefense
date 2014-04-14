package engine3d.fabric {

	public class LoadingAsset {
		private var _key:*;
		private var _data:*;

		public function LoadingAsset(key:*, testUnitClass:*) {
			_key = key;
			_data = testUnitClass;
		}

		public function get key():* {
			return _key;
		}

		public function get data():* {
			return _data;
		}
	}
}
