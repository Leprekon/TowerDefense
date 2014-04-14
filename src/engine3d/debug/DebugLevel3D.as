package engine3d.debug {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.SegmentSet;
	import away3d.primitives.LineSegment;
	import away3d.primitives.WireframePlane;

	import engine.level.Level;
	import engine.level.Path;

	import flash.geom.Point;

	import framework.utils.CoordUtil;

	import settings.GameSettings;

	public class DebugLevel3D extends ObjectContainer3D{
		private var _grid:WireframePlane;
		private var _paths:ObjectContainer3D;
		public function DebugLevel3D() {
			init();
		}

		private function init():void {
			_grid = new WireframePlane(2200, 2200, 22, 22, 0xDDDD00, 0.5, "xz");
			_grid.x = 1100;
			_grid.z = 800;
			_grid.y = 2;
			addChild(_grid);
			_paths = new ObjectContainer3D();
			addChild(_paths);
		}

		public function initLevel(level:Level):void {
			while(_paths.numChildren > 0){
				_paths.removeChildAt(0);
			}
			for each(var path:Path in level.paths) {
				var color:Number = Math.random() * 0xFFFFFF;
				_paths.addChild(createSegments(path, color));
				_paths.addChild(createSegments(path.offset(GameSettings.PATH_MAX_OFFSET), color));
				_paths.addChild(createSegments(path.offset(-GameSettings.PATH_MAX_OFFSET), color));
			}
		}

		private function createSegments(path:Path, color:int):SegmentSet {
			var segments:SegmentSet = new SegmentSet();
			var lastPoint:Point;
			for each(var point:Point in path.points) {
				if (lastPoint != null) {
					segments.addSegment(new LineSegment(CoordUtil.pointToVector(lastPoint), CoordUtil.pointToVector(point), color, color))
				}
				lastPoint = point;
			}
			segments.y = 2;
			return segments;
		}
	}
}
