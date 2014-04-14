package engine.level {
	import flash.geom.Point;

	import framework.utils.GeometryUtil;

	public class Path {
		private var _points:Vector.<Point>;
		private var _name:String;

		public function Path() {
			_points = new Vector.<Point>();
		}

		public function addPoint(x:Number, y:Number):void {
			_points.push(new Point(x, y))
		}

		public function get points():Vector.<Point> {
			return _points;
		}

		public function set name(name:String):void {
			_name = name;
		}

		public function get name():String {
			return _name;
		}

		public function offset(value:Number):Path{
			var offsetPath:Path = new Path();
			var lastPoint:Point = points[0];
			var curPoint:Point = points[1];
			var lastDirection:Point = curPoint.subtract(lastPoint);
			var offset:Point = GeometryUtil.rotatePoint(lastDirection, Math.PI / 2);
			offset.normalize(value);
			var point:Point = lastPoint.add(offset);
			offsetPath.addPoint(point.x, point.y);

			for(var i:int = 1; i < points.length - 1; i++){
				curPoint = points[i];
				var nextPoint:Point = points[i + 1];
				var newDirection:Point = nextPoint.subtract(curPoint);
				var newOffset:Point = GeometryUtil.rotatePoint(newDirection, Math.PI / 2);
				newOffset.normalize(value);
				point = GeometryUtil.lineIntersectLine(lastPoint.add(offset), curPoint.add(offset), curPoint.add(newOffset), nextPoint.add(newOffset));
				if(point != null){
					offsetPath.addPoint(point.x, point.y);
					offset = newOffset;
					lastPoint = curPoint;
					lastDirection = newDirection;
				}
			}

			point = nextPoint.add(newOffset);
			offsetPath.addPoint(point.x, point.y);
			return offsetPath;
		}
	}
}
