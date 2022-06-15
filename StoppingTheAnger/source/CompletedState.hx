package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;


class CompletedState extends FlxState
{
	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		var complete:FlxText = new FlxText(0,0,FlxG.width);
		complete.setFormat("Handwriting",Std.int(FlxG.height/15),0xFF000000,"center");
		complete.text = "EXERCISE COMPLETE.";
		complete.x = 0;
		complete.y = Std.int(FlxG.height/2 - complete.height/2);
		add(complete);

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