package;

import box2D.dynamics.B2World;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2Body;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;

import org.flixel.FlxSprite;
import flash.display.Sprite;

class Physics
{
	public static var WORLD:B2World;
	public static var SCALE:Float = 1/30;

	// public static var DEBUG:B2DebugDraw;
	// public static var DEBUG_SPRITE:Sprite;


	public static function createBodyFromSpriteBoundingBox(S:FlxSprite,Dynamic:Bool):B2Body
	{
		var bodyDefinition = new B2BodyDef();
		bodyDefinition.position.set((S.x + S.width/2) * SCALE, (S.y + S.height/2) * SCALE);
		
		if (Dynamic) 
		{
			bodyDefinition.type = B2Body.b2_dynamicBody;
		}

		var polygon = new B2PolygonShape();
		polygon.setAsBox((S.width/2) * SCALE, (S.height/2) * SCALE);

		var fixtureDefinition = new B2FixtureDef();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.restitution = 0;
		fixtureDefinition.friction = 1;

		var body:B2Body = WORLD.createBody(bodyDefinition);
		body.createFixture(fixtureDefinition);

		var mass:B2MassData = new B2MassData();
		mass.mass = 1000000;
		body.setMassData(mass);
		body.setLinearDamping(10);

		return body;
	}



	public static function worldToScreen(N:Float):Float
	{
		return (N / SCALE);
	}

	public static function screenToWorld(N:Float):Float
	{
		return (N * SCALE);
	}
}