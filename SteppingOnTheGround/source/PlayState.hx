package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.FlxG;

import flixel.util.FlxTimer;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxColorUtil;

import flash.display.BitmapData;


enum Weather
{
	SUN;
	RAIN;
	SNOW;
	WIND;
	OVERCAST;
}

enum State
{
	WEATHER;
	WEATHER_FADE_OUT;
	INSTRUCTIONS_FADE_IN;
	INSTRUCTIONS;
	INSTRUCTIONS_FADE_OUT;
	NO_INSTRUCTIONS;
}

class PlayState extends FlxState
{
	public static var TEST_WEATHER:Int = -1;

	private static var EXERCISE_TIME:Float = 60 * 30;
	private static var FADE_AMOUNT:Float = 0.05;

	private var inputEnabled:Bool = true;
	private var timerFinished:Bool = false;

	private var instruction:FlxText;
	private var subtext:FlxText;
	private var fadeAmount:Float = 0.0;

	private var inputsSinceLastCheck:Int = 0;

	private var weather:Weather;

	private var state:State;

	private var rain:FlxGroup;
	private var snow:FlxGroup;
	private var wind:FlxGroup;

	private var windFromLeft:Bool = true;

	private var overcastBitmap:BitmapData;
	private var perlinIndex:Int = 0;
	private var currentPerlin:Float = 0.5;
	private var perlinTarget:Float = 0.5;

	private var rainAbate:Float = 0.0;

	private static var MAX_OVERCAST_CHANGES:Int = 100;
	private var changeCount:Int = 0;
	private var overcastChange:Float = 0;
	private var overcastTarget:Float = 0.5;
	private var overcastCurrent:Float = 0.5;

	private var LEFT:Int = 0;
	private var RIGHT:Int = 1;
	private var nextKey:Int = 0;

	public static var boids:FlxGroup;
	private var seekX:Float;
	private var seekY:Float;

	private var timer:FlxTimer;

	override public function create():Void
	{
		FlxG.camera.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();
		// FlxG.mouse.show();

		instruction = new FlxText(0,0,FlxG.width);
		instruction.setFormat("Handwriting",Std.int(FlxG.height/15),0xFF000000,"center");
		instruction.x = 0;
		instruction.y = Std.int(FlxG.height/2 - instruction.height/2);
		add(instruction);

		wind = new FlxGroup();
		add(wind);
		snow = new FlxGroup();
		add(snow);
		rain = new FlxGroup();
		add(rain);

		var random:Float = Math.random();
		if (random < 0.2) weather = OVERCAST;
		else if (random < 0.4) weather = SUN;
		else if (random < 0.6) weather = RAIN;
		else if (random < 0.8) weather = SNOW;
		else weather = WIND;

		// weather = WIND;

		if (weather == OVERCAST)
		{
			FlxG.cameras.bgColor = 0xFFAAAAAA;

			var hsv:HSV = FlxColorUtil.RGBtoHSV(FlxG.cameras.bgColor);
			hsv.lightness = 0.5;
			FlxG.cameras.bgColor = FlxColorUtil.HSVtoRGBA(hsv.hue,hsv.saturation,hsv.lightness);

			instruction.text = "IT IS OVERCAST THIS MORNING.";
		}
		else if (weather == SUN)
		{
			FlxG.cameras.bgColor = 0xFF8bb8e5;
			instruction.text = "IT IS SUNNY THIS MORNING.";
			boids = new FlxGroup();
			add(boids);

			seekX = Std.int(FlxG.width + 100);
			seekY = Std.int(FlxG.height/2);

			for (i in 0...60)
			{
				var boid:Boid = new Boid(
					FlxG.width/4 + Math.random()*FlxG.width/2,
					FlxG.height/4 + Math.random()*FlxG.height/2,
					seekX,
					seekY);
				boids.add(boid);
			}
		}
		else if (weather == RAIN)
		{
			FlxG.cameras.bgColor = 0xFFDDDDDD;
			instruction.text = "IT IS RAINING THIS MORNING.";
		}
		else if (weather == SNOW)
		{
			FlxG.cameras.bgColor = 0xFF555555;
			instruction.text = "IT IS SNOWING THIS MORNING.";
		}
		else if (weather == WIND)
		{
			FlxG.cameras.bgColor = 0xFFBBBBBB;
			instruction.text = "IT IS WINDY THIS MORNING.";
		}


		subtext = new FlxText(0,0,FlxG.width);
		subtext.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		subtext.text = "PRESS THE SPACE BAR TO CONTINUE.";
		subtext.x = 0;
		subtext.y = Std.int(3*FlxG.height/4 - subtext.height/2);
		add(subtext);

		FlxTimer.start(EXERCISE_TIME,exerciseCompleted);

		FlxG.camera.fade(0xFFFFFFFF,2,true);

		state = WEATHER;
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (FlxG.paused) return;

		super.update();

		handleInput();
		handleInterface();

		switch (weather)
		{
			case RAIN:
			updateRain();
			case SNOW:
			updateSnow();
			case WIND:
			updateWind();
			case OVERCAST:
			updateOvercast();
			case SUN:
			updateSun();
		}
	}	


