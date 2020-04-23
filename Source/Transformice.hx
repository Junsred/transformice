package;

import box2D.dynamics.contacts.B2CircleContact;
import openfl.events.Event;
import box2D.dynamics.B2Body;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2Shape;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2Fixture;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2BodyDef;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import lime.ui.Gamepad;
import lime.ui.GamepadButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;

class Transformice extends Sprite
{

	public static var instance: Transformice;

	public var mices = new List<Mice>();
	public var physicWorld: B2World = new B2World(new B2Vec2(0, 10), true);
	public var player: Player;

	public function new()
	{
		super();
		Transformice.instance = this;
		this.addEventListener(Event.ENTER_FRAME, this.stage_onFrameEnter);
		var dbgDraw:B2DebugDraw = new B2DebugDraw();
		var dbgSprite:Sprite = new Sprite();
		addChild(dbgSprite);
		dbgDraw.setSprite(dbgSprite);
		dbgDraw.setDrawScale(30.0);
		dbgDraw.setFillAlpha(0.5);
		dbgDraw.setLineThickness(2.0);
		dbgDraw.setFlags(B2DebugDraw.e_shapeBit | B2DebugDraw.e_jointBit);
		this.physicWorld.setDebugDraw(dbgDraw);
		var bodyDef: B2BodyDef;
		var boxShape: B2PolygonShape;
		var boxFixture: B2FixtureDef;
		bodyDef = new B2BodyDef();
		bodyDef.position.set(10, 12);
		boxShape = new B2PolygonShape();
		boxFixture = new B2FixtureDef();
		boxShape.setAsBox(30, 3);
		boxFixture.density = 0.2;a
		boxFixture.friction = 0.3;
		boxFixture.shape = boxShape;
		var body: B2Body = this.physicWorld.createBody(bodyDef);
		body.createFixture(boxFixture);
		this.physicWorld.drawDebugData();
		var mice = createMice(100, 100);
		this.player = new Player(mice);
		

		stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		stage.addEventListener(MouseEvent.CLICK, stage_onMouseClick);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, this.player.stage_onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, this.player.stage_onKeyUp);

		Gamepad.onConnect.add(gamepad_onConnect);

		for (gamepad in Gamepad.devices)
		{
			gamepad_onConnect(gamepad);
		}
	}

	private function createMice(x: Float, y: Float) {
		var mice = new Mice(x, y);
		mices.add(mice);
		return mice;
	}

	private function stage_onFrameEnter(event: Event): Void 
	{
		this.physicWorld.step(1.0/30.0, 10, 10);
		this.physicWorld.drawDebugData();

	}

	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):Void {
 
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * 30, y * 30);
	 
		if (dynamicBody) {
	 
			bodyDefinition.type = B2Body.b2_dynamicBody;
	 
		}
	 
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * 30, (height / 2) * 30);
	 
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
	 
		var body = this.physicWorld.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
	 
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
	
	private function stage_onMouseClick(event:MouseEvent):Void
	{
		var mice = createMice(event.localX, event.localY);
		player.mice = mice;
	}
}
