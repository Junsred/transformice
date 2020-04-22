import openfl.filters.DropShadowFilter;
import openfl.geom.ColorTransform;
import openfl.utils.AssetType;
import js.lib.Map;
import openfl.events.Event;
import openfl.display.MovieClip;
import openfl.Lib;
import openfl.Assets;

class Mice extends MovieClip
{
    public var turnedRight = true;
    public var runningRight = false;
    public var runningLeft = false;
    public var ducking = false;
    public var furColor = 0xdfd8ce;
    public var furId = 1;
    private var animations = new Map<String, MovieClip>();
    public function new() {
        super();
        this.setAnim();
        this.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
        Lib.current.addChild(this);
    }

    public function runLeft() {
        if (!this.runningLeft) {
            this.turnedRight = false;
            this.run();
        }
    }

    public function runRight() {
        if (!this.runningRight) {
            this.turnedRight = true;
            this.run();
        }
    }

    public function stopRun() {
        if (this.runningLeft || this.runningRight) {
            this.runningRight = this.runningLeft = false;
            this.changeAnim();
        }
    }

    public function duck() {
        if (!this.ducking) {
            this.ducking = true;
            this.runningLeft = this.runningRight = false;
            this.changeAnim();
            var clip = this.getCurrentAnimation();
            clip.gotoAndPlay(0);
            clip.addFrameScript(6, () -> {
                clip.stop();
            });
        }
    }

    public function stopDuck() {
        if (this.ducking) {
            this.ducking = false;
            var clip = this.getCurrentAnimation();
            clip.gotoAndPlay(7);
			clip.addFrameScript(10, () -> {
                this.removeChild(clip);
                this.changeAnim();
			});
            clip.play();
        }
    }

    public function setFur(furId:Int) {
        this.furId = furId;
        this.clear();
    }

    public function setFurColor(furColor:Int) {
        this.furColor = furColor;
        this.furId = 1;
        this.clear();
    }

    private function clear() {
        this.animations.clear();
        this.changeAnim();
    }

    private function run() {
        this.runningRight = this.turnedRight;
        this.runningLeft = !this.runningRight;
        this.ducking = false;
        this.changeAnim();
    }

    private function getCurrentAnimation() {
        return cast(this.getChildAt(0), MovieClip);
    }

    private function removeCurrentAnimation() {
        this.removeChildAt(0);
    }

    private function stage_onEnterFrame(event:Event):Void {
        if (this.runningLeft || this.runningRight) {
            if (this.turnedRight) {
                this.x += 1.5;
            } else {
                this.x -= 1.5;
            }
        }
    };

    private function setAnim() {
        var anim = "AnimStatique";
        if (this.runningLeft || this.runningRight) {
            anim = "AnimCourse";
        } else if (this.ducking) {
            anim = "AnimDuck";
        }
        var animation = animations.get(anim);
        if (animation == null) {
            animation = Assets.getMovieClip("animations:"+anim);
            //market colors - bd9067, 593618, 8c887f, dfd8ce, 4e443a, e3c07e, 241f1d
            var library = "resources";
            if (furId != 1)
                library = "furs";
            var assetLibrary = Assets.getLibrary(library);
			for (i in 0...animation.numChildren) {
				var child = cast(animation.getChildAt(i), MovieClip);
				var symbol = "_"+child.name+"_"+furId+"_1";
				if (assetLibrary.exists(symbol, cast AssetType.MOVIE_CLIP)) {
					var asset = Assets.getMovieClip(library+":"+symbol);
					for (i in 0...asset.numChildren) {
						var assetChild = asset.getChildAt(i);
						if (assetChild != null && assetChild.name.charAt(0) == "c") {
							assetChild.transform.colorTransform = new ColorTransform((this.furColor >> 16 & 255) / 128, (this.furColor >> 8 & 255) / 128, (this.furColor & 255) / 128);
						}
					}
					child.addChild(asset);
				}
            }
            animation.filters = [new DropShadowFilter()];
            animations.set(anim, animation);
        }
        if (!this.turnedRight && this.scaleX > 0)
            this.scaleX = -(this.scaleX);
        if (this.turnedRight && this.scaleX < 0)
			this.scaleX = -(this.scaleX);
        this.addChild(animation);
    }

    private function changeAnim() {
        this.removeCurrentAnimation();
        this.setAnim();
    }
}