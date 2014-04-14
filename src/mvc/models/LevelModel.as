package mvc.models {
	import away3d.loaders.parsers.Parsers;

	import engine.actors.construction.Construction;

	import engine.actors.moving.units.UnitType;
	import engine.level.Level;
	import engine.level.Path;
	import engine.level.UnitGroup;
	import engine.level.Wave;

	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import mvc.BaseModel;
	import mvc.events.LevelModelEvent;

	public class LevelModel extends BaseModel {
		private var _currentLevelName:String;

		public function LevelModel() {
			super();
		}

		public function loadLevel(name:String):void {
			_currentLevelName = name;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, handleConfigLoadComplete);
			urlLoader.load(new URLRequest("../Levels/" + name + "/config.xml"));
		}

		private function handleConfigLoadComplete(event:Event):void {
			var config:XML = XML(event.target.data);
			parseConfig(config);
		}

		private function parseConfig(config:XML):void {
			var level:Level = new Level();
			level.groundAssetName = "../Levels/" + _currentLevelName + "/" + config.@ground[0];
			for each(var pathConfig:XML in config.path){
				var path:Path = parsePath(pathConfig);
				level.addPath(path);
			}
			for each(var waveConfig:XML in config.wave){
				var wave:Wave = parseWave(waveConfig, level.paths);
				level.addWave(wave);
			}

			for each(var constructionConfig:XML in config.towers.construction){
				var construction:Point = parseConstruction(constructionConfig);
				level.addConstruction(construction);
			}

			dispatchEvent(new LevelModelEvent(LevelModelEvent.LEVEL_LOADED, level));
		}

		private function parseConstruction(constructionConfig:XML):Point {
			var construction:Point = new Point(constructionConfig.@x[0], constructionConfig.@y[0]);
			return construction;
		}

		private function parsePath(pathConfig:XML):Path {
			var path:Path = new Path();
			path.name = pathConfig.@name[0];
			for each(var pointConfig:XML in pathConfig.point){
				path.addPoint(Number(pointConfig.@x[0]), Number(pointConfig.@y[0]));
			}
			return path;
		}

		private function parseWave(waveConfig:XML, paths:Vector.<Path>):Wave {
			var wave:Wave = new Wave();
			wave.id = int(waveConfig.@id[0]);
			for each(var groupConfig:XML in waveConfig.group){
				wave.addUnitGroup(parseGroup(groupConfig));
			}
			var pathName:String = waveConfig.@path[0];
			for each(var path:Path in paths){
				if(path.name == pathName){
					wave.path = path;
					break;
				}
			}

			return wave;
		}

		private function parseGroup(groupConfig:XML):UnitGroup {
			var unitGroup:UnitGroup = new UnitGroup();
			unitGroup.unitType = UnitType.getTypeById(int(groupConfig.@id[0]))
			unitGroup.count = int(groupConfig.@count[0]);
			unitGroup.startTime = int(groupConfig.@startTime[0]);
			unitGroup.endTime = int(groupConfig.@endTime[0]);
			return unitGroup;
		}
	}
}
