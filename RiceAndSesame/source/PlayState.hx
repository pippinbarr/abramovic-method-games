package;


import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTextField;
import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxSave;

import flash.display.Sprite;
import flash.display.BitmapData;

import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.collision.B2AABB;
import box2D.collision.shapes.B2Shape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2World;
import box2D.dynamics.joints.B2MouseJoint;
import box2D.dynamics.joints.B2MouseJointDef;


enum State 
{
	FADE_IN;
	TUTORIAL;
	PLAY;
}


class PlayState extends FlxState
{
	public static var save:FlxSave;

	private static var LABEL_FADE_AMOUNT:Float = 0.05;

	private static var DROP_NUMBER:Int = 75;
	private static var TOTAL_NUMBER:Int = 3000000;
	// private static var DROP_NUMBER:Int = 2;
	// private static var TOTAL_NUMBER:Int = 2;

	private var state:State;

	private var world:B2World;
	// private var debug:Sprite;


	private var ground:B2Body;

	public static var riceCup:RiceCup;
	public static var sesameCup:SesameCup;

	public static var indicatorSprites:FlxGroup;

	public static var riceSprites:FlxGroup;
	public static var sesameSprites:FlxGroup;

	public static var indicatedRice:Rice;
	public static var indicatedSesame:Sesame;
	public static var sesameIndicator:FlxText;
	public static var riceIndicator:FlxText;

	private var mouseJoint:B2MouseJoint;

	private var dropped:Int = 0;
	private var totalDropped:Int = 0;


	private var instructions:FlxText;
	private var riceLabel:FlxText;
	private var sesameLabel:FlxText;
	private var riceLabelFadeAmount:Float = 0.0;
	private var sesameLabelFadeAmount:Float = 0.0;
	private var completedFadeAmount:Float = 0.0;

	public static var reduceAlphaBy:Float = 0;



	private var processedText:FlxText;

	override public function create():Void
	{
		super.create();

		// trace("PlayState.create()");


		processedText = new FlxText(0,FlxG.height / 2,FlxG.width,"");
		processedText.setFormat("Handwriting",Std.int(FlxG.height/10),0xFF000000,"center");

		// add(processedText);

		save = new FlxSave();

		save.bind("RiceAndSesameSave");

		if (save.data.totalProcessed == null) save.data.totalProcessed = 0;
			// trace("Loaded RiceAndSesameSave, totalProcessed is " + save.data.totalProcessed);


		// FlxG.mouse.show();

		var cursor:BitmapData = new BitmapData(1, 1, 0x00FFFFFF);
		FlxG.mouse.show(cursor);
		FlxG.mouse.useSystemCursor = true;
		FlxG.camera.antialiasing = true;
		FlxG.bgColor = 0xFFFFFFFF;




		// PHYSICS


		Physics.WORLD = new B2World (new B2Vec2 (0, 10.0), true);


		// Physics.DEBUG_SPRITE = new Sprite();
		// Physics.DEBUG_SPRITE.alpha = 0.75;
		// FlxG.stage.addChild(Physics.DEBUG_SPRITE);

		// Physics.DEBUG = new B2DebugDraw ();
		// Physics.DEBUG.setSprite(Physics.DEBUG_SPRITE);
		// Physics.DEBUG.setDrawScale(1/Physics.SCALE);
		// Physics.DEBUG.setFlags(B2DebugDraw.e_shapeBit);

		// Physics.WORLD.setDebugDraw(Physics.DEBUG);
		Physics.WORLD.setGravity(new B2Vec2(0,9.8));



		var groundPhysics:FlxSprite = new FlxSprite(0,0);
		groundPhysics.makeGraphic(FlxG.width,Std.int(FlxG.height / 10),0xFF000000);
		groundPhysics.x = 0;
		groundPhysics.y = FlxG.height - groundPhysics.height;
		Physics.createBodyFromSpriteBoundingBox(groundPhysics,false);



		// INSTRUCTIONS

		instructions = new FlxText(0,0,Std.int(FlxG.width  - FlxG.width / 2),"");
		instructions.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"left");
		instructions.text = "" +
		"USE THE MOUSE TO DRAG THE RICE GRAINS AND BLACK SESAME SEEDS INTO THEIR CUPS. " +
		"KEEP A TALLY OF EACH ON A PIECE OF PAPER. YOU CAN QUIT AND COME BACK TO CONTINUE COUNTING " +
		"WHENEVER YOU WISH.";
		instructions.x = Std.int(FlxG.width/2 - instructions.width/2);
		instructions.y = Std.int(FlxG.height/4 - instructions.height/4);
		
