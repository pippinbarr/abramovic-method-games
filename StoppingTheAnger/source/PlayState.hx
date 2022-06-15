package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxGroup;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;
import org.flixel.util.FlxPoint;
import org.flixel.util.FlxColor;


enum State
{
	START;
	INSTRUCTIONS_FADE_OUT;
	HOLDING;
	RELEASED_RESTART;
	RELEASED_COMPLETED;
	FADE_OUT;
}

class PlayState extends FlxState
{
	private static var FADE_AMOUNT:Float = 0.05;
	private static var MIN_TIME:Float = 20.0;
	private static var MAX_TIME:Float = 22.0 * 60.0;
	private static var TIME_DECREASE:Float = 0.1;
	private static var MAX_TO_ADD:Int = 25;

	private var inputEnabled:Bool = true;
	private var timerFinished:Bool = false;

	private var instruction:FlxText;
	private var subtext:FlxText;
	private var fadeAmount:Float = 0.0;

	private var state:State;

	private var timer:FlxTimer;
	private var prevTimerTime:Float = 0;

	private var visuals:FlxGroup;
	private var numVisuals:Int = 0;
	private var timeIncrement:Float = 2.75;

	private var bg:FlxSprite;
	private var bgAlphaIncrement:Float = 0;

	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		bg = new FlxSprite(0,0);
		bg.makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		bg.alpha = 0.0;
		add(bg);

		instruction = new FlxText(0,0,FlxG.width);
		instruction.setFormat("Handwriting",Std.int(FlxG.height/15),0xFF000000,"center");
		instruction.x = 0;
		instruction.y = Std.int(FlxG.height/2 - instruction.height/2);
		add(instruction);

		instruction.text = "HOLD YOUR BREATH FOR AS LONG AS YOU CAN.";
		
		subtext = new FlxText(0,0,FlxG.width);
		subtext.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		subtext.text = "HOLD DOWN THE SPACE BAR WHILE HOLDING YOUR BREATH.";
		subtext.x = 0;
		subtext.y = Std.int(3*FlxG.height/4 - subtext.height/2);
		add(subtext);

		visuals = new FlxGroup();
		add(visuals);

		timer = new FlxTimer();

		FlxG.fade(0xFFFFFFFF,2,true);

