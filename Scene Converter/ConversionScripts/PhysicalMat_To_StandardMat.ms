/*  
Physical to Legacy standard Material converter script.

*/

--Script ID that will append to destination
fn ScriptID = 
(
	""
)

--Return the name to be display for the source in the Scene Converter UI
fn DisplaySourceName =
(
	"Physical Material"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3072 --Material
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(1030429932L, 3735928833L) --Physical Material classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"Legacy Standard"
)

--Returns the destination class of the super class id
fn DestinationSuperClassID =
(
	3072 --Material
)
--Returns the class id of the class we use as a destination for conversion
-- so we convert from SourceClassID() to DestinationClassID()
fn DestinationClassID =
(
	#(2L, 0L) --Legacy Standard Material
)

--Validate that the source provided match with one of the SourceClass
fn VerifySource source =
(
	local ret = false	
	local src = SourceClassID()
	
	if(source == undefined) do return false
	
	if(classof src[1] == Array) then
    (
		for cd in src do
		(
			if((cd as string) == (source.ClassID as string)) do
			(
				ret = true
			)
		)
	)
    else
	(
		if((src as string) == (source.ClassID as string)) do
		(
			ret = true
		)
	)
    ret 
)

--Validate that the destination provided match with one of the DestinationClass
fn VerifyDestination destination =
(
	local ret = false	
	local aiSSurface = DestinationClassID()

	if(destination == undefined) do return false
	
	if(classof aiSSurface[1] == Array) then
    (
		for cd in aiSSurface do
		(
			if((cd as string) == (destination.ClassID as string)) do
			(
				ret = true
			)
		)
	)
    else
	(
		if((aiSSurface as string) == (destination.ClassID as string)) do
		(
			ret = true
		)
	)
    ret 
)

--Returns some information about this conversion script
fn AboutText =
(
	"Converts a Corona material to an Arnold Standard Surface"
)


/* aiSSurface Basic Params Group */


fn SetBaseColor source dest  =
( 


fn ConvertDiffuseColorToBaseColor source dest = 
(
    dest.diffuse = source.base_color
	dest.diffuseMap = source.base_color_map
	dest.diffuseMapEnable = source.base_color_map_on
)
ConvertDiffuseColorToBaseColor dest source


fn ConvertSpecularLevelToReflectivity source dest = 
(
    dest.specularlevel = source.reflectivity * 100
    dest.specularLevelMap = source.reflectivity_map
    dest.specularLevelMapEnable = source.reflectivity_map_on
)

ConvertSpecularLevelToReflectivity dest source


fn ConvertGlossinessToRoughness source dest = 
(
   
    dest.glossiness = source.roughness*100
	dest.glossinessMap = source.roughness_map
    dest.glossinessMapEnable = source.roughness_map_on
)

ConvertGlossinessToRoughness dest source


fn ConvertOpacityToTransparency source dest = 
(
	dest.opacity = 100
	-- dest.opacity =  (source.transparency *100)
    --Convert an opacity map to a cutout
    dest.opacityMap    = source.cutout_map
    dest.opacityMapEnable = source.cutout_map_on
    
    dest.filterColor = source.trans_color
    dest.filterMap = source.trans_color_map
    dest.filterMapEnable = source.trans_color_map_on  
    
    dest.ior = source.trans_ior
)

ConvertOpacityToTransparency dest source



 
-- Normals, check if Legacy normal, Vray normal, Corona normal is present and convert, else stick in a bump2d node.
/*
if (  classof source.texmapBump == VRayNormalMap or classof source.texmapBump == normal_bump or classof source.texmapBump == coronanormal or source.texmapBump ==undefined  ) then
	(	
		aiSSurface.normal_shader = source.texmapBump
	)	
	
	else
	
	(
		local Bump2DMap = ai_bump2d name:"Bump"
	
		Bump2DMap.bump_map_shader = source.texmapBump
		Bump2DMap.bump_map = 1.0
		Bump2DMap.bump_height = 1.0
	
		aiSSurface.normal_shader = Bump2DMap
	
	)

*/


)

/*
fn SetSpecialMaps aiSSurface source =
(
	-- Normal takes original Bump map through a Bump2D shader 
	if(source.texmapBump != undefined) do
	(
		local Bump2DMap = ai_bump2d name:"Bump"
	
		Bump2DMap.bump_map_shader = source.texmapBump
		Bump2DMap.bump_map = 1.0
		Bump2DMap.bump_height = source.mapamountBump / 5.0f -- look into calibrating.
	
		aiSSurface.normal_shader = Bump2DMap
	)
	
	
	

)

	*/
		
--Internal function that does the parameter mapping
fn ConvertFromSourceToaiSSurface source aiSSurface =
(
	if ( false == VerifySource Source or 
		 false == VerifyDestination aiSSurface
		) do
	(
		--Not the suitable nodes
		return undefined
	)
   
	aiSSurface.name = source.name	
    	
	-- Functions

	SetBaseColor aiSSurface source
	-- SetSpecialMaps aiSSurface source
	
	
	-- Functions	

	aiSSurface
)

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the aiSSurface material
	newMat = Standardmaterial()
	
	--return the new material
	newMat
)

--Main entry point from this script
--This function handles the material's creation
fn Conversion sourceMat =
(
	if (false == VerifySource sourceMat )  do
	(
		--Not the suitable node
		return undefined
	)	
	
	--Create the aiSSurface material
	newMat = Standardmaterial()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)
