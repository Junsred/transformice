package;

import openfl.display.Shape;
import box2D.collision.shapes.B2MassData;
import box2D.dynamics.B2Body;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2BodyDef;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.Assets;
import flash.Lib;

class Transformice extends Sprite
{

	public static var instance: Transformice;

	public var physicWorld:B2World;
	public var world:Sprite;
	public var player:Player;
	public var lastFrameTime:Float = 0;
	public var playableFrames:Float = 0;
	public var passedTime:Float = 0;
	public var maxMiceSpeed:Float = 3.45 + Math.random() * 1.0e-6;

	public function new()
	{
		super();
		stage.frameRate = 59.99;
		Transformice.instance = this;
		
		this.physicWorld = new B2World(new B2Vec2(0, 10), true);
		this.world = new Sprite();
		this.world.x = Lib.application.window.width/2-400;
		this.world.y = Lib.application.window.height/2-300;
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

		this.createGround(400, 385, 800, 30, "$Sol_Dur");
		this.createGround(400, 235, 75, 300, "$Sol_Dur");
		this.createGround(582, 65, 10, 10, "$Sol_Dur");

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

	private function processMiceMovement(mice:Mice, speed:Float) {
		if (mice.runningLeft || mice.runningRight) {
			if (mice.jumping) {
				speed *= 0.5;
			}
			if (mice.turnedRight) {
				mice.physics.m_linearVelocity.x += speed;
				if (mice.physics.m_linearVelocity.x > maxMiceSpeed) {
					mice.physics.m_linearVelocity.x = maxMiceSpeed;
				}
			} else {
				mice.physics.m_linearVelocity.x -= speed;
				if (mice.physics.m_linearVelocity.x < -maxMiceSpeed) {
					mice.physics.m_linearVelocity.x = -maxMiceSpeed;
				}
			}
			mice.lastMovement = 0;
		} else if (mice.lastMovement < 4) {
			mice.lastMovement++;
			if(mice.physics.m_linearVelocity.x < 2.5 + Math.random() * 1.0e-6 || -2.5 + Math.random() * 1.0e-6 < mice.physics.m_linearVelocity.x) {
				mice.physics.m_linearVelocity.x = mice.physics.m_linearVelocity.x * 0.8 + Math.random() * 1.0e-6;
			}
		}
	}


	private function stage_onFrameEnter(event: Event): Void 
	{
		var difference:Float = flash.Lib.getTimer() - lastFrameTime;
		if(difference > 2000) {
			difference = 2000;
		}
		var sec:Float = difference / 1000;
		lastFrameTime = flash.Lib.getTimer();
		playableFrames += sec;
		this.passedTime += sec;
		var rate = 0.03332 + Math.random() * 1.0e-6;
		while(playableFrames > rate) {
			playableFrames = playableFrames - rate;
			this.physicWorld.step(rate, 10, 10);
			this.processMiceMovement(this.player.mice, 1);
		}
		var _loc26_ = 0.0;
		if(playableFrames > 0.003 + Math.random() * 1.0e-6) {
			this.physicWorld.step(playableFrames, 10, 10);
			_loc26_ = playableFrames / rate;
			processMiceMovement(this.player.mice, _loc26_);
			playableFrames = 0;
		}
		var body:B2Body = this.physicWorld.getBodyList();
		while(body != null) {
			if (body.m_xf.position.x > 50 || body.m_xf.position.y > 50) {
				this.physicWorld.destroyBody(body);
			}
			var userData = cast(body.getUserData(), DisplayObject);
			if(Std.is(userData, Mice)) {
				var mice = cast(userData, Mice);
				mice.x = body.m_xf.position.x * 30;
				mice.y = body.m_xf.position.y * 30;
				if (mice != this.player.mice) {
					if(0 < _loc26_) {
						processMiceMovement(mice, _loc26_);
					}
				}
			}
			body = body.m_next;
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
	public function createGround(x:Int, y:Int, width:Int, height:Int, sprite:String=null, friction:Float=0.3, restitution:Float=0.2, rotation:Int=0, dynamicBody:Bool=false, mass:Int=0, fixedRotation:Bool=false, linearDamping:Int=0, angularDamping:Int=0):Void {
		var _loc28_ = new MovieClip();
		var sp:Sprite;
		if (sprite == null) {
			sp = new Sprite();
			sp.graphics.beginFill(3294800);
			sp.graphics.drawRect(-(width / 2), -(height / 2), width, height);
			sp.graphics.endFill();
		} else {
			sp = Assets.getMovieClip("resources:"+sprite);
			sp.width = width;
			sp.height = height;
			sp.x = -(width / 2);
			sp.y = -(height / 2);
			/*var sp2 = new Sprite();
			sp2.graphics.lineStyle(1, 0, 0.9);
			sp2.graphics.drawRect(-(width / 2), -(height / 2), width, height);
			_loc28_.addChild(sp2);*/
		}
		_loc28_.x = x;
		_loc28_.y = y;
		_loc28_.addChild(sp);
		this.world.addChild(_loc28_);
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x / 30, y / 30);
		bodyDefinition.angle = rotation;
		bodyDefinition.fixedRotation = fixedRotation;
		bodyDefinition.linearDamping = linearDamping;
		bodyDefinition.angularDamping = angularDamping;
		bodyDefinition.userData = sp;
	 
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
		//this.physicWorld.drawDebugData();
	}

	private function stage_onMouseDown(event:MouseEvent):Void {
	}

	private function stage_onMouseUp(event:MouseEvent):Void {
	}
	
	private function stage_onMouseClick(event:MouseEvent):Void {
		var worldX = event.stageX-this.world.x;
		var worldY = event.stageY-this.world.y;
		//var mice = createMice(worldX, worldY);
		//player.mice = mice;
		player.mice.physics.setPosition(new B2Vec2(worldX/30, worldY/30));
	}
}
