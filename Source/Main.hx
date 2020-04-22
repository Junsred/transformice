package;

import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2Fixture;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2BodyDef;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import openfl.events.KeyboardEvent;
import lime.ui.Gamepad;
import lime.ui.GamepadButton;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

class Main extends Sprite
{
	private var mices = new List<Mice>();
	public function new()
	{
		super();
		var world = new B2World(new B2Vec2 (0, 10.0), true);
		var worldScale = 30;
    
		var body = new B2BodyDef();
		body.position.set (250 / worldScale, 200 / worldScale);
		body.type = DYNAMIC_BODY;
			
		var circle = new B2CircleShape (10 / worldScale);
		var fixture = new B2FixtureDef();
		fixture.shape = circle;
			
		var player = world.createBody (body);
		player.createFixture (fixture);

		var mice = createMice();
		var player = new Player(mice);
		mice.x = 100;
		mice.y = 100;
		mice.setFurColor(0xf00000);
		mice = createMice();
		mice.x = 200;
		mice.y = 200;
		mice.setFur(21);
		mice = createMice();
		mice.x = 200;
		mice.y = 200;
		mice.setFur(20);
		mice = createMice();
		mice.x = 100;
		mice.y = 200;
		mice.setFur(21);
		mice = createMice();
		mice.x = 150;
		mice.y = 200;
		mice.setFur(23);
		mice = createMice();
		mice.x = 250;
		mice.y = 200;
		mice.setFur(24);

		stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, player.stage_onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, player.stage_onKeyUp);

		Gamepad.onConnect.add(gamepad_onConnect);

		for (gamepad in Gamepad.devices)
		{
			gamepad_onConnect(gamepad);
		}
	}

	private function createMice() {
		var mice = new Mice();
		mices.add(mice);
		return mice;
	}

	private function gamepad_onButtonDown(button:GamepadButton):Void
	{
	}

	private function gamepad_onButtonUp(button:GamepadButton):Void
	{
	}

	private function gamepad_onConnect(gamepad:Gamepad):Void
	{
		gamepad.onButtonDown.add(gamepad_onButtonDown);
		gamepad.onButtonUp.add(gamepad_onButtonUp);
	}

	private function stage_onMouseDown(event:MouseEvent):Void
	{
	}

	private function stage_onMouseUp(event:MouseEvent):Void
	{
	}
}