		if (save.data.totalProcessed != 0)
		instructions.visible = false;

		add(instructions);



		// GROUND

		var ground:FlxSprite = new FlxSprite(0,0,GameAssets.BACKGROUND_LINE_IMAGES[GameAssets.resolution]);
		ground.setOriginToCorner();
		ground.antialiasing = true;
		// ground.scale.x = GameAssets.scale;
		ground.scale.y = GameAssets.scale;
		ground.width *= GameAssets.scale;
		// ground.height *= ground.scale.y;
		// ground.x = ground.width/2;
		ground.x = 0;
		ground.y = Std.int(FlxG.height - FlxG.height / 5);



		// RICE SETUP

		riceCup = new RiceCup(2 * FlxG.width / 8, 3.8 * FlxG.height / 6);

		var riceFG:FlxSprite = new FlxSprite(0,0,GameAssets.RICE_CUP_FG_IMAGES[GameAssets.resolution]);
		riceFG.antialiasing = true;
		riceFG.setOriginToCorner();
		riceFG.scale = riceCup.scale;
		riceFG.width *= GameAssets.scale;
		riceFG.height *= GameAssets.scale;
		riceFG.x = riceCup.x;
		riceFG.y = riceCup.y;
		// riceFG.alpha = 0.5;

		riceLabel = new FlxText(0,0,Math.floor(riceFG.width),"RICE");
		riceLabel.setFormat("Handwriting",Std.int(FlxG.height / 20),0xff000000,"center");
		riceLabel.x = riceCup.x;
		riceLabel.y = riceCup.y + (riceCup.height/2 - riceLabel.height / 2);

		riceSprites = new FlxGroup();



		// SESAME SETUP

		sesameCup = new SesameCup(7 * FlxG.width / 10, riceCup.y - FlxG.height/40);

		var sesameFG:FlxSprite = new FlxSprite(0,0,GameAssets.SESAME_CUP_FG_IMAGES[GameAssets.resolution]);
		sesameFG.antialiasing = true;
		sesameFG.setOriginToCorner();
		sesameFG.scale = sesameCup.scale;
		sesameFG.width *= GameAssets.scale;
		sesameFG.height *= GameAssets.scale;
		sesameFG.x = sesameCup.x;
		sesameFG.y = sesameCup.y;
		// sesameFG.alpha = 0.5;

		sesameLabel = new FlxText(0,0,Std.int(sesameFG.width),"");
		sesameLabel.setFormat("Handwriting",Std.int(FlxG.height / 20),0xff000000,"center");
		sesameLabel.text = "SESAME";
		sesameLabel.x = Std.int(sesameFG.x);
		sesameLabel.y = Std.int(sesameFG.y + (sesameFG.height/2 - sesameLabel.height/2));


		sesameSprites = new FlxGroup();



		// INDICATOR TEXTS

		indicatorSprites = new FlxGroup();


		// ADD TO THE DISPLAY

		add(ground);

		add(riceCup);
		add(sesameCup);

		add(riceSprites);
		add(sesameSprites);

		add(riceFG);
		add(sesameFG);

		add(sesameLabel);
		add(riceLabel);

		add(indicatorSprites);


		FlxG.fade(0xFFFFFFFF,2,true,onFadedIn);

