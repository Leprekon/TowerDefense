package engine.config {
	import engine.actors.moving.units.UnitType;
	import engine.actors.towers.TowerType;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class GameConfig extends EventDispatcher{
		private var _unitConfigs:Vector.<UnitConfig>;
		private var _towerConfigs:Vector.<TowerConfig>;

		public function GameConfig() {
		}

		public function loadConfig():void {
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, handleConfigLoadComplete);
			urlLoader.load(new URLRequest("../GameConfig.xml"));
		}

		private function handleConfigLoadComplete(event:Event):void {
			var config:XML = XML(event.target.data);
			parseConfig(config);
		}

		private function parseConfig(config:XML):void {
			_unitConfigs = new Vector.<UnitConfig>();
			for each(var unitXml:XML in config.units[0].unit){
				var unitConfig:UnitConfig = new UnitConfig();
				unitConfig.fromXML(unitXml);
				_unitConfigs.push(unitConfig);
			}

			_towerConfigs = new Vector.<TowerConfig>();
			for each(var towerXml:XML in config.towers[0].tower){
				var towerConfig:TowerConfig = new TowerConfig();
				towerConfig.fromXML(towerXml);
				_towerConfigs.push(towerConfig);
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function getUnit(unitType:UnitType):UnitConfig {
			var result:UnitConfig;
			for each(var unitConfig:UnitConfig in _unitConfigs){
				if(unitConfig.type == unitType){
					result = unitConfig;
					break;
				}
			}
			return result;
		}

		public function getTower(towerType:TowerType):TowerConfig {
			var result:TowerConfig;
			for each(var towerConfig:TowerConfig in _towerConfigs){
				if(towerConfig.type == towerType){
					result = towerConfig;
					break;
				}
			}
			return result;
		}
	}
}
