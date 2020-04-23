import flash.events.KeyboardEvent;

class Player 
{
    public var mice:Mice;

    public function new(mice) {
        this.mice = mice;
        Transformice.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		Transformice.instance.stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
    }

    private function stage_onKeyDown(event:KeyboardEvent):Void {
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

    private function stage_onKeyUp(event:KeyboardEvent):Void {
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