package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxGroup;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;


class PlayState extends FlxState
{

	private var timer:FlxTimer;


	override public function create():Void
	{
		var random:Float = Math.random();

		if (Globals.selectedColour == 0)
		FlxG.bgColor = 0xFFFF0000;
		else if (Globals.selectedColour == 1)
		FlxG.bgColor = 0xFFFFFF00;
		else
		FlxG.bgColor = 0xFF0000FF;

		FlxG.mouse.hide();

		timer = new FlxTimer();
		timer.start(60 * 60,1,exerciseCompleted);
		// timer.start(5,1,exerciseCompleted);

		FlxG.fade(0xFFFFFFFF,2,true);
	}


	private function exerciseCompleted(t:FlxTimer):Void
	{
		FlxG.fade(0xFFFFFFFF,2,false,switchToCompleteState);
	}


	private function switchToCompleteState():Void
	{
		FlxG.switchState(new CompletedState());
	}

	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (FlxG.paused) return;

		super.update();
	}	
}