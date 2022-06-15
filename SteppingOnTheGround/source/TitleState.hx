package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;

import flixel.util.FlxTimer;


class TitleState extends FlxState
{
	private var inputEnabled:Bool = false;

	override public function create():Void
	{
		FlxG.camera.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		var title:FlxText = new FlxText(0,200,FlxG.width);
		title.setFormat("Handwriting",Std.int(FlxG.height/10),0xFF000000,"center");
		title.text = "STEPPING ON THE GROUND.";
		title.y = Std.int(FlxG.height/2 - title.height/2);
		add(title);

		var duration:FlxText = new FlxText(0,200,FlxG.width);
		duration.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		duration.text = "TIME: 30 MINUTES.";
		duration.y = Std.int(3*FlxG.height/4 - duration.height/2);
		add(duration);


		FlxG.camera.fade(0xFFFFFFFF,2,true,waitForFadeOut);
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
	}


	private function waitForFadeOut():Void
	{
		FlxTimer.start(3,fadeToNextState);
	}


	private function fadeToNextState(t:FlxTimer = null):Void
	{
		FlxG.camera.fade(0xFFFFFFFF,2,false,goToCheckNakedState);
	}

	private function goToCheckNakedState():Void
	{
		FlxG.switchState(new CheckNakedState());
	}
}