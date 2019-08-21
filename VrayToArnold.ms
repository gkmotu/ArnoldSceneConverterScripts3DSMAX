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

