package;

import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;

import org.flixel.plugin.photonstorm.FlxCollision;

import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;


class Rice extends FlxSprite
{
	public var hit:B2Body;
	public var hitSprite:FlxSprite;


	public function new()
	{
		super();

		loadGraphic(GameAssets.RICE_IMAGES[GameAssets.resolution],false,false);
		this.antialiasing = true;

		this.scale.x = this.scale.y = GameAssets.scale;

		this.width *= GameAssets.scale;
		this.height *= GameAssets.scale;

		centerOffsets();
	}


	public function setupAsPhysicsObject():Void
	{
		var bodyDefinition = new B2BodyDef();
		var hitX:Float = x + width/2;
		var hitY:Float = y + height/2;

		bodyDefinition.position.set(Physics.screenToWorld(hitX), Physics.screenToWorld(hitY));
		bodyDefinition.type = B2Body.b2_dynamicBody;
		// bodyDefinition.fixedRotation = true;

		var hitShape:B2CircleShape = new B2CircleShape();
		hitShape.setRadius(Physics.screenToWorld(height / 1.8));
		// hitShape.setRadius(Physics.screenToWorld(height / 2.5));
		hitShape.setLocalPosition(new B2Vec2(-Physics.screenToWorld(width / 4.5),0));

		var fixtureDefinition = new B2FixtureDef();
		fixtureDefinition.shape = hitShape;
		fixtureDefinition.restitution = 0.1;
		fixtureDefinition.friction = 1;
		fixtureDefinition.density = 0.7;

		var hitShape2:B2CircleShape = new B2CircleShape();
		hitShape2.setRadius(Physics.screenToWorld(height / 1.8));
		// hitShape2.setRadius(Physics.screenToWorld(height / 2.5));
		hitShape2.setLocalPosition(new B2Vec2(Physics.screenToWorld(width / 4.5),0));

		var fixtureDefinition2 = new B2FixtureDef();
		fixtureDefinition2.shape = hitShape2;
		fixtureDefinition2.restitution = 0.1;
		fixtureDefinition2.friction = 1;
		fixtureDefinition2.density = 0.7;

		hit = Physics.WORLD.createBody(bodyDefinition);
		hit.createFixture(fixtureDefinition);
		hit.createFixture(fixtureDefinition2);
		hit.setAngularDamping(0.5);

		// hit.setAngle(Math.random() * (2 * Math.PI));
	}


	override public function destroy():Void
	{
		super.destroy();
	}


	override public function update():Void
	{
		x = Physics.worldToScreen(hit.getWorldCenter().x) - width/2;
		y = Physics.worldToScreen(hit.getWorldCenter().y) - height/2;
		angle = hit.getAngle() * (180 / Math.PI);

		super.update();

		// if (this.overlaps(PlayState.riceCup.bottom) || this.overlaps(PlayState.sesameCup.bottom))
		if (FlxCollision.pixelPerfectCheck(this,PlayState.riceCup.bottom) ||
			FlxCollision.pixelPerfectCheck(this,PlayState.sesameCup.bottom))
		{
			PlayState.save.data.totalProcessed++;

			this.kill();
			PlayState.riceSprites.remove(this);
			Physics.WORLD.destroyBody(hit);
		}

		if (y > FlxG.height || x < -FlxG.width / 5 || x > FlxG.width + FlxG.width / 5)
		{
			PlayState.save.data.totalProcessed++;

			this.kill();
			PlayState.riceSprites.remove(this);
			Physics.WORLD.destroyBody(hit);
		}
	}
}