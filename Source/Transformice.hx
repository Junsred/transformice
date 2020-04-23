package;

import box2D.dynamics.B2Body;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2BodyDef;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.StageQuality;
import flash.events.MouseEvent;

class Transformice extends Sprite
{

	public static var instance: Transformice;

	public var mices = new List<Mice>();
	public var physicWorld: B2World;
	public var player: Player;
	public var timeZero:Float;
	public var calculatedImages:Float;

	public function new()
	{
		super();
		this.timeZero = flash.Lib.getTimer();
		stage.quality = StageQuality.HIGH;
		this.physicWorld = new B2World(new B2Vec2(0, 10), true);
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
		boxFixture.friction = 0.3;
		boxFixture.restitution = 0.2;
		boxFixture.shape = boxShape;
		var body: B2Body = this.physicWorld.createBody(bodyDef);
		body.createFixture(boxFixture);
		this.physicWorld.drawDebugData();
		var mice = createMice(100, 100);
		this.player = new Player(mice);
		

		stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		stage.addEventListener(MouseEvent.CLICK, stage_onMouseClick);
		stage.addEventListener(Event.RESIZE, resizeDisplay);
	}

	private function createMice(x: Float, y: Float) {
		var mice = new Mice(x, y);
		mices.add(mice);
		return mice;
	}

	private function stage_onFrameEnter(event: Event): Void 
	{

		var _loc55_ = flash.Lib.getTimer() - this.timeZero;
        var _loc56_ = _loc55_ / 33.33;
        var _loc57_ = _loc56_ - this.calculatedImages;
		if(_loc57_ > 50)
		{
		   _loc57_ = 50;
		}
		var _loc29_ = 0;
		while(_loc29_ < _loc57_) {
			//migth be 1.0/30.0 not sure 60.0 feels like tfm?
			this.physicWorld.step(1.0/60.0, 10, 1);
			_loc29_++;
		}
		this.calculatedImages = _loc56_;
		this.physicWorld.drawDebugData();

	}

	private function resizeDisplay(event: Event) {

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

	private function stage_onMouseDown(event:MouseEvent):Void
	{
	}

	private function stage_onMouseUp(event:MouseEvent):Void
	{
	}
	
	private function stage_onMouseClick(event:MouseEvent):Void
	{
		//var mice = createMice(event.localX, event.localY);
		//player.mice = mice;
	}
}
