package engine.level {
	import engine.actors.construction.Construction;

	import flash.geom.Point;

	public class Level {
		private var _paths:Vector.<Path>;
		private var _waves:Vector.<Wave>;
		private var _constructions:Vector.<Point>;
		private var _groundAssetName:String;

		public function Level() {
			_paths = new Vector.<Path>();
			_waves = new <Wave>[];
			_constructions = new <Point>[];
		}

		public function addPath(path:Path):void {
			_paths.push(path);
		}

		public function get paths():Vector.<Path> {
			return _paths;
		}

		public function addWave(wave:Wave):void {
			_waves.push(wave);
		}

		public function getWave(id:int):Wave {
			var result:Wave;
			for each(var wave:Wave in _waves){
				if(wave.id == id){
					result = wave;
					break;
				}
			}
			return result;
		}

		public function set groundAssetName(groundAssetName:String):void {
			_groundAssetName = groundAssetName;
		}

		public function get groundAssetName():String {
			return _groundAssetName;
		}

		public function addConstruction(construction:Point):void {
			_constructions.push(construction);
		}

		public function get constructions():Vector.<Point> {
			return _constructions;
		}
	}
}
