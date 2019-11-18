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
	-- Conversion from Corona Material to Arnold Standard Surface
	SceneConverter.AddConversionRule #(0x70be6506L, 0x448931ddL) #(0x7e73161fL, 0x62f74b4cL) conversionType:1
	-- Conversion from Vray 2 Sided Material to Arnold two sided Material
	SceneConverter.AddConversionRule #(0x6066686aL, 0x11731b4bL) #(0x7e73161fL, 0x7ffd6281L) conversionType:1
	-- Conversion from Vray Material to Arnold Standard Surface
	SceneConverter.AddConversionRule #(0x37bf3f2fL, 0x7034695cL) #(0x7e73161fL, 0x62f74b4cL) conversionType:1
	-- Conversion from Vray Blend Material to Arnold Layer Material
	SceneConverter.AddConversionRule #(0x3da0041bL, 0xf436e31L) #(0x7e73161fL, 0xc5619e9dL) conversionType:1
	-- Conversion from Legacy Bitmap to Arnold Image
	SceneConverter.AddConversionRule #(0x240L, 0x0L) #(0x7e73161fL, 0xad53b12aL) conversionType:1
	-- Conversion from Legacy Color Correct to Arnold Color Correct
	SceneConverter.AddConversionRule #(0x2d0L, 0x0L) #(0x7e73161fL, 0xa95c8635L) conversionType:1
	-- Conversion from Legacy Composit map to OSL Layers
	SceneConverter.AddConversionRule #(0x280L, 0x0L) #(0x896ef2fcL, 0x44bd743fL) conversionType:1
	-- Conversion from Legacy Mix map to Arnold Mix RGBA
	SceneConverter.AddConversionRule #(0x230L, 0x0L) #(0x7e73161fL, 0x466aad8bL) conversionType:1
	-- Conversion from Legacy Vertex Color map to Arnold User Data map
	SceneConverter.AddConversionRule #(0x934851L, 0x0L) #(0x7e73161fL, 0xa7688c47L) conversionType:1
	-- Conversion from Vray Dirt to Arnold Ambient Occlusion
	SceneConverter.AddConversionRule #(0x2f567899L, 0x90d5ea4L) #(0x7e73161fL, 0x7b0e578eL) conversionType:1
	-- Conversion from Vray HDRI to Arnold Image
	SceneConverter.AddConversionRule #(0x6769144bL, 0x2c1017dL) #(0x7e73161fL, 0xad53b12aL) conversionType:1
	-- Conversion from Vray Normal Map to Arnold Normal map
	SceneConverter.AddConversionRule #(0x71fa6e51L, 0x72057c2fL) #(0x7e73161fL, 0x461fb78cL) conversionType:1
	-- Conversion from Vray Sky to Arnold Physical Sky
	SceneConverter.AddConversionRule #(0x48480b4eL, 0x62ff5a90L) #(0x7e73161fL, 0xac65bc64L) conversionType:1
	-- Conversion from Corona AO to Arnold Ambient Occlusion
	SceneConverter.AddConversionRule #(0x26ea4249L, 0x404b4b59L) #(0x7e73161fL, 0x7b0e578eL) conversionType:1
	-- Conversion from Corona Bitmap to Arnold Image
	SceneConverter.AddConversionRule #(0xabba5784L, 0x65484244L) #(0x7e73161fL, 0xad53b12aL) conversionType:1
	-- Conversion from Corona Color to MDColor
	SceneConverter.AddConversionRule #(0x68426dcaL, 0x372362d4L) #(0x7f9a7b9dL, 0x6fcdf00dL) conversionType:1
	-- Conversion from Corona Normal Map to Arnold Normal Map
	SceneConverter.AddConversionRule #(0x2870ceaaL, 0xcc18437cL) #(0x7e73161fL, 0x461fb78cL) conversionType:1
	-- Conversion from Corona Triplanar to Arnold Triplanar
	SceneConverter.AddConversionRule #(0xff299530L, 0x30c4bdeL) #(0x7e73161fL, 0x56f95788L) conversionType:1
	-- Conversion from Vray Color to MDColor
	SceneConverter.AddConversionRule #(0x58f82b74L, 0x73b75d7fL) #(0x7f9a7b9dL, 0x6fcdf00dL) conversionType:1
	-- Conversion from Vray Light  to Arnold Light
	SceneConverter.AddConversionRule #(0x3c5575a1L, 0x5fd602dfL) #(0x6705f00dL, 0xca131d05L) conversionType:1
	-- Conversion from Vray Light Material to Physical Material
	SceneConverter.AddConversionRule #(0x7ccf263eL, 0x3f5b39b9L) #(0x3d6b1cecL, 0xdeadc001L) conversionType:1
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