		state = START;
	}
	

	override public function destroy():Void
	{
		super.destroy();
	}


	override public function update():Void
	{
		if (FlxG.paused) return;

		super.update();

		updateVisuals();
		handleInterface();

		switch (state)
		{
			case START:
			handleStartInput();

			case INSTRUCTIONS_FADE_OUT:

			case HOLDING:
			handleHoldingInput();

			case RELEASED_RESTART:


			case RELEASED_COMPLETED:


			case FADE_OUT:

		}
	}	


	private function handleStartInput():Void
	{
		if (FlxG.keys.SPACE)
		{
			state = INSTRUCTIONS_FADE_OUT;
			fadeAmount = -FADE_AMOUNT;
			bgAlphaIncrement = 0.0004;
		}
	}


	private function handleHoldingInput():Void
	{
		if (FlxG.keys.SPACE)
		{
			if ((timer.time - timer.timeLeft) > (prevTimerTime + timeIncrement))
			{
				prevTimerTime = (timer.time - timer.timeLeft);
				timeIncrement = Math.max(timeIncrement - TIME_DECREASE,0.1);

				if (Math.random() > 0.8)
				{
					return;
				}

				numVisuals = Std.int(Math.min(numVisuals + 1,MAX_TO_ADD));

				for (i in 0...numVisuals)
				{
					addVisuals();
				}

			}
		}
		else
		{
			// They finished
			if ((timer.time - timer.timeLeft) > MIN_TIME)
			{
				state = RELEASED_COMPLETED;
				exerciseCompleted();
			}
			else
			{
				state = RELEASED_RESTART;
				// Setup a message saying they can start again
			}
		}
	}


	private function addVisuals():Void
	{
		// if (visuals.members.length > 100) return;

		var visual:FlxSprite = cast(visuals.recycle(FlxSprite),FlxSprite);
		visual.revive();
		visual.loadRotatedGraphic(GameAssets.BALL_IMAGES[GameAssets.resolution],64);
		visual.antialiasing = true;
		visual.scale.x = visual.scale.y = GameAssets.scale;
		visual.width *= visual.scale.x;
		visual.height *= visual.scale.y;
		visual.alpha = 0.25;
		visual.centerOffsets();

		if (Math.random() > 0.5)
		{
			// Starting on LEFT SIDE
			visual.x = Std.int(Math.random() * -(2 * visual.width) - visual.width);
			// Move to the RIGHT
			visual.velocity.x = FlxG.width + (Math.random() * FlxG.width / 6);
		}
		else
		{
			// Starting on RIGHT SIDE
			visual.x = Std.int(FlxG.width + Math.random() * (2 * visual.width));
			// Moving to LEFT
			visual.velocity.x = -FlxG.width + (Math.random() * -FlxG.width / 6);
		}
		visual.y = Math.random() * FlxG.height;
	}


	private function updateVisuals():Void
	{
		for (i in 0...visuals.members.length)
		{
			var visual:FlxSprite = cast(visuals.members[i],FlxSprite);

			if (visual == null || !visual.alive) continue;

			// trace("Look at visual at " + visual.x + "," + visual.y + ", v=" + visual.velocity.x + "," + visual.velocity.y);

			if (visual.x > FlxG.width && visual.velocity.x > 0)
			{
				// trace("Killed for being off RIGHT.");
				visual.kill();
			}
			else if (visual.x  + visual.width < 0 && visual.velocity.x < 0)
			{
				// trace("Killed for being off LEFT.");
				visual.kill();
			}
			else if (visual.velocity.x > 0)
			{
				// trace("Updating velocity for moving RIGHT.");
				visual.velocity.x = FlxG.width/4 + (Math.random() * FlxG.width / 4);
				// visual.velocity.y = (Math.sin(visual.x/FlxG.height*3)) * FlxG.height / 2;
				visual.velocity.y = (Math.sin(i/visuals.members.length + visual.x/FlxG.width*4)) * FlxG.height * 10;
			}
			else if (visual.velocity.x < 0)
			{
				// trace("Updating velocity for moving LEFT.");
				visual.velocity.x = -FlxG.width/4 + (Math.random() * -FlxG.width / 4);
				// visual.velocity.y = (Math.sin(visual.x/FlxG.height*3));
				visual.velocity.y = (Math.sin(i/visuals.members.length + visual.x/FlxG.width*4)) * FlxG.height * 10;
			}

			if (visual.y + visual.height < 0)
			{
				visual.y = FlxG.height;
			}
			else if (visual.y > FlxG.height) 
			{
				visual.y = 0 - visual.height;
			}

			visual.velocity.x /= 2;
			visual.velocity.y /= 10;

			// visual.angle = Std.int(180/Math.PI * Math.atan(visual.velocity.y/visual.velocity.x));
		}
	}



	private function handleInterface():Void
	{
		instruction.alpha += fadeAmount;
		subtext.alpha += fadeAmount;
		bg.alpha += bgAlphaIncrement;

		if (state == INSTRUCTIONS_FADE_OUT)
		{
			if (instruction.alpha <= 0)
			{
				state = HOLDING;
				fadeAmount = 0;
				timer.start(MAX_TIME,1,maxTimerFinished);
			}
		}
	}


	private function maxTimerFinished(t:FlxTimer):Void
	{
		// Say something about how they can't really be holding their breath.
	}


	private function exerciseCompleted():Void
	{
		state = FADE_OUT;
		FlxG.fade(0xFFFFFFFF,2,false,switchToCompleteState);
	}


	private function switchToCompleteState():Void
	{
		FlxG.switchState(new CompletedState());
	}

}