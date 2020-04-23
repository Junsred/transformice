import openfl.display.Sprite;
import box2D.dynamics.B2Body;
import openfl.events.KeyboardEvent;

class Player 
{
    public var mice:Mice;

    public function new(mice) {
        this.mice = mice;
    }

    public function stage_onKeyDown(event:KeyboardEvent):Void {
        if (event.keyCode == 65 || event.keyCode == 37) {
            this.mice.runLeft();
        } else if (event.keyCode == 68 || event.keyCode == 39) {
            this.mice.runRight();
        } else if (event.keyCode == 83 || event.keyCode == 40) {
			this.mice.duck();
        } else if (event.keyCode == 87 || event.keyCode == 38) {
            this.mice.jump();
        }
    };

    public function stage_onKeyUp(event:KeyboardEvent):Void {
        if (event.keyCode == 65 || event.keyCode == 37) {
            if (this.mice.runningLeft) {
                this.mice.stopRun();
            }
        } else if (event.keyCode == 68 || event.keyCode == 39) {
            if (this.mice.runningRight) {
                this.mice.stopRun();
            }
        } else if (event.keyCode == 83 || event.keyCode == 40) {
			this.mice.stopDuck();
        }
	};
}