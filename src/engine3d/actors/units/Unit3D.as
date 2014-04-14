package engine3d.actors.units {
	import away3d.animators.SkeletonAnimator;
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;

	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import engine.actors.Actor;
	import engine.actors.moving.units.Unit;

	import engine3d.actors.Actor3D;

	import framework.utils.StageUtil;

	import settings.GameSettings;

	public class Unit3D extends Actor3D {
		private var _rotationTween:TweenMax;
		public function Unit3D(id:int, asset:ObjectContainer3D) {
			super(id, asset);
			SkeletonAnimator(mesh.animator).autoUpdate = false;
		}

		private function get mesh():Mesh {
			return Mesh(_asset);
		}

		override public function update(actor:Actor):void {
			super.update(actor);

			var unit:Unit = Unit(actor);


			if(rotationY != unit.rotation && (_rotationTween == null || !_rotationTween.active)){
				var newRotation:Number = unit.rotation;
				newRotation += Math.floor(rotationY / (360)) * 360;
				if (rotationY - newRotation > 180) {
					newRotation += 360;
				}
				var tweenTime:Number = Math.abs(rotationY - newRotation) / 180;
				_rotationTween = TweenMax.to(this, tweenTime, {rotationY: newRotation, ease:Linear.easeNone});
			}

			if(unit.moving){
				SkeletonAnimator(mesh.animator).play("move");
			}
		}

		override public function updateAnimation(elapsedTime:int):void {
			super.updateAnimation(elapsedTime);
			if(SkeletonAnimator(mesh.animator).activeAnimation != null){
				var time:int = SkeletonAnimator(mesh.animator).time;
				SkeletonAnimator(mesh.animator).update(time + elapsedTime * GameSettings.ANIMATION_FRAMERATE / StageUtil.fpsMeter.fps);
			}
		}
	}
}
