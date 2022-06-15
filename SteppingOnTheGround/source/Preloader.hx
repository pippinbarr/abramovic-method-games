import flixel.system.FlxPreloader;
import flixel.text.FlxText;

import flash.Lib;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.Font;


class Preloader extends FlxPreloader
{

	private var MIN_WIDTH:Float = 800;
	private var MIN_HEIGHT:Float = 450;

	private var _bg:Bitmap;
	private var _loadingText:TextField;
	private var _loadingBar:Bitmap;

	private var ratioX:Int = 16;
	private var ratioY:Int = 9;

	private var _preBuffer:Sprite;

	private var _loaded:Bool = false;

	override private function create():Void
	{
		_min = 6000000;

		_buffer = new Sprite();
		// _buffer.height = 1280;
		// _buffer.width = 720;
		// addChild(_buffer);

		_bg = new Bitmap(new BitmapData(1280,720,false,0xffffff));
		_bg.x = 0; _bg.y = 0;


		_loadingText = new TextField();
		_loadingText.width = 1280;
		_loadingText.height = 50;
		_loadingText.selectable = false;
		_loadingText.antiAliasType = ADVANCED;
		_loadingText.defaultTextFormat = new TextFormat("Helvetica,Arial",48,0x000000,null,null,null,null,null,flash.text.TextFormatAlign.CENTER);
		_loadingText.text = "LOADING...\n0%";
		_loadingText.x = 1280/2 - _loadingText.width/2;
		_loadingText.y = 720/2 - _loadingText.height/2;

		_loadingText.alpha = 0;

		_buffer.addChild(_bg);
		_buffer.addChild(_loadingText);

		addChild(_buffer);
	}


	override private function update(Percent:Float):Void
	{
		var ActualPercent:Float = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;

		_loadingText.alpha = ActualPercent;

		if (ActualPercent >= 1.0 && !_loaded)
		{
			_loadingText.text = "LOADED. CLICK TO PLAY.";
			_loaded = true;
			Lib.current.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,mouseDown);
		}

		scaleGame();
		centerGame();
	}


	private function mouseDown(e:flash.events.MouseEvent):Void 
	{
		Lib.current.stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN,mouseDown);
		Lib.current.stage.focus = null;
		_min = 1000;
	}


	private function scaleGame():Void
	{
		var stageWidth = Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;

		var newScale:Float = 1;

		if (stageWidth/ratioX > stageHeight/ratioY)
		{
			newScale = stageHeight / 720;
		}
		else if (stageWidth/ratioX < stageHeight/ratioY)
		{
			newScale = stageWidth / 1280;
		}

		if (newScale < MIN_WIDTH / 1280)
		{
			// trace("Scale is too small on width.");
			newScale = MIN_WIDTH / 1280;
		}
		else if (newScale < MIN_HEIGHT / 720)
		{
			// trace("Scale is too small on height.");
			newScale = MIN_HEIGHT / 720;
		}

		// SCALE IT
		_buffer.scaleX = _buffer.scaleY = newScale;
	}


	private function centerGame():Void
	{
		var stageWidth = Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;

		// CENTER IT
		_buffer.x = Std.int(0.5 * (stageWidth - _buffer.width));
		_buffer.y = Std.int(0.5 * (stageHeight - _buffer.height));	
	}
}
