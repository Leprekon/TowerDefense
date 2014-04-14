package engine3d {
	import away3d.events.MouseEvent3D;

	import canvas.canvas3d.Canvas3d;

	import engine.actors.Actor;
	import engine.level.Level;

	import engine3d.actors.Actor3D;
	import engine3d.actors.projectiles.Projectile3D;
	import engine3d.debug.DebugLevel3D;
	import engine3d.events.Engine3DEvent;
	import engine3d.fabric.ActorsFabric;
	import engine3d.level.Level3D;
	import engine3d.level.Level3DEvent;

	import flash.events.EventDispatcher;

	import flash.geom.Vector3D;

	import framework.events.TimelineEvent;
	import framework.timeline.Timeline;

	public class Engine3D extends EventDispatcher{
		private var _level3D:Level3D;
		private var _debugLevel3D:DebugLevel3D;
		private var _canvas3d:Canvas3d;
		private var _debug:Boolean = false;
		private var _actors3d:Vector.<Actor3D> = new <Actor3D>[];
		private var _actorsFabric:ActorsFabric;
		private var _timeline:Timeline;

		public function Engine3D(canvas3d:Canvas3d) {
			_canvas3d = canvas3d;

			_debugLevel3D = new DebugLevel3D();
			_level3D = new Level3D();
			_actorsFabric = ActorsFabric.instance;
			init();
		}

		private function init():void {
			_timeline = new Timeline();
			_timeline.interval = 50;
			_timeline.addEventListener(TimelineEvent.UPDATE, handleTimelineUpdate);

			_level3D.addEventListener(Level3DEvent.CLICK_GROUND, handleClickGround);
			_level3D.addEventListener(Level3DEvent.LEVEL_CREATED, handleLevelCreated);
		}

		private function handleLevelCreated(event:Level3DEvent):void {
			_canvas3d.updateMaterials(_level3D);
		}

		private function handleClickGround(event:Level3DEvent):void {
			dispatchEvent(new Engine3DEvent(Engine3DEvent.CLICK_GROUND, event.data));
		}

		public function initLevel(level:Level):void {
			_canvas3d.camera.position = new Vector3D(1100, 1873.492, -1073.406);
			_canvas3d.camera.lookAt(new Vector3D(1100, 0, 800));

			_debugLevel3D.initLevel(level);
			_level3D.initLevel(level);
		}

		private function handleTimelineUpdate(event:TimelineEvent):void {
			updateAnimations(event.elapsedTime);
		}

		private function updateAnimations(elapsedTime:int):void {
			for each(var actor3d:Actor3D in _actors3d){
				actor3d.updateAnimation(elapsedTime);
			}
		}

		public function start():void{
			_canvas3d.addModel(_level3D);
			_canvas3d.addModel(_debugLevel3D);
			_timeline.start();

			updateDebug();
		}

		public function get debug():Boolean {
			return _debug;
		}

		public function set debug(value:Boolean):void {
			_debug = value;
			updateDebug();
		}

		private function updateDebug():void {
			_debugLevel3D.visible = _debug;
		}

		public function stop():void {
			_canvas3d.removeModel(_level3D);
			_canvas3d.removeModel(_level3D);
			_timeline.stop();
		}

		public function update(actors:Vector.<Actor>):void {
			updateActorsList(actors);
			updateActors(actors);
		}

		private function updateActors(actors:Vector.<Actor>):void {
			for each(var actor:Actor in actors){
				for each(var actor3d:Actor3D in _actors3d){
					if(actor.id == actor3d.actorId){
						actor3d.update(actor);
					}
				}
			}
		}

		private function updateActorsList(actors:Vector.<Actor>):void {
			var newActorList:Vector.<Actor3D> = createNewActorList(actors);
			removeRedundantActors(newActorList);
			_actors3d = newActorList;
		}

		private function removeRedundantActors(newActorList:Vector.<Actor3D>):void {
			for each(var actor3d:Actor3D in _actors3d) {
				var exist:Boolean = false;
				for each(var newActor:Actor3D in newActorList) {
					if (actor3d.actorId == newActor.actorId) {
						exist = true;
						break;
					}
				}
				if (!exist) {
					removeActor(actor3d);
				}
			}
		}

		private function removeActor(actor3d:Actor3D):void {
			_level3D.removeChild(actor3d);
		}

		private function createNewActor(actor:Actor):Actor3D {
			var actor3D:Actor3D = _actorsFabric.createActor(actor);
			_level3D.addChild(actor3D);
			if(!(actor3D is Projectile3D)){
				_canvas3d.updateMaterials(actor3D);
				actor3D.addEventListener(MouseEvent3D.CLICK, handleClickActor);
			}
			return actor3D;
		}

		private function handleClickActor(event:MouseEvent3D):void {
			dispatchEvent(new Engine3DEvent(Engine3DEvent.CLICK_ACTOR, event.currentTarget));
		}

		private function createNewActorList(actors:Vector.<Actor>):Vector.<Actor3D> {
			var newActors:Vector.<Actor3D> = new <Actor3D>[];
			for each(var actor:Actor in actors) {
				var exist:Boolean = false;
				for each(var actor3d:Actor3D in _actors3d) {
					if (actor3d.actorId == actor.id) {
						newActors.push(actor3d);
						exist = true;
						break;
					}
				}
				if (!exist) {
					var actor3D:Actor3D = createNewActor(actor);
					newActors.push(actor3D);
				}
			}
			return newActors;
		}
	}
}
