package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;

import flash.events.Event;


class TitleState extends FlxState
{
	private var inputEnabled:Bool = false;
	private var timer:FlxTimer;

	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		var title:FlxText = new FlxText(0,0,FlxG.width);
		title.setFormat("Handwriting",Std.int(FlxG.height/10),0xFF000000,"center");
		title.text = "COUNTING THE RICE AND SESAME.";
		title.x = 0;
		title.y = Std.int(FlxG.height/2 - title.height/2);
		add(title);

		timer = new FlxTimer();


		FlxG.fade(0xFFFFFFFF,2,true);
		timer.start(2,1,waitForFadeOut);

		FlxG.stage.dispatchEvent(new Event(Event.RESIZE));

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


	private function waitForFadeOut(t:FlxTimer = null):Void
	{
		timer = new FlxTimer();
		timer.start(2,1,fadeToNextState);
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