	private function updateRain():Void
	{
		for (i in 0...40)
		{
			var drop:FlxSprite = cast(rain.recycle(FlxSprite),FlxSprite);
			drop.revive();
			drop.loadGraphic(GameAssets.RAIN_IMAGES[GameAssets.resolution]);
			drop.antialiasing = true;
			drop.scale.x = drop.scale.y = GameAssets.scale;
			drop.x = Std.int(Math.random() * FlxG.width);
			drop.y = Std.int(Math.random() * -80);

			drop.velocity.y = Std.int(FlxG.height * 2 + (Math.random() * FlxG.height / 5));

			if (Math.random() < rainAbate)
			{
				if (FlxG.keys.pressed.LEFT)
				{
					if (drop.x > FlxG.width/10 && drop.x < FlxG.width/2 - FlxG.width/10)
					{
						drop.kill();
					}
				}
				else if (FlxG.keys.pressed.RIGHT)
				{
					if (drop.x > FlxG.width/2 + FlxG.width/10 && drop.x < FlxG.width - FlxG.width/10)
					{
						drop.kill();
					}
				}
			}

		}

		if (FlxG.keys.justPressed.LEFT)
		{
			rainAbate = 0;
		}
		else if (FlxG.keys.justPressed.RIGHT)
		{
			rainAbate = 0;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			rainAbate += 0.03;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			rainAbate += 0.03;
		}

		for (i in 0...rain.members.length)
		{
			if (rain.members[i] != null && rain.members[i].alive)
			{
				if (cast(rain.members[i],FlxSprite).y > FlxG.height)
				{
					rain.members[i].kill();
				}
			}
		}
	}



	private function updateSun():Void
	{
		if (FlxG.keys.pressed.LEFT)
		{
			for (i in 0...boids.members.length)
			{
				var boid:Boid = cast(boids.members[i],Boid);
				if (boid != null && boid.alive)
				{
					seekX = Math.max(seekX - 2,-50);
					seekY = Math.random() * FlxG.height;
					boid.setSeekPoint(seekX,seekY);
				}
			}
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			for (i in 0...boids.members.length)
			{
				var boid:Boid = cast(boids.members[i],Boid);
				if (boid != null && boid.alive)
				{
					seekX = Math.min(seekX + 2,FlxG.width + 50);
					seekY = Math.random() * FlxG.height;
					boid.setSeekPoint(seekX,seekY);
				}
			}
		}
		else
		{
			for (i in 0...boids.members.length)
			{
				var boid:Boid = cast(boids.members[i],Boid);
				if (boid != null && boid.alive)
				{
					boid.setSeekPoint(-1,-1);
				}
			}	
		}
	}



	private function updateSnow():Void
	{
		if (Math.random() < 0.07)
		{
			for (i in 0...10)
			{
				var flake:FlxSprite = cast(snow.recycle(FlxSprite),FlxSprite);
				flake.revive();
				if (Math.random() < 0.5)
				{
					flake.loadGraphic(GameAssets.SNOWFLAKES_1[GameAssets.resolution]);
				}
				else
				{
					flake.loadGraphic(GameAssets.SNOWFLAKES_2[GameAssets.resolution]);
				}
				flake.antialiasing = true;
				flake.scale.x = flake.scale.y = GameAssets.scale;
				flake.width *= GameAssets.scale;
				flake.height *= GameAssets.scale;
				flake.centerOffsets();

				flake.x = Std.int(-FlxG.width/10 + Math.random() * (FlxG.width + FlxG.width/10));
				flake.y = Std.int(Math.random() * -(flake.height * 2) - flake.height);

				flake.velocity.y = Std.int(FlxG.height / 10 + (Math.random() * FlxG.height / 20));
				flake.velocity.x = Std.int((FlxG.width / 100 - Math.random() * FlxG.width / 200));
			}
		}

		for (i in 0...snow.members.length)
		{
			if (snow.members[i] != null && snow.members[i].alive)
			{
				var flake:FlxSprite = cast(snow.members[i],FlxSprite);

				if (flake.y > FlxG.height)
				{
					flake.kill();
				}
				else if (FlxG.keys.pressed.LEFT)
				{
					flake.velocity.x = -FlxG.width / 150 + Math.random() * -FlxG.width / 150;

				}
				else if (FlxG.keys.pressed.RIGHT)
				{
					flake.velocity.x = FlxG.width / 150 + Math.random() * FlxG.width / 150;
				}
				else
				{
					flake.velocity.x = Std.int((FlxG.width / 100 - Math.random() * FlxG.width / 200));
				}
			}
		}
	}



