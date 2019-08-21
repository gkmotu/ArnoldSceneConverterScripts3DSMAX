fn Description =
(
	"Clean"
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
	-- Conversion from Vray Material to Arnold Standard Surface
	SceneConverter.AddConversionRule #(0x37bf3f2fL, 0x7034695cL) #(0x7e73161fL, 0x62f74b4cL) conversionType:1
	-- Conversion from Vray 2 Sided Material to Arnold two sided Material
	SceneConverter.AddConversionRule #(0x6066686aL, 0x11731b4bL) #(0x7e73161fL, 0x7ffd6281L) conversionType:1
	-- Conversion from Vray Normal Map to Arnold Normal map
	SceneConverter.AddConversionRule #(0x71fa6e51L, 0x72057c2fL) #(0x7e73161fL, 0x461fb78cL) conversionType:1
	-- Conversion from Bitmap Texture to Arnold Image
	SceneConverter.AddConversionRule #(0x240L, 0x0L) #(0x7e73161fL, 0xad53b12aL) conversionType:1
	-- Conversion from Legacy Color Correct to Arnold Color Correct
	SceneConverter.AddConversionRule #(0x2d0L, 0x0L) #(0x7e73161fL, 0xa95c8635L) conversionType:1
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

