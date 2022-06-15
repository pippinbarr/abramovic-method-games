package;


import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import org.flixel.FlxText;
import org.flixel.FlxG;


class TextEntry extends FlxText
{
	private static var VALID_CHARACTERS:String = "" +
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
	"1234567890" + 
	"!@#$%&*()/\\<>.,;:\'?-=+~€£ ";

	public var entered:Bool = false;
	private var maxLength:Int;
	private var maxHeight:Float;
	public var enabled:Bool = false;

	public function new(X:Float,Y:Float,Width:Int,MaxLength:Int,MaxHeight:Float=1000)
	{			
		super(X,Y,Width,"",true);

		maxLength = MaxLength;
		maxHeight = MaxHeight;
		enabled = false;
	}


	public override function update():Void 
	{
		super.update();						
	}


	public function enable():Void
	{
		enabled = true;
		
		text = "";
		entered = false;
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN,textEntrykeyDown);
	}


	public function disable():Void
	{
		enabled = false;
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,textEntrykeyDown);
	}


	private function textEntrykeyDown(e:KeyboardEvent):Void
	{
		if (!enabled) return;
		if (FlxG.paused) return;


		if (e.keyCode == Keyboard.ENTER && text != "")
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,textEntrykeyDown);
			entered = true;
		}
		else if (e.keyCode == Keyboard.BACKSPACE && text.length > 0) 
		{
			text = text.substring(0,text.length-1);
		}
		else
		{	
			var character:String = String.fromCharCode(e.charCode);
			character = character.toUpperCase();				
			if (VALID_CHARACTERS.indexOf(character) != -1 && text.length < maxLength) 
			{
				text += character;
			}
		}

		// if (this.height > maxHeight)
		if (_textField.numLines > 6)
		{
			text = text.substring(0,text.length-1);
		}
	}



	public override function destroy():Void 
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,textEntrykeyDown);

		super.destroy();
	}
}
