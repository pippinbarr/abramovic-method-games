package;

import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;

import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;


class SesameCup extends FlxSprite
{
	public var hit:B2Body;
	public var hitSprite:FlxSprite;

	public var bottom:FlxSprite;

	public function new(X:Float,Y:Float)
	{
		super(X,Y);
		this.antialiasing = true;
		this.loadGraphic(GameAssets.SESAME_CUP_BG_IMAGES[GameAssets.resolution],false,false);
		this.setOriginToCorner();
		this.scale.x = this.scale.y = GameAssets.scale;
		this.width *= GameAssets.scale;
		this.height *= GameAssets.scale;
		
		this.x = Std.int(X - this.width / 2);
		this.y = Std.int(Y);

		var bodyDefinition = new B2BodyDef();
		var hitX:Float = X + width/2;
		var hitY:Float = Y + height/2;
		bodyDefinition.position.set(Physics.screenToWorld(hitX), Physics.screenToWorld(hitY));
		bodyDefinition.type = B2Body.b2_staticBody;

		hit = Physics.WORLD.createBody(bodyDefinition);

		// LEFT WALL

		var hitShape:B2PolygonShape = new B2PolygonShape();
		hitShape.setAsOrientedBox(
			Physics.screenToWorld(width / 50),
			Physics.screenToWorld((height-10)/2),
			new B2Vec2(-width/90,height/350),
			-0.16);

		var fixtureDefinition = new B2FixtureDef();
		fixtureDefinition.shape = hitShape;
		hit.createFixture(fixtureDefinition);

		// RIGHT WALL 1

		hitShape = new B2PolygonShape();
		hitShape.setAsOrientedBox(
			Physics.screenToWorld(width / 50),
			Physics.screenToWorld(height / 2.4),
			new B2Vec2(width/75,0),			
			0.08);

		fixtureDefinition = new B2FixtureDef();
		fixtureDefinition.shape = hitShape;
		hit.createFixture(fixtureDefinition);

		// RIGHT WALL 2

		// hitShape = new B2PolygonShape();
		// hitShape.setAsOrientedBox(
		// 	Physics.screenToWorld(0.5),
		// 	Physics.screenToWorld(45),
		// 	new B2Vec2(1.45,-0.7),
		// 	-0.1);

		// fixtureDefinition = new B2FixtureDef();
		// fixtureDefinition.shape = hitShape;
		// hit.createFixture(fixtureDefinition);

		bottom = new FlxSprite(X + width/3.6,Y + height - height/4);
		bottom.makeGraphic(Std.int(width - width/2.0),Std.int(height / 10),0xFFFF0000);
		// FlxG.state.add(bottom);

		x = Physics.worldToScreen(hit.getPosition().x) - width/2;
		y = Physics.worldToScreen(hit.getPosition().y) - height/2;

	}


	override public function destroy():Void
	{
		super.destroy();
	}


	override public function update():Void
	{
		super.update();
	}
}