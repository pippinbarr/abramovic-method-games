package;

import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.StageDisplayState;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.Font;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import org.flixel.FlxGame;
import org.flixel.FlxG;
import org.flixel.FlxCamera;


@:font("assets/ttf/AllCapsFont.ttf")
class HandwritingFont extends flash.text.Font {}


class ProjectClass extends FlxGame
{	
	private var MIN_WIDTH:Float = 800;
	private var MIN_HEIGHT:Float = 450;

	private var scale:Float = 1;
	private var ratioX:Int;
	private var ratioY:Int;

	private var fullscreenSprite:Sprite;
	private var fullscreenTextField:TextField;
	private var fullscreenTextFormat:TextFormat;

	private var focusSprite:Sprite;
	private var focusField:TextField;
	private var focusTextFormat:TextFormat;

	private var text:TextField;

	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		scale = 1;

		ratioX = 16;
		ratioY = 9;

		stageHeight = Std.int(stageWidth/16 * 9);

		super(1280, 720, CheckState, scale, 30, 30);

		GameAssets.resolution = GameAssets.RESOLUTION_960P;
		GameAssets.scale = FlxG.height / 960;


		Lib.current.stage.addEventListener(Event.RESIZE, window_resized);

		#if FULLSCREEN_APP
		addFullScreen();
		#else
		addClickToFocus();		
		#end


		scaleGame();
	}

	private function addFullScreen():Void
	{
		Lib.current.stage.addEventListener(MouseEvent.CLICK, onClick);

		fullscreenSprite = new Sprite();

		var blackBitmap:Bitmap = new Bitmap(new BitmapData(1280,720,false,0xffffff));
		fullscreenSprite.addChild(blackBitmap);

		text = new TextField();
		text.width = 1280;
		text.height = 50;
		text.antiAliasType = ADVANCED;
		text.selectable = false;
		text.defaultTextFormat = new TextFormat("Helvetica,Arial",48,0x000000,null,null,null,null,null,flash.text.TextFormatAlign.CENTER);
		text.text = "CLICK HERE TO PLAY IN FULL SCREEN.";
		text.x = 1280/2 - text.width/2;
		text.y = 720/2 - text.height/2;

		fullscreenSprite.addChild(text);

		fullscreenSprite.alpha = 0.9;
		fullscreenSprite.visible = false;


		Lib.current.stage.addChild(fullscreenSprite);
	}

	private function addClickToFocus():Void
	{
		focusSprite = new Sprite();

		var blackBitmap:Bitmap = new Bitmap(new BitmapData(1280,720,false,0xffffff));
		focusSprite.addChild(blackBitmap);

		focusField = new TextField();
		focusField.width = 1280;
		focusField.height = 50;
		focusField.antiAliasType = ADVANCED;
		focusField.selectable = false;
		focusField.defaultTextFormat = new TextFormat("Helvetica,Arial",48,0x000000,null,null,null,null,null,flash.text.TextFormatAlign.CENTER);
		focusField.text = "CLICK TO PLAY.";
		focusField.x = 1280/2 - focusField.width/2;
		focusField.y = 720/2 - focusField.height/2;

		focusSprite.addChild(focusField);

		focusSprite.alpha = 0.9;
		focusSprite.visible = false;


		Lib.current.stage.addChild(focusSprite);
	}

	override public function onFocusLost(e:Event = null):Void
	{
		#if !FULLSCREEN_APP
		focusSprite.visible = true;
		#end
	}


	override public function onFocus(e:Event = null):Void
	{
		#if !FULLSCREEN_APP
		focusSprite.visible = false;
		#end
	}

	private function onClick(e:MouseEvent):Void
	{
		if (FlxG.stage.displayState != FULL_SCREEN &&
			FlxG.stage.displayState != FULL_SCREEN_INTERACTIVE)
		{
			FlxG.stage.displayState = FULL_SCREEN_INTERACTIVE;
		}
	}

	private function window_resized(e:Event = null):Void
	{
		scaleGame();
		centerGame();

		#if FULLSCREEN_APP
		if (FlxG.stage.displayState != FULL_SCREEN &&
			FlxG.stage.displayState != FULL_SCREEN_INTERACTIVE)
		{
			FlxG.mouse.useSystemCursor = true;
			fullscreenSprite.visible = true;
			FlxG.paused = true;
		}
		else
		{
			FlxG.mouse.useSystemCursor = false;
			fullscreenSprite.visible = false;
			FlxG.paused = false;
		}
		#end
	}

	private function scaleGame():Void
	{
		var stageWidth = Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;

		var newScale:Float = 1;

		if (stageWidth/ratioX > stageHeight/ratioY)
		{
			newScale = stageHeight / FlxG.height;
		}
		else if (stageWidth/ratioX < stageHeight/ratioY)
		{
			newScale = stageWidth / FlxG.width;
		}

		if (newScale < MIN_WIDTH / FlxG.width)
		{
			// trace("Scale is too small on width.");
			newScale = MIN_WIDTH / FlxG.width;
		}
		else if (newScale < MIN_HEIGHT / FlxG.height)
		{
			// trace("Scale is too small on height.");
			newScale = MIN_HEIGHT / FlxG.height;
		}

		// SCALE IT
		this.scaleX = this.scaleY = newScale;
		
		#if !FULLSCREEN_APP
		focusSprite.scaleX = focusSprite.scaleY = newScale;
		#else
		fullscreenSprite.scaleX = fullscreenSprite.scaleY = newScale;
		#end
	}


	private function centerGame():Void
	{
		var stageWidth = Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;

		// CENTER IT
		this.x = Std.int(0.5 * (stageWidth - this.width));
		this.y = Std.int(0.5 * (stageHeight - this.height));	

		#if !FULLSCREEN_APP
		focusSprite.x = this.x;
		focusSprite.y = this.y;
		#else
		fullscreenSprite.x = this.x;
		fullscreenSprite.y = this.y;	
		#end
	}
}
