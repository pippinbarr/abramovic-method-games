package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxGroup;
import org.flixel.FlxG;

import org.flixel.util.FlxTimer;



enum State 
{
	FADE_IN;
	COMPLAINT_ENTRY;
	COMPLAINT_FADE_OUT;
	COMPLAINT_PAUSE;
	COMPLAINT_FADE_IN;
}


class PlayState extends FlxState
{
	private static var ACTIVITY_TIME:Int = 15 * 60;
	private static var CHARACTER_LIMIT:Int = 10000;// 150;
	private static var FADE_AMOUNT:Float = 0.05;
	private static var PAUSE_TIME:Float = 2;
	private static var ACTIVITY_CHECK_TIME:Float = 1 * 60;

	private var state:State;

	private var complaintUI:FlxGroup;
	private var complaintUIAlpha:Float = 0;
	private var complaintEntry:TextEntry;
	private var complaintLengthText:FlxText;
	private var complaintBox:FlxSprite;
	private var enterHelp:FlxText;

	private var timer:FlxTimer;

	private var activityTimer:FlxTimer;
	private var totalTimer:FlxTimer;

	private var complaints:Int = 0;
	private var complained:Bool = false;
	private var fifteenMinutesCompleted:Bool = false;

	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;

		FlxG.mouse.hide();

		var tree:FlxSprite = new FlxSprite(0,0,GameAssets.TREE_IMAGE_ARRAYS[GameAssets.resolution][Globals.selectedTree]);
		tree.setOriginToCorner();
		tree.antialiasing = true;
		tree.scale.x = tree.scale.y = GameAssets.scale;
		tree.width *= GameAssets.scale;
		tree.height *= GameAssets.scale;

		tree.x = Std.int(FlxG.width/2 - tree.width/2);
		tree.y = Std.int(FlxG.height - tree.height);

		complaintUI = new FlxGroup();

		complaintBox = new FlxSprite(0,0,GameAssets.COMPLAINT_BOX_IMAGES[GameAssets.resolution]);
		complaintBox.antialiasing = true;
		complaintBox.setOriginToCorner();
		complaintBox.scale.x = complaintBox.scale.y = GameAssets.scale;
		complaintBox.width *= GameAssets.scale;
		complaintBox.height *= GameAssets.scale;

		complaintBox.x = Std.int(FlxG.width/2 - complaintBox.width/2);
		complaintBox.y = Std.int(FlxG.height - FlxG.height/10 - complaintBox.height);

		complaintEntry = new TextEntry(Std.int(complaintBox.x + complaintBox.width/20),Std.int(complaintBox.y + complaintBox.height/8),Std.int(complaintBox.width - 2*complaintBox.width/20),CHARACTER_LIMIT,Std.int(complaintBox.height - complaintBox.height/4));
		complaintEntry.setFormat("Handwriting",Std.int(FlxG.height/24),0xFF000000,"left");
		complaintEntry.alpha = 0;

		complaintLengthText = new FlxText(Std.int(complaintBox.x),Std.int(complaintBox.y + complaintBox.height - complaintBox.height/5),Math.floor(complaintBox.width - complaintBox.width / 50),"0/" + CHARACTER_LIMIT);
		complaintLengthText.setFormat("Handwriting",Std.int(FlxG.height/24),0xff000000,"right");
		complaintLengthText.alpha = 0;
		complaintLengthText.visible = false;
		complaintUIAlpha = 0;

		enterHelp = new FlxText(Std.int(complaintBox.x + 3*complaintBox.width/4),Std.int(complaintBox.y + complaintBox.height + complaintBox.height/40),Std.int(complaintBox.width/4),"TYPE YOUR COMPLAINT AND PRESS ENTER TO COMPLAIN TO THE TREE.");
		enterHelp.setFormat("Handwriting",Std.int(FlxG.height/30),0xFF000000,"right");

		complaintUI.add(complaintBox);
		complaintUI.add(complaintEntry);
		complaintUI.add(complaintLengthText);
		complaintUI.add(enterHelp);

		complaintUI.setAll("alpha", 0);

		add(tree);
		add(complaintUI);

		timer = new FlxTimer();
		timer.start(PAUSE_TIME,1,complaintFadeIn);

		totalTimer = new FlxTimer();
		totalTimer.start(ACTIVITY_TIME,1,handleFifteenMinutes);

		activityTimer = new FlxTimer();
		activityTimer.start(ACTIVITY_CHECK_TIME,1,handleActivity);

		FlxG.fade(0xFFFFFFFF,2,true,fadedIn);

		state = FADE_IN;
	}


	private function fadedIn():Void
	{
		state = COMPLAINT_FADE_IN;
	}


	private function handleFifteenMinutes(t:FlxTimer):Void
	{
		fifteenMinutesCompleted = true;
	}


	private function handleActivity(t:FlxTimer):Void
	{
		if (!complained && !fifteenMinutesCompleted)
		{
			enterHelp.visible = true;
			enterHelp.flicker();
		}

		complained = false;
		activityTimer.start(ACTIVITY_CHECK_TIME,1,handleActivity);
	}


	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (FlxG.paused) return;

		super.update();

		// if (FlxG.keys.ESCAPE) FlxG.switchState(new MenuState());

		// complaintLengthText.text = "" + complaintEntry.text.length + "/" + CHARACTER_LIMIT;

		switch (state)
		{
			case FADE_IN:


			case COMPLAINT_ENTRY:
			if (complaintEntry.entered)
			{
				complained = true;
				complaintEntry.disable();
				complaints++;

				state = COMPLAINT_FADE_OUT;	
			}

			case COMPLAINT_FADE_OUT:
			complaintUIAlpha = Math.max(complaintUIAlpha - FADE_AMOUNT, 0);
			complaintUI.setAll("alpha",complaintUIAlpha);
			if (complaintUIAlpha <= 0)
			{
				complaintUIAlpha = 0;
				complaintEntry.text = "";
				state = COMPLAINT_PAUSE;
				timer.start(PAUSE_TIME,1,complaintFadeIn);
			}

			case COMPLAINT_FADE_IN:
			if (complaints >= 2)
			{
				enterHelp.visible = false;
			}

			complaintUIAlpha = Math.min(complaintUIAlpha + FADE_AMOUNT, 1.0);
			complaintUI.setAll("alpha",complaintUIAlpha);

			if (complaintUIAlpha >= 1)
			{
				state = COMPLAINT_ENTRY;
				complaintEntry.enable();
			}

			case COMPLAINT_PAUSE:
			{}
		}
	}	


	private function complaintFadeIn(t:FlxTimer):Void
	{
		state = COMPLAINT_FADE_IN;
	}
}