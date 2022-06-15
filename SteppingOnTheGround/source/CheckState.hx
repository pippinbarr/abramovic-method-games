package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;

import flixel.util.FlxTimer;

import flash.events.Event;

class CheckState extends FlxState
{
	private var inputEnabled:Bool = true;

	override public function create():Void
	{
		FlxG.camera.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		var check:FlxText = new FlxText(0,0,FlxG.width);
		check.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		check.text = "";
		check.x = 0;
		check.y = Std.int(FlxG.height/2 - check.height/2);
		add(check);

		var now:Date = Date.now();

		// trace(now);
 		// trace(now.getHours());

		if (now.getHours() == 6)
		{
			// The time is right
			FlxG.switchState(new TitleState());
		}
		else
		{
			// The time is wrong
			check.text = "THIS EXERCISE IS TO BE CONDUCTED BETWEEN 6AM AND 7AM.\n\nPLEASE TRY AGAIN THEN.";
		}

		FlxG.stage.dispatchEvent(new Event(Event.RESIZE));

		FlxG.camera.fade(0xFFffffff,2,true);
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
	}
}