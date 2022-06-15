package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("Beep", __ASSET__assets_data_beep_mp3);
		type.set ("Beep", AssetType.SOUND);
		className.set ("assets/data/autotiles.png", __ASSET__assets_data_autotiles_png);
		type.set ("assets/data/autotiles.png", AssetType.IMAGE);
		className.set ("assets/data/autotiles_alt.png", __ASSET__assets_data_autotiles_alt_png);
		type.set ("assets/data/autotiles_alt.png", AssetType.IMAGE);
		className.set ("assets/data/base.png", __ASSET__assets_data_base_png);
		type.set ("assets/data/base.png", AssetType.IMAGE);
		className.set ("assets/data/beep.mp3", __ASSET__assets_data_beep_mp4);
		type.set ("assets/data/beep.mp3", AssetType.MUSIC);
		className.set ("assets/data/button.png", __ASSET__assets_data_button_png);
		type.set ("assets/data/button.png", AssetType.IMAGE);
		className.set ("assets/data/button_a.png", __ASSET__assets_data_button_a_png);
		type.set ("assets/data/button_a.png", AssetType.IMAGE);
		className.set ("assets/data/button_b.png", __ASSET__assets_data_button_b_png);
		type.set ("assets/data/button_b.png", AssetType.IMAGE);
		className.set ("assets/data/button_c.png", __ASSET__assets_data_button_c_png);
		type.set ("assets/data/button_c.png", AssetType.IMAGE);
		className.set ("assets/data/button_down.png", __ASSET__assets_data_button_down_png);
		type.set ("assets/data/button_down.png", AssetType.IMAGE);
		className.set ("assets/data/button_left.png", __ASSET__assets_data_button_left_png);
		type.set ("assets/data/button_left.png", AssetType.IMAGE);
		className.set ("assets/data/button_right.png", __ASSET__assets_data_button_right_png);
		type.set ("assets/data/button_right.png", AssetType.IMAGE);
		className.set ("assets/data/button_up.png", __ASSET__assets_data_button_up_png);
		type.set ("assets/data/button_up.png", AssetType.IMAGE);
		className.set ("assets/data/button_x.png", __ASSET__assets_data_button_x_png);
		type.set ("assets/data/button_x.png", AssetType.IMAGE);
		className.set ("assets/data/button_y.png", __ASSET__assets_data_button_y_png);
		type.set ("assets/data/button_y.png", AssetType.IMAGE);
		className.set ("assets/data/courier.ttf", __ASSET__assets_data_courier_ttf);
		type.set ("assets/data/courier.ttf", AssetType.FONT);
		className.set ("assets/data/cursor.png", __ASSET__assets_data_cursor_png);
		type.set ("assets/data/cursor.png", AssetType.IMAGE);
		className.set ("assets/data/default.png", __ASSET__assets_data_default_png);
		type.set ("assets/data/default.png", AssetType.IMAGE);
		className.set ("assets/data/fontData10pt.png", __ASSET__assets_data_fontdata10pt_png);
		type.set ("assets/data/fontData10pt.png", AssetType.IMAGE);
		className.set ("assets/data/fontData11pt.png", __ASSET__assets_data_fontdata11pt_png);
		type.set ("assets/data/fontData11pt.png", AssetType.IMAGE);
		className.set ("assets/data/handle.png", __ASSET__assets_data_handle_png);
		type.set ("assets/data/handle.png", AssetType.IMAGE);
		className.set ("assets/data/logo.png", __ASSET__assets_data_logo_png);
		type.set ("assets/data/logo.png", AssetType.IMAGE);
		className.set ("assets/data/logo_corners.png", __ASSET__assets_data_logo_corners_png);
		type.set ("assets/data/logo_corners.png", AssetType.IMAGE);
		className.set ("assets/data/logo_light.png", __ASSET__assets_data_logo_light_png);
		type.set ("assets/data/logo_light.png", AssetType.IMAGE);
		className.set ("assets/data/nokiafc22.ttf", __ASSET__assets_data_nokiafc22_ttf);
		type.set ("assets/data/nokiafc22.ttf", AssetType.FONT);
		className.set ("assets/data/stick.png", __ASSET__assets_data_stick_png);
		type.set ("assets/data/stick.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/flixel.png", __ASSET__assets_data_vcr_flixel_png);
		type.set ("assets/data/vcr/flixel.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/open.png", __ASSET__assets_data_vcr_open_png);
		type.set ("assets/data/vcr/open.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/pause.png", __ASSET__assets_data_vcr_pause_png);
		type.set ("assets/data/vcr/pause.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/play.png", __ASSET__assets_data_vcr_play_png);
		type.set ("assets/data/vcr/play.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/record_off.png", __ASSET__assets_data_vcr_record_off_png);
		type.set ("assets/data/vcr/record_off.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/record_on.png", __ASSET__assets_data_vcr_record_on_png);
		type.set ("assets/data/vcr/record_on.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/restart.png", __ASSET__assets_data_vcr_restart_png);
		type.set ("assets/data/vcr/restart.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/step.png", __ASSET__assets_data_vcr_step_png);
		type.set ("assets/data/vcr/step.png", AssetType.IMAGE);
		className.set ("assets/data/vcr/stop.png", __ASSET__assets_data_vcr_stop_png);
		type.set ("assets/data/vcr/stop.png", AssetType.IMAGE);
		className.set ("assets/data/vis/bounds.png", __ASSET__assets_data_vis_bounds_png);
		type.set ("assets/data/vis/bounds.png", AssetType.IMAGE);
		className.set ("assets/HaxeFlixel.svg", __ASSET__assets_haxeflixel_svg);
		type.set ("assets/HaxeFlixel.svg", AssetType.TEXT);
		className.set ("assets/icon/icon1024.png", __ASSET__assets_icon_icon1024_png);
		type.set ("assets/icon/icon1024.png", AssetType.IMAGE);
		className.set ("assets/icon/icon128.png", __ASSET__assets_icon_icon128_png);
		type.set ("assets/icon/icon128.png", AssetType.IMAGE);
		className.set ("assets/icon/icon16.png", __ASSET__assets_icon_icon16_png);
		type.set ("assets/icon/icon16.png", AssetType.IMAGE);
		className.set ("assets/icon/icon256.png", __ASSET__assets_icon_icon256_png);
		type.set ("assets/icon/icon256.png", AssetType.IMAGE);
		className.set ("assets/icon/icon32.png", __ASSET__assets_icon_icon32_png);
		type.set ("assets/icon/icon32.png", AssetType.IMAGE);
		className.set ("assets/icon/icon48.png", __ASSET__assets_icon_icon48_png);
		type.set ("assets/icon/icon48.png", AssetType.IMAGE);
		className.set ("assets/icon/icon512.png", __ASSET__assets_icon_icon512_png);
		type.set ("assets/icon/icon512.png", AssetType.IMAGE);
		className.set ("assets/icon/icon64.png", __ASSET__assets_icon_icon64_png);
		type.set ("assets/icon/icon64.png", AssetType.IMAGE);
		className.set ("assets/png/960p/bird_sheet_960p.png", __ASSET__assets_png_960p_bird_sheet_960p_png);
		type.set ("assets/png/960p/bird_sheet_960p.png", AssetType.IMAGE);
		className.set ("assets/png/960p/birds_960p.png", __ASSET__assets_png_960p_birds_960p_png);
		type.set ("assets/png/960p/birds_960p.png", AssetType.IMAGE);
		className.set ("assets/png/960p/rain_960p.png", __ASSET__assets_png_960p_rain_960p_png);
		type.set ("assets/png/960p/rain_960p.png", AssetType.IMAGE);
		className.set ("assets/png/960p/snow_1_960p.png", __ASSET__assets_png_960p_snow_1_960p_png);
		type.set ("assets/png/960p/snow_1_960p.png", AssetType.IMAGE);
		className.set ("assets/png/960p/snow_2_960p.png", __ASSET__assets_png_960p_snow_2_960p_png);
		type.set ("assets/png/960p/snow_2_960p.png", AssetType.IMAGE);
		className.set ("assets/png/960p/wind_960p.png", __ASSET__assets_png_960p_wind_960p_png);
		type.set ("assets/png/960p/wind_960p.png", AssetType.IMAGE);
		className.set ("assets/ttf/AllCapsFont.ttf", __ASSET__assets_ttf_allcapsfont_ttf);
		type.set ("assets/ttf/AllCapsFont.ttf", AssetType.FONT);
		className.set ("Handwriting", __ASSET__assets_ttf_allcapsfont_ttf1);
		type.set ("Handwriting", AssetType.FONT);
		className.set ("flixel/img/debugger/buttons/console.png", __ASSET__flixel_img_debugger_buttons_console_png);
		type.set ("flixel/img/debugger/buttons/console.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/logDebug.png", __ASSET__flixel_img_debugger_buttons_logdebug_png);
		type.set ("flixel/img/debugger/buttons/logDebug.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/open.png", __ASSET__flixel_img_debugger_buttons_open_png);
		type.set ("flixel/img/debugger/buttons/open.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/pause.png", __ASSET__flixel_img_debugger_buttons_pause_png);
		type.set ("flixel/img/debugger/buttons/pause.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/play.png", __ASSET__flixel_img_debugger_buttons_play_png);
		type.set ("flixel/img/debugger/buttons/play.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/record_off.png", __ASSET__flixel_img_debugger_buttons_record_off_png);
		type.set ("flixel/img/debugger/buttons/record_off.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/record_on.png", __ASSET__flixel_img_debugger_buttons_record_on_png);
		type.set ("flixel/img/debugger/buttons/record_on.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/restart.png", __ASSET__flixel_img_debugger_buttons_restart_png);
		type.set ("flixel/img/debugger/buttons/restart.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/statsDebug.png", __ASSET__flixel_img_debugger_buttons_statsdebug_png);
		type.set ("flixel/img/debugger/buttons/statsDebug.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/step.png", __ASSET__flixel_img_debugger_buttons_step_png);
		type.set ("flixel/img/debugger/buttons/step.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/stop.png", __ASSET__flixel_img_debugger_buttons_stop_png);
		type.set ("flixel/img/debugger/buttons/stop.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/visualDebug.png", __ASSET__flixel_img_debugger_buttons_visualdebug_png);
		type.set ("flixel/img/debugger/buttons/visualDebug.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/buttons/watchDebug.png", __ASSET__flixel_img_debugger_buttons_watchdebug_png);
		type.set ("flixel/img/debugger/buttons/watchDebug.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/flixel.png", __ASSET__flixel_img_debugger_flixel_png);
		type.set ("flixel/img/debugger/flixel.png", AssetType.IMAGE);
		className.set ("flixel/img/debugger/windowHandle.png", __ASSET__flixel_img_debugger_windowhandle_png);
		type.set ("flixel/img/debugger/windowHandle.png", AssetType.IMAGE);
		className.set ("flixel/img/logo/default.png", __ASSET__flixel_img_logo_default_png);
		type.set ("flixel/img/logo/default.png", AssetType.IMAGE);
		className.set ("flixel/img/logo/HaxeFlixel.svg", __ASSET__flixel_img_logo_haxeflixel_svg);
		type.set ("flixel/img/logo/HaxeFlixel.svg", AssetType.TEXT);
		className.set ("flixel/img/logo/logo.png", __ASSET__flixel_img_logo_logo_png);
		type.set ("flixel/img/logo/logo.png", AssetType.IMAGE);
		className.set ("flixel/img/preloader/corners.png", __ASSET__flixel_img_preloader_corners_png);
		type.set ("flixel/img/preloader/corners.png", AssetType.IMAGE);
		className.set ("flixel/img/preloader/light.png", __ASSET__flixel_img_preloader_light_png);
		type.set ("flixel/img/preloader/light.png", AssetType.IMAGE);
		className.set ("flixel/img/tile/autotiles.png", __ASSET__flixel_img_tile_autotiles_png);
		type.set ("flixel/img/tile/autotiles.png", AssetType.IMAGE);
		className.set ("flixel/img/tile/autotiles_alt.png", __ASSET__flixel_img_tile_autotiles_alt_png);
		type.set ("flixel/img/tile/autotiles_alt.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/analog/base.png", __ASSET__flixel_img_ui_analog_base_png);
		type.set ("flixel/img/ui/analog/base.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/analog/thumb.png", __ASSET__flixel_img_ui_analog_thumb_png);
		type.set ("flixel/img/ui/analog/thumb.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/button.png", __ASSET__flixel_img_ui_button_png);
		type.set ("flixel/img/ui/button.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/cursor.png", __ASSET__flixel_img_ui_cursor_png);
		type.set ("flixel/img/ui/cursor.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/fontData11pt.png", __ASSET__flixel_img_ui_fontdata11pt_png);
		type.set ("flixel/img/ui/fontData11pt.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/a.png", __ASSET__flixel_img_ui_virtualpad_a_png);
		type.set ("flixel/img/ui/virtualpad/a.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/b.png", __ASSET__flixel_img_ui_virtualpad_b_png);
		type.set ("flixel/img/ui/virtualpad/b.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/c.png", __ASSET__flixel_img_ui_virtualpad_c_png);
		type.set ("flixel/img/ui/virtualpad/c.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/down.png", __ASSET__flixel_img_ui_virtualpad_down_png);
		type.set ("flixel/img/ui/virtualpad/down.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/left.png", __ASSET__flixel_img_ui_virtualpad_left_png);
		type.set ("flixel/img/ui/virtualpad/left.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/right.png", __ASSET__flixel_img_ui_virtualpad_right_png);
		type.set ("flixel/img/ui/virtualpad/right.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/up.png", __ASSET__flixel_img_ui_virtualpad_up_png);
		type.set ("flixel/img/ui/virtualpad/up.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/x.png", __ASSET__flixel_img_ui_virtualpad_x_png);
		type.set ("flixel/img/ui/virtualpad/x.png", AssetType.IMAGE);
		className.set ("flixel/img/ui/virtualpad/y.png", __ASSET__flixel_img_ui_virtualpad_y_png);
		type.set ("flixel/img/ui/virtualpad/y.png", AssetType.IMAGE);
		className.set ("flixel/snd/beep.wav", __ASSET__flixel_snd_beep_wav);
		type.set ("flixel/snd/beep.wav", AssetType.SOUND);
		className.set ("flixel/snd/flixel.wav", __ASSET__flixel_snd_flixel_wav);
		type.set ("flixel/snd/flixel.wav", AssetType.SOUND);
		
		
		#elseif html5
		
		var id;
		id = "Beep";
		path.set (id, "assets/data/beep.mp3");
		type.set (id, AssetType.SOUND);
		id = "assets/data/autotiles.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/autotiles_alt.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/base.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/beep.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "assets/data/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_a.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_b.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_c.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_down.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_left.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_right.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_up.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_x.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/button_y.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/courier.ttf";
		className.set (id, __ASSET__assets_data_courier_ttf);
		type.set (id, AssetType.FONT);
		id = "assets/data/cursor.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/default.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/fontData10pt.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/fontData11pt.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/handle.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/logo.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/logo_corners.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/logo_light.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/nokiafc22.ttf";
		className.set (id, __ASSET__assets_data_nokiafc22_ttf);
		type.set (id, AssetType.FONT);
		id = "assets/data/stick.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/flixel.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/open.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/pause.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/play.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/record_off.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/record_on.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/restart.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/step.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vcr/stop.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/data/vis/bounds.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/HaxeFlixel.svg";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/icon/icon1024.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon128.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon16.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon256.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon32.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon48.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon512.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/icon/icon64.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/png/960p/bird_sheet_960p.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/png/960p/birds_960p.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/png/960p/rain_960p.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/png/960p/snow_1_960p.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/png/960p/snow_2_960p.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/png/960p/wind_960p.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/ttf/AllCapsFont.ttf";
		className.set (id, __ASSET__assets_ttf_allcapsfont_ttf);
		type.set (id, AssetType.FONT);
		id = "Handwriting";
		className.set (id, __ASSET__assets_ttf_allcapsfont_ttf1);
		type.set (id, AssetType.FONT);
		id = "flixel/img/debugger/buttons/console.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/logDebug.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/open.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/pause.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/play.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/record_off.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/record_on.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/restart.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/statsDebug.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/step.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/stop.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/visualDebug.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/buttons/watchDebug.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/flixel.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/debugger/windowHandle.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/logo/default.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/logo/HaxeFlixel.svg";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "flixel/img/logo/logo.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/preloader/corners.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/preloader/light.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/tile/autotiles.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/tile/autotiles_alt.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/analog/base.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/analog/thumb.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/button.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/cursor.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/fontData11pt.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/a.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/b.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/c.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/down.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/left.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/right.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/up.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/x.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/img/ui/virtualpad/y.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "flixel/snd/beep.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		id = "flixel/snd/flixel.wav";
		path.set (id, id);
		type.set (id, AssetType.SOUND);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("Beep", __ASSET__assets_data_beep_mp3);
		type.set ("Beep", AssetType.SOUND);
		
		className.set ("assets/data/autotiles.png", __ASSET__assets_data_autotiles_png);
		type.set ("assets/data/autotiles.png", AssetType.IMAGE);
		
		className.set ("assets/data/autotiles_alt.png", __ASSET__assets_data_autotiles_alt_png);
		type.set ("assets/data/autotiles_alt.png", AssetType.IMAGE);
		
		className.set ("assets/data/base.png", __ASSET__assets_data_base_png);
		type.set ("assets/data/base.png", AssetType.IMAGE);
		
		className.set ("assets/data/beep.mp3", __ASSET__assets_data_beep_mp4);
		type.set ("assets/data/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/data/button.png", __ASSET__assets_data_button_png);
		type.set ("assets/data/button.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_a.png", __ASSET__assets_data_button_a_png);
		type.set ("assets/data/button_a.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_b.png", __ASSET__assets_data_button_b_png);
		type.set ("assets/data/button_b.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_c.png", __ASSET__assets_data_button_c_png);
		type.set ("assets/data/button_c.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_down.png", __ASSET__assets_data_button_down_png);
		type.set ("assets/data/button_down.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_left.png", __ASSET__assets_data_button_left_png);
		type.set ("assets/data/button_left.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_right.png", __ASSET__assets_data_button_right_png);
		type.set ("assets/data/button_right.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_up.png", __ASSET__assets_data_button_up_png);
		type.set ("assets/data/button_up.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_x.png", __ASSET__assets_data_button_x_png);
		type.set ("assets/data/button_x.png", AssetType.IMAGE);
		
		className.set ("assets/data/button_y.png", __ASSET__assets_data_button_y_png);
		type.set ("assets/data/button_y.png", AssetType.IMAGE);
		
		className.set ("assets/data/courier.ttf", __ASSET__assets_data_courier_ttf);
		type.set ("assets/data/courier.ttf", AssetType.FONT);
		
		className.set ("assets/data/cursor.png", __ASSET__assets_data_cursor_png);
		type.set ("assets/data/cursor.png", AssetType.IMAGE);
		
		className.set ("assets/data/default.png", __ASSET__assets_data_default_png);
		type.set ("assets/data/default.png", AssetType.IMAGE);
		
		className.set ("assets/data/fontData10pt.png", __ASSET__assets_data_fontdata10pt_png);
		type.set ("assets/data/fontData10pt.png", AssetType.IMAGE);
		
		className.set ("assets/data/fontData11pt.png", __ASSET__assets_data_fontdata11pt_png);
		type.set ("assets/data/fontData11pt.png", AssetType.IMAGE);
		
		className.set ("assets/data/handle.png", __ASSET__assets_data_handle_png);
		type.set ("assets/data/handle.png", AssetType.IMAGE);
		
		className.set ("assets/data/logo.png", __ASSET__assets_data_logo_png);
		type.set ("assets/data/logo.png", AssetType.IMAGE);
		
		className.set ("assets/data/logo_corners.png", __ASSET__assets_data_logo_corners_png);
		type.set ("assets/data/logo_corners.png", AssetType.IMAGE);
		
		className.set ("assets/data/logo_light.png", __ASSET__assets_data_logo_light_png);
		type.set ("assets/data/logo_light.png", AssetType.IMAGE);
		
		className.set ("assets/data/nokiafc22.ttf", __ASSET__assets_data_nokiafc22_ttf);
		type.set ("assets/data/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("assets/data/stick.png", __ASSET__assets_data_stick_png);
		type.set ("assets/data/stick.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/flixel.png", __ASSET__assets_data_vcr_flixel_png);
		type.set ("assets/data/vcr/flixel.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/open.png", __ASSET__assets_data_vcr_open_png);
		type.set ("assets/data/vcr/open.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/pause.png", __ASSET__assets_data_vcr_pause_png);
		type.set ("assets/data/vcr/pause.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/play.png", __ASSET__assets_data_vcr_play_png);
		type.set ("assets/data/vcr/play.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/record_off.png", __ASSET__assets_data_vcr_record_off_png);
		type.set ("assets/data/vcr/record_off.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/record_on.png", __ASSET__assets_data_vcr_record_on_png);
		type.set ("assets/data/vcr/record_on.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/restart.png", __ASSET__assets_data_vcr_restart_png);
		type.set ("assets/data/vcr/restart.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/step.png", __ASSET__assets_data_vcr_step_png);
		type.set ("assets/data/vcr/step.png", AssetType.IMAGE);
		
		className.set ("assets/data/vcr/stop.png", __ASSET__assets_data_vcr_stop_png);
		type.set ("assets/data/vcr/stop.png", AssetType.IMAGE);
		
		className.set ("assets/data/vis/bounds.png", __ASSET__assets_data_vis_bounds_png);
		type.set ("assets/data/vis/bounds.png", AssetType.IMAGE);
		
		className.set ("assets/HaxeFlixel.svg", __ASSET__assets_haxeflixel_svg);
		type.set ("assets/HaxeFlixel.svg", AssetType.TEXT);
		
		className.set ("assets/icon/icon1024.png", __ASSET__assets_icon_icon1024_png);
		type.set ("assets/icon/icon1024.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon128.png", __ASSET__assets_icon_icon128_png);
		type.set ("assets/icon/icon128.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon16.png", __ASSET__assets_icon_icon16_png);
		type.set ("assets/icon/icon16.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon256.png", __ASSET__assets_icon_icon256_png);
		type.set ("assets/icon/icon256.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon32.png", __ASSET__assets_icon_icon32_png);
		type.set ("assets/icon/icon32.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon48.png", __ASSET__assets_icon_icon48_png);
		type.set ("assets/icon/icon48.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon512.png", __ASSET__assets_icon_icon512_png);
		type.set ("assets/icon/icon512.png", AssetType.IMAGE);
		
		className.set ("assets/icon/icon64.png", __ASSET__assets_icon_icon64_png);
		type.set ("assets/icon/icon64.png", AssetType.IMAGE);
		
		className.set ("assets/png/960p/bird_sheet_960p.png", __ASSET__assets_png_960p_bird_sheet_960p_png);
		type.set ("assets/png/960p/bird_sheet_960p.png", AssetType.IMAGE);
		
		className.set ("assets/png/960p/birds_960p.png", __ASSET__assets_png_960p_birds_960p_png);
		type.set ("assets/png/960p/birds_960p.png", AssetType.IMAGE);
		
		className.set ("assets/png/960p/rain_960p.png", __ASSET__assets_png_960p_rain_960p_png);
		type.set ("assets/png/960p/rain_960p.png", AssetType.IMAGE);
		
		className.set ("assets/png/960p/snow_1_960p.png", __ASSET__assets_png_960p_snow_1_960p_png);
		type.set ("assets/png/960p/snow_1_960p.png", AssetType.IMAGE);
		
		className.set ("assets/png/960p/snow_2_960p.png", __ASSET__assets_png_960p_snow_2_960p_png);
		type.set ("assets/png/960p/snow_2_960p.png", AssetType.IMAGE);
		
		className.set ("assets/png/960p/wind_960p.png", __ASSET__assets_png_960p_wind_960p_png);
		type.set ("assets/png/960p/wind_960p.png", AssetType.IMAGE);
		
		className.set ("assets/ttf/AllCapsFont.ttf", __ASSET__assets_ttf_allcapsfont_ttf);
		type.set ("assets/ttf/AllCapsFont.ttf", AssetType.FONT);
		
		className.set ("Handwriting", __ASSET__assets_ttf_allcapsfont_ttf1);
		type.set ("Handwriting", AssetType.FONT);
		
		className.set ("flixel/img/debugger/buttons/console.png", __ASSET__flixel_img_debugger_buttons_console_png);
		type.set ("flixel/img/debugger/buttons/console.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/logDebug.png", __ASSET__flixel_img_debugger_buttons_logdebug_png);
		type.set ("flixel/img/debugger/buttons/logDebug.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/open.png", __ASSET__flixel_img_debugger_buttons_open_png);
		type.set ("flixel/img/debugger/buttons/open.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/pause.png", __ASSET__flixel_img_debugger_buttons_pause_png);
		type.set ("flixel/img/debugger/buttons/pause.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/play.png", __ASSET__flixel_img_debugger_buttons_play_png);
		type.set ("flixel/img/debugger/buttons/play.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/record_off.png", __ASSET__flixel_img_debugger_buttons_record_off_png);
		type.set ("flixel/img/debugger/buttons/record_off.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/record_on.png", __ASSET__flixel_img_debugger_buttons_record_on_png);
		type.set ("flixel/img/debugger/buttons/record_on.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/restart.png", __ASSET__flixel_img_debugger_buttons_restart_png);
		type.set ("flixel/img/debugger/buttons/restart.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/statsDebug.png", __ASSET__flixel_img_debugger_buttons_statsdebug_png);
		type.set ("flixel/img/debugger/buttons/statsDebug.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/step.png", __ASSET__flixel_img_debugger_buttons_step_png);
		type.set ("flixel/img/debugger/buttons/step.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/stop.png", __ASSET__flixel_img_debugger_buttons_stop_png);
		type.set ("flixel/img/debugger/buttons/stop.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/visualDebug.png", __ASSET__flixel_img_debugger_buttons_visualdebug_png);
		type.set ("flixel/img/debugger/buttons/visualDebug.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/buttons/watchDebug.png", __ASSET__flixel_img_debugger_buttons_watchdebug_png);
		type.set ("flixel/img/debugger/buttons/watchDebug.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/flixel.png", __ASSET__flixel_img_debugger_flixel_png);
		type.set ("flixel/img/debugger/flixel.png", AssetType.IMAGE);
		
		className.set ("flixel/img/debugger/windowHandle.png", __ASSET__flixel_img_debugger_windowhandle_png);
		type.set ("flixel/img/debugger/windowHandle.png", AssetType.IMAGE);
		
		className.set ("flixel/img/logo/default.png", __ASSET__flixel_img_logo_default_png);
		type.set ("flixel/img/logo/default.png", AssetType.IMAGE);
		
		className.set ("flixel/img/logo/HaxeFlixel.svg", __ASSET__flixel_img_logo_haxeflixel_svg);
		type.set ("flixel/img/logo/HaxeFlixel.svg", AssetType.TEXT);
		
		className.set ("flixel/img/logo/logo.png", __ASSET__flixel_img_logo_logo_png);
		type.set ("flixel/img/logo/logo.png", AssetType.IMAGE);
		
		className.set ("flixel/img/preloader/corners.png", __ASSET__flixel_img_preloader_corners_png);
		type.set ("flixel/img/preloader/corners.png", AssetType.IMAGE);
		
		className.set ("flixel/img/preloader/light.png", __ASSET__flixel_img_preloader_light_png);
		type.set ("flixel/img/preloader/light.png", AssetType.IMAGE);
		
		className.set ("flixel/img/tile/autotiles.png", __ASSET__flixel_img_tile_autotiles_png);
		type.set ("flixel/img/tile/autotiles.png", AssetType.IMAGE);
		
		className.set ("flixel/img/tile/autotiles_alt.png", __ASSET__flixel_img_tile_autotiles_alt_png);
		type.set ("flixel/img/tile/autotiles_alt.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/analog/base.png", __ASSET__flixel_img_ui_analog_base_png);
		type.set ("flixel/img/ui/analog/base.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/analog/thumb.png", __ASSET__flixel_img_ui_analog_thumb_png);
		type.set ("flixel/img/ui/analog/thumb.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/button.png", __ASSET__flixel_img_ui_button_png);
		type.set ("flixel/img/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/cursor.png", __ASSET__flixel_img_ui_cursor_png);
		type.set ("flixel/img/ui/cursor.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/fontData11pt.png", __ASSET__flixel_img_ui_fontdata11pt_png);
		type.set ("flixel/img/ui/fontData11pt.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/a.png", __ASSET__flixel_img_ui_virtualpad_a_png);
		type.set ("flixel/img/ui/virtualpad/a.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/b.png", __ASSET__flixel_img_ui_virtualpad_b_png);
		type.set ("flixel/img/ui/virtualpad/b.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/c.png", __ASSET__flixel_img_ui_virtualpad_c_png);
		type.set ("flixel/img/ui/virtualpad/c.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/down.png", __ASSET__flixel_img_ui_virtualpad_down_png);
		type.set ("flixel/img/ui/virtualpad/down.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/left.png", __ASSET__flixel_img_ui_virtualpad_left_png);
		type.set ("flixel/img/ui/virtualpad/left.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/right.png", __ASSET__flixel_img_ui_virtualpad_right_png);
		type.set ("flixel/img/ui/virtualpad/right.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/up.png", __ASSET__flixel_img_ui_virtualpad_up_png);
		type.set ("flixel/img/ui/virtualpad/up.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/x.png", __ASSET__flixel_img_ui_virtualpad_x_png);
		type.set ("flixel/img/ui/virtualpad/x.png", AssetType.IMAGE);
		
		className.set ("flixel/img/ui/virtualpad/y.png", __ASSET__flixel_img_ui_virtualpad_y_png);
		type.set ("flixel/img/ui/virtualpad/y.png", AssetType.IMAGE);
		
		className.set ("flixel/snd/beep.wav", __ASSET__flixel_snd_beep_wav);
		type.set ("flixel/snd/beep.wav", AssetType.SOUND);
		
		className.set ("flixel/snd/flixel.wav", __ASSET__flixel_snd_flixel_wav);
		type.set ("flixel/snd/flixel.wav", AssetType.SOUND);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_data_beep_mp3 extends openfl.media.Sound { }
@:keep class __ASSET__assets_data_autotiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_autotiles_alt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_base_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_beep_mp4 extends openfl.media.Sound { }
@:keep class __ASSET__assets_data_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_c_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_button_y_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_courier_ttf extends openfl.text.Font { }
@:keep class __ASSET__assets_data_cursor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_fontdata10pt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_fontdata11pt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_handle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_logo_corners_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_logo_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_nokiafc22_ttf extends openfl.text.Font { }
@:keep class __ASSET__assets_data_stick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_flixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_open_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_pause_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_record_off_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_record_on_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_restart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_step_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vcr_stop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_data_vis_bounds_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_haxeflixel_svg extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_icon_icon1024_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon128_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon16_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon256_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon32_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon48_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon512_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_icon_icon64_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_png_960p_bird_sheet_960p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_png_960p_birds_960p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_png_960p_rain_960p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_png_960p_snow_1_960p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_png_960p_snow_2_960p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_png_960p_wind_960p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_ttf_allcapsfont_ttf extends openfl.text.Font { }
@:keep class __ASSET__assets_ttf_allcapsfont_ttf1 extends openfl.text.Font { }
@:keep class __ASSET__flixel_img_debugger_buttons_console_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_logdebug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_open_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_pause_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_record_off_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_record_on_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_restart_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_statsdebug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_step_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_stop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_visualdebug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_buttons_watchdebug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_flixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_debugger_windowhandle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_logo_haxeflixel_svg extends openfl.utils.ByteArray { }
@:keep class __ASSET__flixel_img_logo_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_preloader_corners_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_preloader_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_tile_autotiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_tile_autotiles_alt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_analog_base_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_analog_thumb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_cursor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_fontdata11pt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_c_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_x_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_img_ui_virtualpad_y_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__flixel_snd_beep_wav extends openfl.media.Sound { }
@:keep class __ASSET__flixel_snd_flixel_wav extends openfl.media.Sound { }


#elseif html5
















@:keep class __ASSET__assets_data_courier_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "assets/data/courier.ttf"; } #end }








