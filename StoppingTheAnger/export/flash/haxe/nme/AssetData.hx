package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("Beep", nme.NME_assets_data_beep_mp3);
			type.set ("Beep", Reflect.field (AssetType, "sound".toUpperCase ()));
			className.set ("assets/data/autotiles.png", nme.NME_assets_data_autotiles_png);
			type.set ("assets/data/autotiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/autotiles_alt.png", nme.NME_assets_data_autotiles_alt_png);
			type.set ("assets/data/autotiles_alt.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/base.png", nme.NME_assets_data_base_png);
			type.set ("assets/data/base.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/beep.mp3", nme.NME_assets_data_beep_mp4);
			type.set ("assets/data/beep.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			className.set ("assets/data/button.png", nme.NME_assets_data_button_png);
			type.set ("assets/data/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_a.png", nme.NME_assets_data_button_a_png);
			type.set ("assets/data/button_a.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_b.png", nme.NME_assets_data_button_b_png);
			type.set ("assets/data/button_b.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_c.png", nme.NME_assets_data_button_c_png);
			type.set ("assets/data/button_c.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_down.png", nme.NME_assets_data_button_down_png);
			type.set ("assets/data/button_down.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_left.png", nme.NME_assets_data_button_left_png);
			type.set ("assets/data/button_left.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_right.png", nme.NME_assets_data_button_right_png);
			type.set ("assets/data/button_right.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_up.png", nme.NME_assets_data_button_up_png);
			type.set ("assets/data/button_up.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_x.png", nme.NME_assets_data_button_x_png);
			type.set ("assets/data/button_x.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/button_y.png", nme.NME_assets_data_button_y_png);
			type.set ("assets/data/button_y.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/courier.ttf", nme.NME_assets_data_courier_ttf);
			type.set ("assets/data/courier.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/data/cursor.png", nme.NME_assets_data_cursor_png);
			type.set ("assets/data/cursor.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/default.png", nme.NME_assets_data_default_png);
			type.set ("assets/data/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/fontData10pt.png", nme.NME_assets_data_fontdata10pt_png);
			type.set ("assets/data/fontData10pt.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/fontData11pt.png", nme.NME_assets_data_fontdata11pt_png);
			type.set ("assets/data/fontData11pt.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/handle.png", nme.NME_assets_data_handle_png);
			type.set ("assets/data/handle.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/logo.png", nme.NME_assets_data_logo_png);
			type.set ("assets/data/logo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/logo_corners.png", nme.NME_assets_data_logo_corners_png);
			type.set ("assets/data/logo_corners.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/logo_light.png", nme.NME_assets_data_logo_light_png);
			type.set ("assets/data/logo_light.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/nokiafc22.ttf", nme.NME_assets_data_nokiafc22_ttf);
			type.set ("assets/data/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/data/stick.png", nme.NME_assets_data_stick_png);
			type.set ("assets/data/stick.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/flixel.png", nme.NME_assets_data_vcr_flixel_png);
			type.set ("assets/data/vcr/flixel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/open.png", nme.NME_assets_data_vcr_open_png);
			type.set ("assets/data/vcr/open.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/pause.png", nme.NME_assets_data_vcr_pause_png);
			type.set ("assets/data/vcr/pause.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/play.png", nme.NME_assets_data_vcr_play_png);
			type.set ("assets/data/vcr/play.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/record_off.png", nme.NME_assets_data_vcr_record_off_png);
			type.set ("assets/data/vcr/record_off.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/record_on.png", nme.NME_assets_data_vcr_record_on_png);
			type.set ("assets/data/vcr/record_on.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/restart.png", nme.NME_assets_data_vcr_restart_png);
			type.set ("assets/data/vcr/restart.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/step.png", nme.NME_assets_data_vcr_step_png);
			type.set ("assets/data/vcr/step.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vcr/stop.png", nme.NME_assets_data_vcr_stop_png);
			type.set ("assets/data/vcr/stop.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/data/vis/bounds.png", nme.NME_assets_data_vis_bounds_png);
			type.set ("assets/data/vis/bounds.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/HaxeFlixel.svg", nme.NME_assets_haxeflixel_svg);
			type.set ("assets/HaxeFlixel.svg", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("assets/icon/icon1024.png", nme.NME_assets_icon_icon1024_png);
			type.set ("assets/icon/icon1024.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon128.png", nme.NME_assets_icon_icon128_png);
			type.set ("assets/icon/icon128.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon16.png", nme.NME_assets_icon_icon16_png);
			type.set ("assets/icon/icon16.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon256.png", nme.NME_assets_icon_icon256_png);
			type.set ("assets/icon/icon256.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon32.png", nme.NME_assets_icon_icon32_png);
			type.set ("assets/icon/icon32.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon48.png", nme.NME_assets_icon_icon48_png);
			type.set ("assets/icon/icon48.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon512.png", nme.NME_assets_icon_icon512_png);
			type.set ("assets/icon/icon512.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/icon/icon64.png", nme.NME_assets_icon_icon64_png);
			type.set ("assets/icon/icon64.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/png/960p/ball_960p.png", nme.NME_assets_png_960p_ball_960p_png);
			type.set ("assets/png/960p/ball_960p.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/png/960p/line_960p.png", nme.NME_assets_png_960p_line_960p_png);
			type.set ("assets/png/960p/line_960p.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/ttf/AllCapsFont.ttf", nme.NME_assets_ttf_allcapsfont_ttf);
			type.set ("assets/ttf/AllCapsFont.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("Handwriting", nme.NME_assets_ttf_allcapsfont_ttf1);
			type.set ("Handwriting", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_data_beep_mp3 extends flash.media.Sound { }
class NME_assets_data_autotiles_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_autotiles_alt_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_base_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_beep_mp4 extends flash.media.Sound { }
class NME_assets_data_button_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_a_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_b_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_c_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_down_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_left_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_right_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_up_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_x_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_button_y_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_courier_ttf extends flash.text.Font { }
class NME_assets_data_cursor_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_default_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_fontdata10pt_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_fontdata11pt_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_handle_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_logo_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_logo_corners_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_logo_light_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_nokiafc22_ttf extends flash.text.Font { }
class NME_assets_data_stick_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_flixel_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_open_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_pause_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_play_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_record_off_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_record_on_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_restart_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_step_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_stop_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vis_bounds_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_haxeflixel_svg extends flash.utils.ByteArray { }
class NME_assets_icon_icon1024_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon128_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon16_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon256_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon32_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon48_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon512_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_icon_icon64_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_png_960p_ball_960p_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_png_960p_line_960p_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_ttf_allcapsfont_ttf extends flash.text.Font { }
class NME_assets_ttf_allcapsfont_ttf1 extends flash.text.Font { }
