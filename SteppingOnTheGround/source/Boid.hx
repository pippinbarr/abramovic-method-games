package;


import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColorUtil;


class Boid extends FlxSprite
{
  private static var SEPARATION:Float = 10;
  private static var ALIGNMENT:Float = 10;
  private static var COHESION:Float = 10;

  public var boidLocation:Vector2D;
  public var boidVelocity:Vector2D;
  public var boidAcceleration:Vector2D;

  public var _r:Float;

  public var _maxforce:Float;    // Maximum steering force
  public var _maxspeed:Float;    // Maximum speed

  public var _seekPoint:Vector2D;


  private var _wanderTheta : Float = 0.0;
  private var _wanderPhi : Float = 0.0;
  private var _wanderPsi : Float = 0.0;
  private var _wanderRadius : Float = 1.0;
  private var _wanderDistance : Float = 1.0;
  private var _wanderStep : Float = 10;  


  public function new(X:Float, Y:Float, SeekX:Float, SeekY:Float) 
  {
    super(X,Y);
    loadGraphic(
      GameAssets.BIRD_IMAGES[GameAssets.resolution],
      true,
      true,
      GameAssets.BIRD_SIZES[GameAssets.resolution],
      GameAssets.BIRD_SIZES[GameAssets.resolution]
      );
    this.antialiasing = true;
    this.scale.x = this.scale.y = GameAssets.scale;
    this.width *= GameAssets.scale;
    this.height *= GameAssets.scale;
    this.centerOffsets();

    animation.add("fly1",[1,1,1,0,1,2],20);
    animation.add("fly2",[1,0,1,2,1,1],20);
    animation.add("fly3",[1,2,1,1,1,0],20);

    animation.add("fly4",[1,1,1,0,1,2],18);
    animation.add("fly5",[1,0,1,2,1,1],18);
    animation.add("fly6",[1,2,1,1,1,0],18);

    var random:Float = Math.random();

    if (random < 0.33)
    {
      if (Math.random() < 0.5)
      animation.play("fly1");
      else
      animation.play("fly4");
    }
    else if (random < 0.66)
    {
      if (Math.random() < 0.5)
      animation.play("fly2");
      else
      animation.play("fly5");    
    }
    else
    {
      if (Math.random() < 0.5)
      animation.play("fly3");
      else
      animation.play("fly6");    
    }

    _seekPoint = new Vector2D(SeekX,SeekY);

    boidAcceleration = new Vector2D(0, 0);

    // Leaving the code temporarily this way so that this example runs in JS
    var _angle:Float = Math.random() * 2 * Math.PI;
    boidVelocity = new Vector2D(Math.cos(angle), Math.sin(angle));

    boidLocation = new Vector2D(X,Y);
    _r = 2.0;
    _maxspeed = 7;
    _maxforce = 0.3;
  }


  override public function update():Void
  {
    super.update();


    flock();
    boidVelocity.add(boidAcceleration);

    // Limit speed
    boidVelocity.truncate(_maxspeed);

    boidLocation.add(boidVelocity);


    wrap();

    // velocity.x = boidVelocity.x;
    // velocity.y = boidVelocity.y;

    var _angle:Float = Math.atan(boidVelocity.y / boidVelocity.x) * 180/Math.PI;

    if (boidVelocity.x < 0) this.facing = FlxObject.LEFT;
    else this.facing = FlxObject.RIGHT;

    angle = _angle;

    if (angle > 45 && angle < 90) angle = 45;
    else if (angle > 315 && angle < 360) angle = 315;
    else if (angle > 90 && angle < 135) angle = 135;
    else if (angle < 270 && angle > 225) angle = 225;

    x = boidLocation.x;
    y = boidLocation.y;

    // Reset accelertion to 0 each cycle
    boidAcceleration.multiply(0);
  }


  private function applyForce(force:Vector2D):Void
  {
    // We could add mass here if we want A = F / M
    boidAcceleration.add(force);
  }



  // We accumulate a new acceleration each time based on three rules
  private function flock():Void
  {

    var sp:Vector2D = separate();   // Separation
    var al:Vector2D = align();      // Alignment
    var co:Vector2D = cohesion();   // Cohesion

    // var sk:Vector2D = seek(new Vector2D(FlxG.width + 100,FlxG.height/4 + Math.random() * FlxG.height/2));   // Cohesion
    // var sk:Vector2D = seek(new Vector2D(FlxG.mouse.screenX,FlxG.mouse.screenY));   // Cohesion
    

    var sk:Vector2D;
    if (_seekPoint.x == -1 && _seekPoint.y == -1)
    {
      sk = wander();
    }
    else
    {
      sk = seek(_seekPoint);
    }




    // Arbitrarily weight these forces
    sp.multiply(1.5);
    al.multiply(1.2);
    co.multiply(1.0);
    sk.multiply(1.0);
    
    // Add the force vectors to acceleration
    applyForce(sp);
    applyForce(al);
    applyForce(co);
    applyForce(sk);
  }


