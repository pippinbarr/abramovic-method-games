package;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;


class MenuState extends FlxState
{
	// private var inputEnabled:Bool = false;
	private var inputEnabled:Bool = true;


	private var instructions:FlxText;
	private var instructions2:FlxText;
	private var underline:FlxSprite;

	private var red:FlxSprite;
	private var yellow:FlxSprite;
	private var blue:FlxSprite;

	private var colours:Array<FlxSprite>;
	private var selectedColour:Int = 1;


	override public function create():Void
	{
		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		instructions = new FlxText(0,Std.int(FlxG.height/10),FlxG.width);
		instructions.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		instructions.text = "CHOOSE A COLOR WITH THE ARROW KEYS...";
		instructions.y -= instructions.height;

		instructions2 = new FlxText(0,Std.int(9 * FlxG.height/10),FlxG.width);
		instructions2.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		instructions2.text = "SELECT YOUR CHOSEN COLOR WITH ENTER.";


		red = new FlxSprite(0,0);
		red.makeGraphic(Std.int(FlxG.width/5),Std.int(FlxG.width/5),0xFFFF0000);
		red.x = Std.int(1 * FlxG.width / 4 - red.width/2);
		red.y = Std.int(FlxG.height / 2 - red.height/2);

		yellow = new FlxSprite(0,0);
		yellow.makeGraphic(Std.int(FlxG.width/5),Std.int(FlxG.width/5),0xFFFFFF00);
		yellow.x = Std.int(2 * FlxG.width / 4 - yellow.width/2);
		yellow.y = Std.int(FlxG.height / 2 - yellow.height/2);


		blue = new FlxSprite(0,0);
		blue.makeGraphic(Std.int(FlxG.width/5),Std.int(FlxG.width/5),0xFF0000FF);
		blue.x = Std.int(3 * FlxG.width / 4 - blue.width/2);
		blue.y = Std.int(FlxG.height / 2 - blue.height/2);

		underline = new FlxSprite(0,0,GameAssets.UNDERLINE_IMAGES[GameAssets.resolution]);
		underline.setOriginToCorner();
		underline.scale.x = underline.scale.y = GameAssets.scale;
		underline.width *= GameAssets.scale;
		underline.height *= GameAssets.scale;

		underline.x = Std.int(yellow.x + yellow.width/2 - underline.width/2);
		underline.y = Std.int(yellow.y + yellow.height + yellow.height / 10);

		colours = new Array();
		colours.push(red);
		colours.push(yellow);
		colours.push(blue);

		add(instructions);
		add(instructions2);

		add(red);
		add(yellow);
		add(blue);

		add(underline);

		FlxG.fade(0xFFFFFFFF,2,true,handleFadedIn);

	}

	private function handleFadedIn():Void
	{
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
		handleInterface();

	}	


	private function handleInput():Void
	{
		if (!inputEnabled) return;

		if (FlxG.keys.justPressed("LEFT"))
		{
			selectedColour -= 1;
			if (selectedColour < 0) selectedColour = colours.length - 1;
		}
		else if (FlxG.keys.justPressed("RIGHT"))
		{
			selectedColour += 1;
			if (selectedColour >= colours.length) selectedColour = 0;
		}
		else if (FlxG.keys.justPressed("ENTER"))
		{
			FlxG.camera.stopFX();
			for (i in 0...colours.length)
			{
				if (i != selectedColour)
				{
					colours[i].visible = false;
				}
			}
			instructions.visible = false;
			instructions2.visible = false;
			underline.visible = false;

			FlxG.fade(0xFFFFFFFF,2,false,goToPlayState);
			inputEnabled = false;
		}
	}


	private function handleInterface():Void
	{
		for (i in 0...colours.length)
		{
			if (i == selectedColour)
			{
				underline.x = Std.int(colours[selectedColour].x + colours[selectedColour].width/2 - underline.width/2);
				underline.y = Std.int(colours[selectedColour].y + colours[selectedColour].height + colours[selectedColour].height/10);
				return;
			}
		}
	}


	private function goToPlayState():Void
	{
		Globals.selectedColour = selectedColour;
		FlxG.switchState(new PlayState());
	}
}