		state = FADE_IN;
	}
	

	private function onFadedIn():Void
	{
		if (save.data.totalProcessed == 0)
		{
			state = TUTORIAL;
			instructions.visible = true;
		}
		else
		{
			state = PLAY;
		}
	}


	override public function destroy():Void
	{		
		save.close();
		super.destroy();
	}


	override public function update():Void
	{
		if (FlxG.paused) return;
		
		super.update();

		processedText.text = "" + save.data.totalProcessed;
		save.flush();


		if (riceIndicator != null)
		{
			riceIndicator.alpha -= riceLabelFadeAmount;
			if (riceIndicator.alpha <= 0) riceIndicator.kill();
		}
		if (sesameIndicator != null)
		{		
			sesameIndicator.alpha -= sesameLabelFadeAmount;
			if (sesameIndicator.alpha <= 0) sesameIndicator.kill();
		}

		handleInstructions();

		if (state == TUTORIAL)
		{
			handleTutorialDropping();
		}
		else if (state == PLAY)
		{
			handleDropping();
		}

		handlePhysics();

		handleMouseDrag();

		// handleDebugInput();

		handleCleanup();
	}


	private function handleInstructions():Void
	{
		instructions.alpha -= reduceAlphaBy;

		if (instructions.alpha <= 0) 
		{
			instructions.kill();
		}
	}


	private function handlePhysics():Void
	{
		Physics.WORLD.step(1 / 30, 10, 10);
		Physics.WORLD.clearForces();
		// Physics.WORLD.drawDebugData();
	}


	private function handleTutorialDropping():Void
	{
		if (indicatedRice == null)
		{
			indicatedRice = cast(riceSprites.recycle(Rice),Rice);
			indicatedRice.revive();

			trace("Creating indicatedRice...");

			// indicatedRice = new Rice(0,0);

			indicatedRice.x = FlxG.width / 2 - FlxG.width / 8; 
			indicatedRice.y = 0;
			indicatedRice.setupAsPhysicsObject();

			riceIndicator = new FlxText(0,0,Std.int(FlxG.height / 10),"RICE");
			riceIndicator.setFormat("Handwriting",Std.int(FlxG.height / 30),0xff000000,"center");
			riceIndicator.x = Std.int(indicatedRice.x + indicatedRice.width / 2 - riceIndicator.width/2);
			riceIndicator.y = Std.int(indicatedRice.y - indicatedRice.height * 3);

			indicatorSprites.add(riceIndicator);
		}
		else if (indicatedRice.alive)
		{
			riceIndicator.x = Std.int(indicatedRice.x + indicatedRice.width / 2 - riceIndicator.width/2);
			riceIndicator.y = Std.int(indicatedRice.y - indicatedRice.height * 3);
		}
		else
		{
			riceLabelFadeAmount = LABEL_FADE_AMOUNT;
		}

		if (indicatedSesame == null)
		{
			indicatedSesame = cast(sesameSprites.recycle(Sesame),Sesame);
			indicatedSesame.revive();

			trace("Creating indicatedSesame...");

			// indicatedSesame = new Sesame(0,0);
			indicatedSesame.x = FlxG.width / 2 + FlxG.width / 8; 
			indicatedSesame.y = 0;
			indicatedSesame.setupAsPhysicsObject();
			
			sesameIndicator = new FlxText(0,0,Std.int(FlxG.height / 5),"SESAME");
			sesameIndicator.setFormat("Handwriting",Std.int(FlxG.height / 30),0xff000000,"center");
			sesameIndicator.x = Std.int(indicatedSesame.x - sesameIndicator.width/2);
			sesameIndicator.y = Std.int(indicatedSesame.y - indicatedSesame.height * 3);

			indicatorSprites.add(sesameIndicator);
		}
		else if (indicatedSesame.alive)
		{
			sesameIndicator.x = Std.int(indicatedSesame.x  + indicatedSesame.width/2 - sesameIndicator.width/2);
			sesameIndicator.y = Std.int(indicatedSesame.y - indicatedSesame.height * 3);
		}
		else
		{
			sesameLabelFadeAmount = LABEL_FADE_AMOUNT;
		}

		if (sesameIndicator != null && riceIndicator != null && 
			!sesameIndicator.alive && !riceIndicator.alive &&
			!indicatedRice.alive && !indicatedSesame.alive)
		{
			state = PLAY;
			reduceAlphaBy = 0.1;
		}
	}

	private function handleDropping():Void
	{
		if (dropped < DROP_NUMBER && Math.random() < 0.3)
		{
			if (Math.random() < 0.5)
			{
				var sesame:Sesame = cast(sesameSprites.recycle(Sesame),Sesame);
				sesame.revive();
				sesame.x = FlxG.width / 2 + Math.random() * sesame.width * 3; 
				sesame.y = 0 - sesame.height - Math.random() * sesame.height * 3;
				sesame.setupAsPhysicsObject();
				// add(sesame);	
			}
			else
			{
				var rice:Rice = cast(riceSprites.recycle(Rice),Rice);
				rice.revive();
				rice.x = FlxG.width / 2 + Math.random() * rice.width * 3; 
				rice.y = 0 - rice.height - Math.random() * rice.height * 3;
				rice.setupAsPhysicsObject();
				// add(poppy);	
			}
			dropped++;
		}
	}

	private function handleDebugInput():Void
	{
		if (FlxG.keys.justPressed("E"))
		{
			trace("Erase.");
			save.erase();
			save.close();
			FlxG.switchState(new PlayState());
		}
		
		if (FlxG.keys.justPressed("R"))
		{
			trace("Reload.");
			save.close();
			FlxG.switchState(new PlayState());
		}

		if (FlxG.keys.D)
		{
			// Physics.DEBUG_SPRITE.visible = true;
			// Physics.WORLD.drawDebugData();
		}
		else
		{
			
			// Physics.DEBUG_SPRITE.visible = false;
		}

	}

	private function handleCleanup():Void
	{
		if (riceSprites.getFirstAlive() == null && sesameSprites.getFirstAlive() == null)
		{
			totalDropped += dropped;

			if (totalDropped >= TOTAL_NUMBER)
			{
				// Do something when they've counted all 3000000
				FlxG.fade(0xFFFFFFFF,2,false,switchToCompletedState);
			}
			else
			{
				dropped = 0;
			}
		}
	}


	private function switchToCompletedState():Void
	{
		FlxG.switchState(new CompletedState());
	}


	public function getBodyAtMouse():B2Body 
	{
		var x:Float = Physics.screenToWorld(FlxG.mouse.x);
		var y:Float = Physics.screenToWorld(FlxG.mouse.y);

		var mousePVec:B2Vec2 = new B2Vec2(x,y);

		var aabb:B2AABB = new B2AABB();

		aabb.lowerBound = new B2Vec2(x - 0.001, y - 0.001);
		aabb.upperBound = new B2Vec2(x + 0.001, y + 0.001);

		var k_maxCount:Int = 10;
		var shapes:Array<B2Shape> = new Array();

		var body:B2Body = null;

		function getBodyCallback(fixture:B2Fixture):Bool
		{
			var shape:B2Shape = fixture.getShape();
			if (fixture.getBody().getType() != B2Body.b2_staticBody)
			{
				var inside:Bool = shape.testPoint(fixture.getBody().getTransform(), mousePVec);
				if (inside)
				{
					body = fixture.getBody();
					return false;
				}
			}
			return true;
		}

		Physics.WORLD.queryAABB(getBodyCallback,aabb);

		return body;
	}


	function handleMouseDrag():Void
	{
		if (FlxG.mouse.pressed() && mouseJoint == null)
		{
			var body:B2Body = getBodyAtMouse();

			if (body != null)
			{
				var md:B2MouseJointDef = new B2MouseJointDef();
				md.bodyA = Physics.WORLD.getGroundBody();
				md.bodyB = body;
				md.target.set(Physics.screenToWorld(FlxG.mouse.x), Physics.screenToWorld(FlxG.mouse.y));
				md.collideConnected = true;
				md.maxForce = 300.0 * body.getMass();
				mouseJoint = cast(Physics.WORLD.createJoint(md),B2MouseJoint);
				mouseJoint.setMaxForce(20);
				body.setAwake(true);

				if (indicatedRice != null && body == indicatedRice.hit)
				{
					riceLabelFadeAmount = LABEL_FADE_AMOUNT;
				}
				if (indicatedSesame != null && body == indicatedSesame.hit)
				{
					sesameLabelFadeAmount = LABEL_FADE_AMOUNT;
				}
			}
		}

		if (!FlxG.mouse.pressed())
		{
			if (mouseJoint != null)
			{
				Physics.WORLD.destroyJoint(mouseJoint);
				mouseJoint = null;
			}
		}

		if (mouseJoint != null)
		{
			var p2:B2Vec2 = new B2Vec2(Physics.screenToWorld(FlxG.mouse.x), Physics.screenToWorld(FlxG.mouse.y));
			mouseJoint.setTarget(p2);
		}
	}
}