@:keep class __ASSET__assets_data_nokiafc22_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "assets/data/nokiafc22.ttf"; } #end }


























@:keep class __ASSET__assets_ttf_allcapsfont_ttf extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "assets/ttf/AllCapsFont.ttf"; } #end }
@:keep class __ASSET__assets_ttf_allcapsfont_ttf1 extends flash.text.Font { #if (!openfl_html5_dom) public function new () { super (); fontName = "Handwriting"; } #end }








































#elseif (windows || mac || linux)


@:sound("assets/data/beep.mp3") class __ASSET__assets_data_beep_mp3 extends flash.media.Sound {}
@:bitmap("assets/data/autotiles.png") class __ASSET__assets_data_autotiles_png extends flash.display.BitmapData {}
@:bitmap("assets/data/autotiles_alt.png") class __ASSET__assets_data_autotiles_alt_png extends flash.display.BitmapData {}
@:bitmap("assets/data/base.png") class __ASSET__assets_data_base_png extends flash.display.BitmapData {}
@:sound("assets/data/beep.mp3") class __ASSET__assets_data_beep_mp4 extends flash.media.Sound {}
@:bitmap("assets/data/button.png") class __ASSET__assets_data_button_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_a.png") class __ASSET__assets_data_button_a_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_b.png") class __ASSET__assets_data_button_b_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_c.png") class __ASSET__assets_data_button_c_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_down.png") class __ASSET__assets_data_button_down_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_left.png") class __ASSET__assets_data_button_left_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_right.png") class __ASSET__assets_data_button_right_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_up.png") class __ASSET__assets_data_button_up_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_x.png") class __ASSET__assets_data_button_x_png extends flash.display.BitmapData {}
@:bitmap("assets/data/button_y.png") class __ASSET__assets_data_button_y_png extends flash.display.BitmapData {}
@:font("assets/data/courier.ttf") class __ASSET__assets_data_courier_ttf extends flash.text.Font {}
@:bitmap("assets/data/cursor.png") class __ASSET__assets_data_cursor_png extends flash.display.BitmapData {}
@:bitmap("assets/data/default.png") class __ASSET__assets_data_default_png extends flash.display.BitmapData {}
@:bitmap("assets/data/fontData10pt.png") class __ASSET__assets_data_fontdata10pt_png extends flash.display.BitmapData {}
@:bitmap("assets/data/fontData11pt.png") class __ASSET__assets_data_fontdata11pt_png extends flash.display.BitmapData {}
@:bitmap("assets/data/handle.png") class __ASSET__assets_data_handle_png extends flash.display.BitmapData {}
@:bitmap("assets/data/logo.png") class __ASSET__assets_data_logo_png extends flash.display.BitmapData {}
@:bitmap("assets/data/logo_corners.png") class __ASSET__assets_data_logo_corners_png extends flash.display.BitmapData {}
@:bitmap("assets/data/logo_light.png") class __ASSET__assets_data_logo_light_png extends flash.display.BitmapData {}
@:font("assets/data/nokiafc22.ttf") class __ASSET__assets_data_nokiafc22_ttf extends flash.text.Font {}
@:bitmap("assets/data/stick.png") class __ASSET__assets_data_stick_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/flixel.png") class __ASSET__assets_data_vcr_flixel_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/open.png") class __ASSET__assets_data_vcr_open_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/pause.png") class __ASSET__assets_data_vcr_pause_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/play.png") class __ASSET__assets_data_vcr_play_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/record_off.png") class __ASSET__assets_data_vcr_record_off_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/record_on.png") class __ASSET__assets_data_vcr_record_on_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/restart.png") class __ASSET__assets_data_vcr_restart_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/step.png") class __ASSET__assets_data_vcr_step_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vcr/stop.png") class __ASSET__assets_data_vcr_stop_png extends flash.display.BitmapData {}
@:bitmap("assets/data/vis/bounds.png") class __ASSET__assets_data_vis_bounds_png extends flash.display.BitmapData {}
@:file("assets/HaxeFlixel.svg") class __ASSET__assets_haxeflixel_svg extends flash.utils.ByteArray {}
@:bitmap("assets/icon/icon1024.png") class __ASSET__assets_icon_icon1024_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon128.png") class __ASSET__assets_icon_icon128_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon16.png") class __ASSET__assets_icon_icon16_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon256.png") class __ASSET__assets_icon_icon256_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon32.png") class __ASSET__assets_icon_icon32_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon48.png") class __ASSET__assets_icon_icon48_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon512.png") class __ASSET__assets_icon_icon512_png extends flash.display.BitmapData {}
@:bitmap("assets/icon/icon64.png") class __ASSET__assets_icon_icon64_png extends flash.display.BitmapData {}
@:bitmap("assets/png/960p/bird_sheet_960p.png") class __ASSET__assets_png_960p_bird_sheet_960p_png extends flash.display.BitmapData {}
@:bitmap("assets/png/960p/birds_960p.png") class __ASSET__assets_png_960p_birds_960p_png extends flash.display.BitmapData {}
@:bitmap("assets/png/960p/rain_960p.png") class __ASSET__assets_png_960p_rain_960p_png extends flash.display.BitmapData {}
@:bitmap("assets/png/960p/snow_1_960p.png") class __ASSET__assets_png_960p_snow_1_960p_png extends flash.display.BitmapData {}
@:bitmap("assets/png/960p/snow_2_960p.png") class __ASSET__assets_png_960p_snow_2_960p_png extends flash.display.BitmapData {}
@:bitmap("assets/png/960p/wind_960p.png") class __ASSET__assets_png_960p_wind_960p_png extends flash.display.BitmapData {}
@:font("assets/ttf/AllCapsFont.ttf") class __ASSET__assets_ttf_allcapsfont_ttf extends flash.text.Font {}
@:font("assets/ttf/AllCapsFont.ttf") class __ASSET__assets_ttf_allcapsfont_ttf1 extends flash.text.Font {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/console.png") class __ASSET__flixel_img_debugger_buttons_console_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/logDebug.png") class __ASSET__flixel_img_debugger_buttons_logdebug_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/open.png") class __ASSET__flixel_img_debugger_buttons_open_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/pause.png") class __ASSET__flixel_img_debugger_buttons_pause_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/play.png") class __ASSET__flixel_img_debugger_buttons_play_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/record_off.png") class __ASSET__flixel_img_debugger_buttons_record_off_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/record_on.png") class __ASSET__flixel_img_debugger_buttons_record_on_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/restart.png") class __ASSET__flixel_img_debugger_buttons_restart_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/statsDebug.png") class __ASSET__flixel_img_debugger_buttons_statsdebug_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/step.png") class __ASSET__flixel_img_debugger_buttons_step_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/stop.png") class __ASSET__flixel_img_debugger_buttons_stop_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/visualDebug.png") class __ASSET__flixel_img_debugger_buttons_visualdebug_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/buttons/watchDebug.png") class __ASSET__flixel_img_debugger_buttons_watchdebug_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/flixel.png") class __ASSET__flixel_img_debugger_flixel_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/debugger/windowHandle.png") class __ASSET__flixel_img_debugger_windowhandle_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/logo/default.png") class __ASSET__flixel_img_logo_default_png extends flash.display.BitmapData {}
@:file("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/logo/HaxeFlixel.svg") class __ASSET__flixel_img_logo_haxeflixel_svg extends flash.utils.ByteArray {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/logo/logo.png") class __ASSET__flixel_img_logo_logo_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/preloader/corners.png") class __ASSET__flixel_img_preloader_corners_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/preloader/light.png") class __ASSET__flixel_img_preloader_light_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/tile/autotiles.png") class __ASSET__flixel_img_tile_autotiles_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/tile/autotiles_alt.png") class __ASSET__flixel_img_tile_autotiles_alt_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/analog/base.png") class __ASSET__flixel_img_ui_analog_base_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/analog/thumb.png") class __ASSET__flixel_img_ui_analog_thumb_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/button.png") class __ASSET__flixel_img_ui_button_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/cursor.png") class __ASSET__flixel_img_ui_cursor_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/fontData11pt.png") class __ASSET__flixel_img_ui_fontdata11pt_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/a.png") class __ASSET__flixel_img_ui_virtualpad_a_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/b.png") class __ASSET__flixel_img_ui_virtualpad_b_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/c.png") class __ASSET__flixel_img_ui_virtualpad_c_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/down.png") class __ASSET__flixel_img_ui_virtualpad_down_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/left.png") class __ASSET__flixel_img_ui_virtualpad_left_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/right.png") class __ASSET__flixel_img_ui_virtualpad_right_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/up.png") class __ASSET__flixel_img_ui_virtualpad_up_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/x.png") class __ASSET__flixel_img_ui_virtualpad_x_png extends flash.display.BitmapData {}
@:bitmap("/usr/lib/haxe/lib/flixel/3,0,1/assets/images/ui/virtualpad/y.png") class __ASSET__flixel_img_ui_virtualpad_y_png extends flash.display.BitmapData {}
@:sound("/usr/lib/haxe/lib/flixel/3,0,1/assets/sounds/beep.wav") class __ASSET__flixel_snd_beep_wav extends flash.media.Sound {}
@:sound("/usr/lib/haxe/lib/flixel/3,0,1/assets/sounds/flixel.wav") class __ASSET__flixel_snd_flixel_wav extends flash.media.Sound {}


#end
