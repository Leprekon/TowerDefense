package engine {
	import engine.actors.Actor;
	import engine.actors.construction.Construction;
	import engine.actors.moving.units.UnitType;
	import engine.actors.towers.Tower;
	import engine.actors.towers.TowerType;
	import engine.actors.moving.units.Unit;
	import engine.callbacks.Callback;
	import engine.config.TowerConfig;
	import engine.config.UnitConfig;
	import engine.events.GameEngineEvent;
	import engine.level.Level;
	import engine.level.UnitGroup;
	import engine.level.Wave;

	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	import framework.events.TimelineEvent;
	import framework.timeline.Timeline;

	import mvc.Facade;

	import settings.GameSettings;

	public class GameEngine extends EventDispatcher{
		private var _level:Level;

		private var _actors:Vector.<Actor>;
		private var _currentWave:Wave;
		private var _updatePool:UpdatePool;
		private var _timeline:Timeline;
		private var _money:int = 100;

		public function GameEngine() {
			_updatePool = new UpdatePool();

			_timeline = new Timeline();
			_timeline.interval = 50;
			_timeline.addEventListener(TimelineEvent.UPDATE, handleTimelineUpdate);
		}

		public function startLevel(level:Level):void {
			_level = level;
			_actors = new <Actor>[];

			createConstructions(level.constructions);
			startWave(level.getWave(0));
			_updatePool.reset();
		}

		private function createConstructions(constructions:Vector.<Point>):void {
			for each(var constructionPosition:Point in constructions){
				var construction:Construction = new Construction(_updatePool.idGenerator.generate());
				construction.position.x = constructionPosition.x;
				construction.position.z = constructionPosition.y;
				_actors.push(construction);
			}
		}

		public function start():void {
			_timeline.start();
		}

		public function stop():void {
			_timeline.stop();
		}

		private function handleTimelineUpdate(event:TimelineEvent):void {
			update();
			dispatchEvent(new GameEngineEvent(GameEngineEvent.UPDATED));
		}

		public function update():void {
			_updatePool.update(_actors);

			var callbacks:Vector.<Callback> = new <Callback>[];
			for each(var actor:Actor in _actors){
				callbacks = callbacks.concat(actor.update(_updatePool));
			}
			processCallbacks(callbacks);
		}

		private function processCallbacks(callbacks:Vector.<Callback>):void {
			for each(var callback:Callback in callbacks){
				callback.implement(this);
			}
		}

		public function startWave(wave:Wave):void {
			_currentWave = wave;
			for each(var unitGroup:UnitGroup in wave.unitGroups){
				for(var i:int = 0; i < unitGroup.count; i++){
					var waitTime:int = unitGroup.startTime + i * (unitGroup.endTime - unitGroup.startTime) / unitGroup.count;
					var unit:Unit = createUnit(unitGroup, wave, waitTime);
					addActor(unit);
				}
			}
		}

		private function createUnit(unitGroup:UnitGroup, wave:Wave, waitTime:int):Unit {
			var pathOffset:Number = (Math.random() * 2 - 1) * GameSettings.PATH_MAX_OFFSET ;
			var unit:Unit = new Unit(_updatePool.idGenerator.generate(), unitGroup.unitType, wave.path, pathOffset, waitTime);
			unit.config(Facade.config.getUnit(unitGroup.unitType));
			return unit;
		}

		public function get actors():Vector.<Actor> {
			return _actors;
		}

		public function createTower(type:TowerType, constructionId:int):void {
			var actor:Actor = getActorById(constructionId);
			var towerConfig:TowerConfig = Facade.config.getTower(type);
			if(towerConfig.price <= _money){
				if(actor is Construction){
					var tower:Tower = new Tower(_updatePool.idGenerator.generate(), type);
					tower.position = actor.position.clone();
					tower.config(towerConfig);
					_money -= towerConfig.price;
					addActor(tower);
					removeActor(actor);
				}
			}
		}

		private function getActorById(actorId:int):Actor {
			var result:Actor;
			for each(var actor:Actor in _actors){
				if(actor.id == actorId){
					result = actor;
					break;
				}
			}
			return result;
		}

		public function addActor(actor:Actor):void {
			_actors.push(actor);
		}

		public function removeActor(actor:Actor):void {
			_actors.splice(_actors.indexOf(actor), 1);
		}

		public function set money(money:int):void {
			_money = money;
		}

		public function get money():int {
			return _money;
		}
	}
}
