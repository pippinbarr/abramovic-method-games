package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;

import flash.events.MouseEvent;
import flash.events.Event;
import flash.geom.Rectangle;

class CheckState extends FlxState
{
	private var inputEnabled:Bool = true;

	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		var check:FlxText = new FlxText(0,200,FlxG.width);
		check.setFormat("Handwriting",FlxG.height/10,0xFF000000,"center");
		check.text = "ARE YOU ANGRY?\n\nY/N";

		check.y = FlxG.height/2 - check.height/2;
		add(check);

		FlxG.stage.dispatchEvent(new Event(Event.RESIZE));

		FlxG.fade(0xFFffffff,2,true);

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

		if (FlxG.keys.justPressed("Y"))
		{
			FlxG.camera.stopFX();

			FlxG.fade(0xFFFFFFFF,2,false,goToTitleState);
			inputEnabled = false;		
		}
		else if (FlxG.keys.justPressed("N"))
		{
			FlxG.camera.stopFX();

			FlxG.fade(0xFFFFFFFF,2,false,goToCompletedState);
			inputEnabled = false;		
		}
	}

	private function goToTitleState():Void
	{
		FlxG.switchState(new TitleState());
	}

	private function goToCompletedState():Void
	{
		FlxG.switchState(new CompletedState());
	}
}