fn Description =
(
	"Convert imported SpeedTree files from Legacy to Arnold."
)

fn RenderPreset =
(
)

fn RendererClassID =
(
	#(0xb1a427cdL, 0xa045556fL)
)

fn Setup =
(
	-- Conversion from Bitmap Texture to Arnold Image
	SceneConverter.AddConversionRule #(0x240L, 0x0L) #(0x7e73161fL, 0xad53b12aL) conversionType:1
	-- Conversion from Standard to Arnold Material
	SceneConverter.AddConversionRule #(0x2L, 0x0L) #(0x7e73161fL, 0x62f74b4cL) conversionType:1
)

fn RemoveInvalidElementFromScene =
(
	TRUE
)

fn ScriptsIncludes =
(
	#()
)

fn PreConvert =
(
	--add here, as a string between double quotes, any Maxscript inscructions to apply before any conversion has started.
	"					
	
	
	
	
	"
)

fn PostConvert =
(
	--add here, as a string between double quotes, any Maxscript inscructions to apply after all conversions have been applied.
	"					
	
	
	
	
	"
)