  public function setSeekPoint(X:Float, Y:Float):Void
  {
    _seekPoint.x = X;
    _seekPoint.y = Y;
  }


  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  private function seek(target:Vector2D):Vector2D
  {
    var desired:Vector2D = Vector2D.sub(target,boidLocation);  // A vector pointing from the location to the target
    
    // Scale to maximum speed
    desired.normalize();
    desired.multiply(_maxspeed);

    // Steering = Desired minus Velocity
    var steer:Vector2D = Vector2D.sub(desired,boidVelocity);
    steer.truncate(_maxforce);  // Limit to maximum steering force

    return steer;
  }


  // Wraparound
  private function wrap():Void 
  {
    if (boidLocation.x < -width) boidLocation.x = FlxG.width+width;
    if (boidLocation.y < -height) boidLocation.y = FlxG.height+height;
    if (boidLocation.x > FlxG.width+width) boidLocation.x = -width;
    if (boidLocation.y > FlxG.height+height) boidLocation.y = -height;
  }


  // Separation
  // Method checks for nearby boids and steers away
  private function separate():Vector2D 
  {
    var desiredseparation:Float = SEPARATION;
    var steer:Vector2D = new Vector2D(0,0);
    var count:Int = 0;

    // For every boid in the system, check if it's too close
    for (i in 0...PlayState.boids.members.length) 
    {
      var other:Boid = cast(PlayState.boids.members[i],Boid);

      if (other == null || !other.alive || other == this) continue;


      var d:Float = boidLocation.distance(other.boidLocation);

      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if (d > 0 && d < desiredseparation) 
      {
        // trace("Separating...");
        // trace("... distance is " + d);

        // Calculate vector pointing away from neighbor
        var diff:Vector2D = Vector2D.sub(boidLocation,other.boidLocation);
        diff.normalize();
        diff.divide(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many

        // trace("... diff is " + diff);
        // trace("... steer now " + steer);
      }
    }

    // Average -- divide by how many
    if (count > 0) 
    {
      steer.divide(count);
    }

    // As long as the vector is greater than 0
    // if (steer.mag() > 0) 
    if (steer.length > 0) 
    {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // trace("... pre adjustment steering is " + steer);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.multiply(_maxspeed);
      steer.subtract(boidVelocity);
      steer.truncate(_maxforce);

      // trace("... final steering is " + steer);
    }

    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  private function align ():Vector2D 
  {
    var neighbordist:Float = ALIGNMENT;
    var sum:Vector2D = new Vector2D(0, 0);
    var count:Int = 0;

    for (i in 0...PlayState.boids.members.length) 
    {
      var other:Boid = cast(PlayState.boids.members[i],Boid);

      if (other == null || !other.alive || other == this) continue;

      var d:Float = boidLocation.distance(other.boidLocation);

      if (d < neighbordist) 
      {
        sum.add(other.boidVelocity);
        count++;
      }
    }

    if (count > 0) 
    {
      sum.divide(count);

      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.multiply(_maxspeed);

      var steer:Vector2D = Vector2D.sub(sum, boidVelocity);
      steer.truncate(_maxforce);
      return steer;
    } 
    else 
    {
      return new Vector2D(0, 0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  private function cohesion():Vector2D 
  {
    var neighbordist:Float = COHESION;
    var sum:Vector2D = new Vector2D(0, 0);   // Start with empty vector to accumulate all locations
    var count:Int = 0;

    for (i in 0...PlayState.boids.members.length) 
    {
      var other:Boid = cast(PlayState.boids.members[i],Boid);

      if (other == null || !other.alive || other == this) continue;

      var d:Float = boidLocation.distance(other.boidLocation);
      if (d < neighbordist) 
      {
        sum.add(other.boidLocation); // Add location
        count++;
      }
    }
    if (count > 0) 
    {
      sum.divide(count);
      return seek(sum);  // Steer towards the location
    } 
    else 
    {
      return new Vector2D(0, 0);
    }
  }


  private function wander():Vector2D
  {
    _wanderTheta += -_wanderStep + Math.random() * _wanderStep * 2;
    _wanderPhi += -_wanderStep + Math.random() * _wanderStep * 2;

    if (Math.random() < 0.5)
    {
      _wanderTheta = -_wanderTheta;
    }

    var pos:Vector2D = boidVelocity.cloneVector();

    pos.normalize();
    pos.multiply(_wanderDistance);
    pos.add(boidLocation);

    var steer:Vector2D = new Vector2D(0,0);

    steer.x = _wanderRadius * Math.cos(_wanderTheta);
    steer.y = _wanderRadius * Math.sin(_wanderPhi);

    return steer;
  }
}
// 