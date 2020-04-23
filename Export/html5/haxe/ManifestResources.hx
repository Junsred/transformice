package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_soopafresh_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_verdana_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_soopafresh_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__fonts_verdana_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":"animations","assets":"aoy4:pathy14:animations.biny4:sizei1477236y4:typey4:TEXTy2:idR1y7:preloadtgh","rootPath":"lib/animations","version":2,"libraryArgs":["animations.bin","EwUvKESKpM3H6YP2fKSr"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("animations", library);
		data = '{"name":"resources","assets":"aoy4:pathy8:1063.pngy4:sizei749y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y8:1275.jpgR2i3567R3R4R5R7R6tgoR0y7:368.pngR2i609R3R4R5R8R6tgoR0y7:372.pngR2i595R3R4R5R9R6tgoR0y7:376.pngR2i795R3R4R5R10R6tgoR0y5:5.pngR2i2077R3R4R5R11R6tgoR0y13:resources.binR2i5377263R3y4:TEXTR5R12R6tgh","rootPath":"lib/resources","version":2,"libraryArgs":["resources.bin","IP3iwu9z1NK3vU76FVmf"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("resources", library);
		data = '{"name":"costumes","assets":"aoy4:pathy12:costumes.biny4:sizei4772268y4:typey4:TEXTy2:idR1y7:preloadtgh","rootPath":"lib/costumes","version":2,"libraryArgs":["costumes.bin","KP8zh1gjyRGIi5w3tEOk"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("costumes", library);
		data = '{"name":"furs","assets":"aoy4:pathy8:furs.biny4:sizei1541146y4:typey4:TEXTy2:idR1y7:preloadtgh","rootPath":"lib/furs","version":2,"libraryArgs":["furs.bin","ViL1kp07GWwrpqnyUfux"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("furs", library);
		data = '{"name":null,"assets":"aoy4:sizei43892y4:typey4:FONTy9:classNamey36:__ASSET__assets_fonts_soopafresh_ttfy2:idy31:assets%2Ffonts%2FSoopafresh.ttfy7:preloadtgoR0i106296R1R2R3y33:__ASSET__assets_fonts_verdana_ttfR5y28:assets%2Ffonts%2FVerdana.ttfR7tgoy4:pathy24:assets%2Fswf%2Fx_B_1.swfR0i83454R1y6:BINARYR5R11R7tgoR10y30:assets%2Fswf%2Fx_fourrures.swfR0i157536R1R12R5R13R7tgoR10y34:assets%2Fswf%2Fx_meli_costumes.swfR0i451302R1R12R5R14R7tgoR10y37:assets%2Fswf%2Fx_Ressources_Class.swfR0i441115R1R12R5R15R7tgoR10y36:assets%2Fswf%2Fx_TransformiceFLA.swfR0i368161R1R12R5R16R7tgoR0i43892R1R2R3y29:__ASSET__fonts_soopafresh_ttfR5y22:fonts%2FSoopafresh.ttfR7tgoR0i106296R1R2R3y26:__ASSET__fonts_verdana_ttfR5y19:fonts%2FVerdana.ttfR7tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("animations");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("animations");
		library = Assets.getLibrary ("resources");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("resources");
		library = Assets.getLibrary ("costumes");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("costumes");
		library = Assets.getLibrary ("furs");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("furs");
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_soopafresh_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_verdana_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_x_b_1_swf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_x_fourrures_swf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_x_meli_costumes_swf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_x_ressources_class_swf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_x_transformicefla_swf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_soopafresh_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__fonts_verdana_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__animations_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__lib_animations_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__file_063_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__file_275_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__file_68_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__file_72_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__file_76_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__file__png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__resources_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__lib_resources_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__costumes_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__lib_costumes_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__furs_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__lib_furs_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:font("Export/html5/obj/webfont/Soopafresh.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_soopafresh_ttf extends lime.text.Font {}
@:keep @:font("Export/html5/obj/webfont/Verdana.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_verdana_ttf extends lime.text.Font {}
@:keep @:file("Assets/swf/x_B_1.swf") @:noCompletion #if display private #end class __ASSET__assets_swf_x_b_1_swf extends haxe.io.Bytes {}
@:keep @:file("Assets/swf/x_fourrures.swf") @:noCompletion #if display private #end class __ASSET__assets_swf_x_fourrures_swf extends haxe.io.Bytes {}
@:keep @:file("Assets/swf/x_meli_costumes.swf") @:noCompletion #if display private #end class __ASSET__assets_swf_x_meli_costumes_swf extends haxe.io.Bytes {}
@:keep @:file("Assets/swf/x_Ressources_Class.swf") @:noCompletion #if display private #end class __ASSET__assets_swf_x_ressources_class_swf extends haxe.io.Bytes {}
@:keep @:file("Assets/swf/x_TransformiceFLA.swf") @:noCompletion #if display private #end class __ASSET__assets_swf_x_transformicefla_swf extends haxe.io.Bytes {}
@:keep @:font("Export/html5/obj/webfont/Soopafresh.ttf") @:noCompletion #if display private #end class __ASSET__fonts_soopafresh_ttf extends lime.text.Font {}
@:keep @:font("Export/html5/obj/webfont/Verdana.ttf") @:noCompletion #if display private #end class __ASSET__fonts_verdana_ttf extends lime.text.Font {}
@:keep @:file("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/animations/animations.bin") @:noCompletion #if display private #end class __ASSET__animations_bin extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__lib_animations_json extends haxe.io.Bytes {}
@:keep @:image("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/1063.png") @:noCompletion #if display private #end class __ASSET__file_063_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/1275.jpg") @:noCompletion #if display private #end class __ASSET__file_275_jpg extends lime.graphics.Image {}
@:keep @:image("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/368.png") @:noCompletion #if display private #end class __ASSET__file_68_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/372.png") @:noCompletion #if display private #end class __ASSET__file_72_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/376.png") @:noCompletion #if display private #end class __ASSET__file_76_png extends lime.graphics.Image {}
@:keep @:image("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/5.png") @:noCompletion #if display private #end class __ASSET__file__png extends lime.graphics.Image {}
@:keep @:file("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/resources/resources.bin") @:noCompletion #if display private #end class __ASSET__resources_bin extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__lib_resources_json extends haxe.io.Bytes {}
@:keep @:file("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/costumes/costumes.bin") @:noCompletion #if display private #end class __ASSET__costumes_bin extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__lib_costumes_json extends haxe.io.Bytes {}
@:keep @:file("C:/Users/EGTech/Desktop/github/transformice/Export/html5/obj/libraries/furs/furs.bin") @:noCompletion #if display private #end class __ASSET__furs_bin extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__lib_furs_json extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_soopafresh_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_soopafresh_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Soopafresh"; #else ascender = 1012; descender = -246; height = 1428; numGlyphs = 208; underlinePosition = -30; underlineThickness = 60; unitsPerEM = 1024; #end name = "Soopafresh"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_verdana_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_verdana_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Verdana"; #else ascender = 1076; descender = -212; height = 1458; numGlyphs = 420; underlinePosition = -30; underlineThickness = 60; unitsPerEM = 1024; #end name = "Verdana"; super (); }}
@:keep @:expose('__ASSET__fonts_soopafresh_ttf') @:noCompletion #if display private #end class __ASSET__fonts_soopafresh_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Soopafresh"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Soopafresh"; super (); }}
@:keep @:expose('__ASSET__fonts_verdana_ttf') @:noCompletion #if display private #end class __ASSET__fonts_verdana_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "fonts/Verdana"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Verdana"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_soopafresh_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_soopafresh_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_soopafresh_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_verdana_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_verdana_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_verdana_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_soopafresh_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_soopafresh_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_soopafresh_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_verdana_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_verdana_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_verdana_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_soopafresh_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_soopafresh_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_soopafresh_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_verdana_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_verdana_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_verdana_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_soopafresh_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_soopafresh_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_soopafresh_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__fonts_verdana_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__fonts_verdana_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__fonts_verdana_ttf ()); super (); }}

#end

#end
#end

#end
