package;

import box2D.collision.shapes.B2MassData;
import openfl.display.MovieClip;
import box2D.dynamics.B2Body;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2BodyDef;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import flash.events.Event;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.Lib;

class Transformice extends Sprite
{

	public static var instance: Transformice;

	public var physicWorld:B2World;
	public var world:MovieClip;
	public var player:Player;
	public var lastFrameTime:Float = 0;
	public var playableFrames:Float = 0;
	public var passedTime:Float = 0;

	public function new()
	{
		super();
		stage.frameRate = 60;
		Transformice.instance = this;
		
		this.physicWorld = new B2World(new B2Vec2(0, 10), true);
		this.world = new MovieClip();
		this.world.x = Lib.application.window.width/2-400;
		this.world.y = Lib.application.window.height/2-300;
		this.world.mouseEnabled = true;
		stage.addChild(this.world);

		this.addEventListener(Event.ENTER_FRAME, this.stage_onFrameEnter);


		var dbgDraw:B2DebugDraw = new B2DebugDraw();
		var dbgSprite:Sprite = new Sprite();
		this.world.addChild(dbgSprite);
		dbgDraw.setSprite(dbgSprite);
		dbgDraw.setDrawScale(30);
		dbgDraw.setFillAlpha(0.5);
		dbgDraw.setLineThickness(2.0);
		dbgDraw.setFlags(B2DebugDraw.e_shapeBit | B2DebugDraw.e_jointBit | B2DebugDraw.e_pairBit);
		this.physicWorld.setDebugDraw(dbgDraw);

		this.createGround(400, 385, 800, 30);
		this.createGround(400, 235, 75, 300);

		var mice = createMice(0, 0);
	    this.player = new Player(mice);
		

		stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		stage.addEventListener(MouseEvent.CLICK, stage_onMouseClick);
		stage.addEventListener(Event.RESIZE, resizeDisplay);
	}

	private function createMice(x: Float, y: Float) {
		return new Mice(x, y);
	}

	private function stage_onFrameEnter(event: Event): Void 
	{
		var difference:Float = flash.Lib.getTimer() - lastFrameTime;
		if(false) {
			if(difference > 2000)
			{
				difference = 2000;
			}
		} else if(difference > 500) {
			difference = 500;
		}
		var sec:Float = difference / 1000;
		lastFrameTime = flash.Lib.getTimer();
		playableFrames += sec;
		this.passedTime += sec;
		var rate = 1/30;
		while(playableFrames > rate) {
			playableFrames = playableFrames - rate;
			this.physicWorld.step(rate, 10, 10);
			var body:B2Body = this.physicWorld.getBodyList();
			while(body != null) {
				if (body.m_xf.position.x > 50 || body.m_xf.position.y > 50) {
					this.physicWorld.destroyBody(body);
				}
				var mice = cast(body.getUserData(), Mice);
				if(mice != null) {
					mice.x = body.m_xf.position.x * 30;
					mice.y = body.m_xf.position.y * 30;
					if (mice.runningLeft || mice.runningRight) {
						if (mice.turnedRight) {
							if (body.m_linearVelocity.x < 3) {
								body.m_linearVelocity.x += 0.5;
							}
						} else {
							if (-3 < body.m_linearVelocity.x) {
								body.m_linearVelocity.x -= 0.5;
							}
						}
						mice.lastMovement = flash.Lib.getTimer();
					} else if (flash.Lib.getTimer() - mice.lastMovement < 200) {
						if(body.m_linearVelocity.x < 3 - 0.5 || -(3 + 0.5) < body.m_linearVelocity.x)
							{
								body.m_linearVelocity.x = body.m_linearVelocity.x / 1.2;
							}
					}
				}
				body = body.m_next;
			}
		}

		if (player.mice.jumping) {
			if (player.mice.lastYVelocity > 0) {
				if(player.mice.lastYVelocity > player.mice.physics.m_linearVelocity.y) {
					player.mice.lastYVelocity = -1;
					this.player.jumpAvailableTime = flash.Lib.getTimer();
					player.mice.stopJump();
				} else {
					player.mice.lastYVelocity = player.mice.physics.m_linearVelocity.y;
				}
			} else {
				player.mice.lastYVelocity = player.mice.physics.m_linearVelocity.y;
			}
		}
		//this.physicWorld.drawDebugData();

	}


	/**
	* Center the world
	*/
	private function resizeDisplay(event: Event) {
		this.world.x = Lib.application.window.width/2-400;
		this.world.y = Lib.application.window.height/2-300;
	}


	/**
	* Generate ground
	*/
	public function createGround(x:Int, y:Int, width:Int, height:Int, friction:Float=0.3, restitution:Float=0.2, rotation:Int=0, dynamicBody:Bool=false, mass:Int=0, fixedRotation:Bool=false, linearDamping:Int=0, angularDamping:Int=0):Void {
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x / 30, y / 30);
		bodyDefinition.angle = rotation;
		bodyDefinition.fixedRotation = fixedRotation;
		bodyDefinition.linearDamping = linearDamping;
		bodyDefinition.angularDamping = angularDamping;
	 
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) / 30, (height / 2) / 30);
	 
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.friction = friction;
		fixtureDefinition.restitution = restitution;
		fixtureDefinition.shape = polygon;
	 
		var body = this.physicWorld.createBody (bodyDefinition);
		if (dynamicBody) {
			bodyDefinition.type = B2Body.b2_dynamicBody;
			var massData = new B2MassData();
			massData.mass = mass;
			body.setMassData(massData);
		}
		body.createFixture (fixtureDefinition);
		this.physicWorld.drawDebugData();
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
