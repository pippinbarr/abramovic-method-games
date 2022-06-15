package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;


class CompletedState extends FlxState
{
	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;

		FlxG.mouse.hide();

		var complete:FlxText = new FlxText(0,200,FlxG.width);
		complete.setFormat("Handwriting",36,0xFF000000,"center");
		complete.text = "EXERCISE COMPLETE.";
		complete.y = FlxG.height/2 - complete.height/2;
		add(complete);

		if (!PlayState.save.bind("RiceAndSesameSave"))
		{
			// Oops, we couldn't load the save, so I guess we just start up again?
		}
		else
		{
			PlayState.save.data.totalProcessed = 0;
			PlayState.save.close();
		}


		FlxG.fade(0xFFFFFFFF,2,true);
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