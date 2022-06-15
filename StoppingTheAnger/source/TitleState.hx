package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;

import flash.events.MouseEvent;


class TitleState extends FlxState
{
	private var inputEnabled:Bool = false;
	private var timer:FlxTimer;

	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		var title:FlxText = new FlxText(0,200,FlxG.width);
		title.setFormat("Handwriting",Std.int(FlxG.height/10),0xFF000000,"center");
		title.text = "STOPPING THE ANGER.";
		title.y = Std.int(FlxG.height/2 - title.height/2);
		add(title);

		var duration:FlxText = new FlxText(0,200,FlxG.width);
		duration.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		duration.text = "";
		duration.y = Std.int(3*FlxG.height/4 - duration.height/2);
		add(duration);


		timer = new FlxTimer();

		FlxG.fade(0xFFFFFFFF,2,true,waitForFadeOut);
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
		timer.start(3,1,fadeToNextState);
	}


	private function fadeToNextState(t:FlxTimer = null):Void
	{
		FlxG.fade(0xFFFFFFFF,2,false,goToPlayState);
	}

	private function goToPlayState():Void
	{
		FlxG.switchState(new PlayState());
	}
}