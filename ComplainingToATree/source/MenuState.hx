package;

import openfl.Assets;

import org.flixel.FlxState;
import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxG;

import flash.display.Bitmap;
import flash.display.BitmapData;



class MenuState extends FlxState
{
	private var instructions:FlxText;
	private var instructions2:FlxText;

	private var complaint:TextEntry;
	private var inputEnabled:Bool = true;

	private var trees:Array<FlxSprite>;
	private var selectedTree:Int = 2;


	override public function create():Void
	{
		super.create();

		FlxG.bgColor = 0xFFFFFFFF;
		FlxG.camera.antialiasing = true;
		FlxG.mouse.hide();

		trees = new Array();

		for (i in 0...GameAssets.TREE_SELECT_IMAGE_ARRAYS[GameAssets.resolution].length)
		{
			var tree:FlxSprite = new FlxSprite(
				0,
				0,
				GameAssets.TREE_SELECT_IMAGE_ARRAYS[GameAssets.resolution][i]
				);
			tree.antialiasing = true;
			tree.setOriginToCorner();
			tree.scale.x = tree.scale.y = GameAssets.scale;
			tree.width *= GameAssets.scale;
			tree.height *= GameAssets.scale;

			tree.x = Std.int((i + 1) * FlxG.width/6 - tree.width/2);
			tree.y = Std.int(FlxG.height/2 - tree.height/2);
			if (i != 2) tree.alpha = 0.5;

			trees.push(tree);
			add(tree);
		}


		instructions = new FlxText(0,Std.int(FlxG.height/10),FlxG.width);
		instructions.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		instructions.text = "CHOOSE A TREE WITH THE ARROW KEYS...";

		instructions2 = new FlxText(0,Std.int(9 * FlxG.height/10),FlxG.width);
		instructions2.setFormat("Handwriting",Std.int(FlxG.height/20),0xFF000000,"center");
		instructions2.text = "SELECT YOUR CHOSEN TREE WITH ENTER.";

		
		add(instructions);
		add(instructions2);

		FlxG.fade(0xFFFFFFFF,2,true);
	}

	
	override public function destroy():Void
	{
		instructions.destroy();
		instructions2.destroy();

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
			selectedTree -= 1;
			if (selectedTree < 0) selectedTree = trees.length - 1;
		}
		else if (FlxG.keys.justPressed("RIGHT"))
		{
			selectedTree += 1;
			if (selectedTree >= trees.length) selectedTree = 0;
		}
		else if (FlxG.keys.justPressed("ENTER"))
		{
			FlxG.camera.stopFX();

			for (i in 0...trees.length)
			{
				if (i != selectedTree)
				{
					trees[i].visible = false;
				}
			}
			instructions.visible = false;
			instructions2.visible = false;

			
			FlxG.fade(0xFFFFFFFF,2,false,goToPlayState);
			inputEnabled = false;
		}

	}


	private function goToPlayState():Void
	{
		Globals.selectedTree = selectedTree;
		FlxG.switchState(new PlayState());
	}


	private function handleInterface():Void
	{
		for (i in 0...trees.length)
		{
			if (i == selectedTree)
			{
				trees[i].alpha = 1;
			}
			else
			{
				trees[i].alpha = 0.5;
			}
		}

	}
}