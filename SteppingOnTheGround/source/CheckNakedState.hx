package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;

import flixel.util.FlxTimer;


class CheckNakedState extends FlxState
{
	private static var FADE_AMOUNT:Float = 0.1;

	private var inputEnabled:Bool = true;
	private var timerFinished:Bool = false;

	private var instruction:FlxText;
	private var subtext:FlxText;
	private var fadeAmount:Float = 0.0;

	private var HOLD:Int = 0;
	private var HOLD_FADE_OUT:Int = 1;
	private var HOLDING_FADE_IN:Int = 2;
	private var HOLDING:Int = 3;

	private var state:Int = 0;

	private var timer:FlxTimer;

	override public function create():Void
	{
		FlxG.camera.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		instruction = new FlxText(0,0,FlxG.width);
		instruction.setFormat("Handwriting",Std.int(FlxG.height/15),0xFF000000,"center");
		instruction.text = "TAKE OFF YOUR CLOTHES.";
		instruction.x = 0;
		instruction.y = Std.int(FlxG.height/2 - instruction.height/2);
		add(instruction);

		subtext = new FlxText(0,0,FlxG.width);
		subtext.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		subtext.text = "PRESS THE SPACE BAR WHEN YOU ARE NAKED.";
		subtext.x = 0;
		subtext.y = Std.int(3*FlxG.height/4 - subtext.height/2);
		add(subtext);

		FlxG.camera.fade(0xFFFFFFFF,2,true);
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
	}	


	private function handleInput():Void
	{
		if (!inputEnabled) return;

		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.camera.stopFX();
			inputEnabled = false;
			FlxG.camera.fade(0xFFFFFFFF,2,false,goToPlayState);
		}
	}


	private function handleTimerFinished(t:FlxTimer):Void
	{
		timerFinished = true;
	}


	private function goToPlayState():Void
	{
		FlxG.switchState(new PlayState());
	}
}