	private function updateOvercast():Void
	{
		var perlin:Float = -1;
		var change:Bool = false;

		if (FlxG.keys.justPressed.LEFT) 
		{
			nextKey = LEFT;
			changeCount = 0;
		}
		else if (FlxG.keys.justPressed.RIGHT) 
		{
			nextKey = RIGHT;
			changeCount = 0;
		}

		if (nextKey == LEFT && 
			FlxG.keys.pressed.LEFT && 
			changeCount < MAX_OVERCAST_CHANGES)
		{
			// perlinIndex = (perlinIndex + 1) % overcastBitmap.width;
			// perlin = (overcastBitmap.getPixel(perlinIndex,0) / 0xFFFFFF);
			change = true;
			
		}
		else if (
			nextKey == RIGHT && 
			FlxG.keys.pressed.RIGHT && 
			changeCount < MAX_OVERCAST_CHANGES)
		{
			// perlinIndex = (perlinIndex + 1) % overcastBitmap.width;
			// perlin = (overcastBitmap.getPixel(perlinIndex,0) / 0xFFFFFF);
			// if (currentPerlin == perlinTarget)
			// {
			// 	perlinTarget = Math.random() / 5;
			// }
			change = true;
		}

		// if (perlin == -1) return;

		if (!change) return;

		// trace("currentPerlin=" + currentPerlin + ", perlinTarget=" + perlinTarget);

		if (currentPerlin <= perlinTarget)
		{
			currentPerlin += Math.random() * 0.005;
			if (currentPerlin >= perlinTarget)
			{
				perlinTarget = Math.random() * 0.25 + 0.4;
			}
		}
		else if (currentPerlin >= perlinTarget)
		{
			currentPerlin -= Math.random() * 0.005;
			if (currentPerlin <= perlinTarget)
			{
				perlinTarget = Math.random() * 0.25 + 0.4;
			}
		}

		changeCount++;

		// perlin = perlin * 0.5 + 0.25;

		var hsv:HSV = FlxColorUtil.RGBtoHSV(FlxG.cameras.bgColor);
		hsv.lightness = currentPerlin;

		FlxG.cameras.bgColor = FlxColorUtil.HSVtoRGBA(hsv.hue,hsv.saturation,hsv.lightness);

		if (changeCount >= MAX_OVERCAST_CHANGES)
		{
			if (nextKey == LEFT) 
			{
				changeCount = 0;
				nextKey = RIGHT;
			}
			else if (nextKey == RIGHT) 
			{
				changeCount = 0;
				nextKey = LEFT;
			}
		}
	}


	// SINE WAVE VERSION

	private function updateWind():Void
	{
		if (FlxG.keys.pressed.LEFT)
		{
			windFromLeft = false;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			windFromLeft = true;
		}

		if (Math.random() > 0.1)
		{

			for (i in 0...15)
			{
				var air:FlxSprite = cast(wind.recycle(FlxSprite),FlxSprite);
				air.revive();
				air.loadRotatedGraphic(GameAssets.WIND_IMAGES[GameAssets.resolution],64);
				air.antialiasing = true;
				air.scale.x = air.scale.y = GameAssets.scale;
				air.width *= GameAssets.scale;
				air.height *= GameAssets.scale;
				air.centerOffsets();

				if (windFromLeft)
				{
					air.x = Std.int(Math.random() * -(2 * air.width) - air.width);
					air.velocity.x = FlxG.width + (Math.random() * FlxG.width / 6);
				}
				else
				{
					air.x = Std.int(FlxG.width + Math.random() * (2 * air.width));
					air.velocity.x = -FlxG.width + (Math.random() * -FlxG.width / 6);
				}
				air.y = Math.random() * (FlxG.height * 3) - FlxG.height;
			}
		}

		for (i in 0...wind.members.length)
		{
			var air:FlxSprite = cast(wind.members[i],FlxSprite);

			if (air != null && air.alive)
			{
				if (windFromLeft && air.x > FlxG.width)
				{
					air.kill();
					continue;
				}
				else if (!windFromLeft && air.x  + air.width < 0)
				{
					air.kill();
					continue;
				}
				
				if (windFromLeft)
				{
					air.velocity.x = FlxG.width + (Math.random() * FlxG.width / 6);
					air.velocity.y = (Math.sin(air.x/FlxG.height*2)) * FlxG.height / 2;
				}
				else
				{
					air.velocity.x = -FlxG.width + (Math.random() * -FlxG.width / 6);
					air.velocity.y = (Math.sin(air.x/FlxG.height*2)) * -FlxG.height / 2;
				}

				air.angle = Std.int(180/Math.PI * Math.atan(air.velocity.y/air.velocity.x));

			}
		}
	}



	private function handleInput():Void
	{

		// handleDebugInput();

		if (state == WEATHER && FlxG.keys.justPressed.SPACE)
		{
			state = WEATHER_FADE_OUT;
			fadeAmount = -FADE_AMOUNT;
			inputEnabled = false;
		}
		else if (state == INSTRUCTIONS)
		{
			if (FlxG.keys.pressed.LEFT)
			{
				state = INSTRUCTIONS_FADE_OUT;
				fadeAmount = -FADE_AMOUNT;
				FlxTimer.start(10,checkInput);
			}
		}
		else if (state == NO_INSTRUCTIONS)
		{
			if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
			{
				inputsSinceLastCheck++;
			}
		}
	}


	private function handleDebugInput():Void
	{
		// if (FlxG.keys.S)
		// {
		// 	TEST_WEATHER = SNOW;
		// 	FlxG.switchState(new PlayState());
		// }
		// else if (FlxG.keys.R)
		// {
		// 	TEST_WEATHER = RAIN;
		// 	FlxG.switchState(new PlayState());
		// }
		// else if (FlxG.keys.W)
		// {
		// 	TEST_WEATHER = WIND;
		// 	FlxG.switchState(new PlayState());
		// }		
		// else if (FlxG.keys.U)
		// {
		// 	TEST_WEATHER = SUN;
		// 	FlxG.switchState(new PlayState());
		// }		
		// else if (FlxG.keys.O)
		// {
		// 	TEST_WEATHER = OVERCAST;
		// 	FlxG.switchState(new PlayState());
		// }
	}


	private function checkInput(t:FlxTimer):Void
	{
		if (inputsSinceLastCheck == 0)
		{
			state = INSTRUCTIONS_FADE_IN;
			fadeAmount = FADE_AMOUNT;
		}
		else
		{
			FlxTimer.start(10,checkInput);
		}

		inputsSinceLastCheck = 0;
	}


	private function handleInterface():Void
	{
		instruction.alpha += fadeAmount;
		subtext.alpha += fadeAmount;

		if (state == WEATHER_FADE_OUT)
		{
			if (instruction.alpha <= 0)
			{
				state = INSTRUCTIONS_FADE_IN;
				fadeAmount = FADE_AMOUNT;

				instruction.text = "STEP YOUR FEET ON THE GROUND.\nALTERNATE THE LEFT AND RIGHT.";
				subtext.text = "" +
				"HOLD THE LEFT ARROW KEY WHEN YOUR LEFT FOOT TOUCHES.\n\n" +
				"HOLD THE RIGHT ARROW KEY WHEN YOUR RIGHT FOOT TOUCHES.";
			}
		}
		else if (state == INSTRUCTIONS_FADE_IN)
		{
			if (instruction.alpha >= 1)
			{
				state = INSTRUCTIONS;
				fadeAmount = 0;
			}
		}
		else if (state == INSTRUCTIONS_FADE_OUT)
		{
			if (instruction.alpha <= 0)
			{
				state = NO_INSTRUCTIONS;
				fadeAmount = 0;
			}
		}
	}


	private function exerciseCompleted(t:FlxTimer):Void
	{
		FlxG.camera.fade(0xFFFFFFFF,2,false,switchToCompleteState);
	}


	private function switchToCompleteState():Void
	{
		FlxG.switchState(new CompletedState());
	}

}