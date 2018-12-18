--The scripts should always contain at least 10 functions :ScriptID, DisplaySourceName(), SourceSuperClassID(), SourceClassID(), DisplayDestinationName() DestinationSuperClassID(), DestinationClassID(), AboutText() and DefaultConversion, Conversion taking a param.
--Script ID that will append to destination
fn ScriptID = 
(
	""
)

--Return the name to be display for the source in the Scene Converter UI
fn DisplaySourceName =
(
	~STANDARD_MATERIAL~
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3072 --Material
)
--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(2L, 0L) --Standard Material classid
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	~PHYSICAL_MATERIAL~
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
	#(0x3d6b1cecL, 0xdeadc001L) --Physical Material
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
	local dest = DestinationClassID()

	if(destination == undefined) do return false
	
	if(classof dest[1] == Array) then
    (
		for cd in dest do
		(
			if((cd as string) == (destination.ClassID as string)) do
			(
				ret = true
			)
		)
	)
    else
	(
		if((dest as string) == (destination.ClassID as string)) do
		(
			ret = true
		)
	)
    ret 
)

--Returns some information about this conversion script
fn AboutText =
(
	~ABOUT_TEXT~
)

fn ConvertDiffuseColorToBaseColor source dest = 
(
    dest.base_color = source.diffuse
    dest.base_color_map = source.diffuseMap
    dest.base_color_map_on = source.diffuseMapEnable
)

fn ConvertDiffuseLevelToBaseColorWeight source dest =
(
    dest.base_weight = source.diffuseLevel / 100
    dest.base_weight_map = source.diffuseLevelMap
    dest.base_weight_map_on = source.diffuseLevelMapEnable
)

fn ConvertDiffuseRoughness source dest =
(
    dest.diff_roughness = source.DiffuseRoughness
    dest.diff_rough_map = source.DiffuseRoughnessMap
    dest.diff_rough_map_on = source.DiffuseRoughnessMapEnable
)

fn ConvertSpecularColorToReflectivityColor source dest =
(
    dest.refl_color = source.specular
    dest.refl_color_map = source.specularMap
    dest.refl_color_map_on = source.specularMapEnable
)

fn ConvertSpecularLevelToReflectivity source dest = 
(
    dest.reflectivity = source.specularLevel / 100
    dest.reflectivity_map = source.specularLevelMap
    dest.reflectivity_map_on = source.specularLevelMapEnable
)

fn ConvertGlossinessToRoughness source dest = 
(
    dest.roughness_inv = true
    dest.roughness = (source.glossiness /100)
	dest.roughness_map = source.glossinessMap
    dest.roughness_map_on = source.glossinessMapEnable
)

fn ConvertAnisotropy source dest = 
(
    dest.anisotropy = source.anisotropy / 100
    dest.anisotropy_map = source.anisotropyMap
    dest.anisotropy_map_on = source.anisotropyMapEnable
    
    dest.anisoangle = source.orientation 
    dest.aniso_angle_map = source.OrientationMap
    dest.aniso_angle_map_on = source.OrientationMapEnable
)

fn ConvertSelffIllumToEmission source dest =
(
    dest.emission = source.selfIllumAmount
    if(source.useSelfIllumColor) then
    (
        dest.emit_color = source.selfIllumColor / 100    
    )
    else
    (
        dest.emit_color_map = source.selfIllumMap
        dest.emit_color_map_on = source.selfIllumMapEnable
    )
)

fn ConvertOpacityToTransparency source dest = 
(
    dest.transparency = 1.0 - (source.opacity /100)
    --Cannot transfer opacity map, has it should be the reverse of the transparency map
    
    dest.trans_color = source.filterColor
    dest.trans_color_map = source.filterMap
    dest.trans_color_map_on = source.filterMapEnable  
    
    dest.trans_ior = source.ior
)

fn ConvertFromAnisotropicShader source dest =
(
    ConvertDiffuseColorToBaseColor source dest
    ConvertDiffuseLevelToBaseColorWeight source dest
    ConvertSpecularColorToReflectivityColor source dest
    ConvertSpecularLevelToReflectivity source dest
    ConvertGlossinessToRoughness source dest
    ConvertAnisotropy source dest
    ConvertOpacityToTransparency source dest
    ConvertSelffIllumToEmission source dest
)

fn ConvertFromBlinnShader source dest = 
(
    ConvertDiffuseColorToBaseColor source dest    
    ConvertSpecularColorToReflectivityColor source dest
    ConvertSpecularLevelToReflectivity source dest
    ConvertGlossinessToRoughness source dest
    ConvertOpacityToTransparency source dest
    ConvertSelffIllumToEmission source dest
)

fn ConvertFromMetalShader source dest =
(
    ConvertDiffuseColorToBaseColor source dest  
   
    dest.metalness = source.specularLevel / 100
    dest.metalness_map = source.specularLevelMap
    dest.metalness_map_on = source.specularLevelMapEnable

    ConvertGlossinessToRoughness source dest    
    ConvertSelffIllumToEmission source dest       
    ConvertSelffIllumToEmission source dest   
)

fn ConvertFromMultiLayerShader source dest =
(
    ConvertDiffuseColorToBaseColor source dest
    ConvertDiffuseLevelToBaseColorWeight source dest   
    ConvertDiffuseRoughness source dest 
    
    --Convert first layer to reflection
    ConvertSpecularColorToReflectivityColor source dest
    ConvertSpecularLevelToReflectivity source dest
    
    --second layer to coating
    dest.coat_color = source.specular2
    dest.coat_color_map = source.specularMap2
    dest.coat_color_map_on = source.specularMap2Enable
    
    dest.coating = source.specularLevel2
    dest.coat_map = source.specularLevelMap2
    dest.coat_map_on = source.specularLevelMap2Enable    
    
    dest.coat_roughness_inv = true
    dest.coat_roughness = source.glossiness2 /100
	
    --I don't know if the map has any value here, since we don't do a 1 to 1 glossiness to roughness conversion
    dest.coat_rough_map = source.glossinessMap2
    dest.coat_rough_map_on = source.glossinessMap2Enable
    
    --second layer anisotropy is ignored    
    
    ConvertOpacityToTransparency source dest
    ConvertSelffIllumToEmission source dest    
)

fn ConvertFromOrenNayarBlinnShader source dest = 
(
    ConvertDiffuseColorToBaseColor source dest
    ConvertDiffuseLevelToBaseColorWeight source dest   
    ConvertDiffuseRoughness source dest 
    ConvertSpecularColorToReflectivityColor source dest
    ConvertSpecularLevelToReflectivity source dest
    ConvertGlossinessToRoughness source dest
    ConvertOpacityToTransparency source dest
    ConvertSelffIllumToEmission source dest
)

fn ConvertFromPhongShader source dest = 
(
    ConvertDiffuseColorToBaseColor source dest    
    ConvertSpecularColorToReflectivityColor source dest
    ConvertSpecularLevelToReflectivity source dest
    ConvertGlossinessToRoughness source dest
    ConvertOpacityToTransparency source dest
    ConvertSelffIllumToEmission source dest  
)

fn ConvertFromStraussShader source dest = 
(
    ConvertDiffuseColorToBaseColor source dest
    ConvertGlossinessToRoughness source dest
    ConvertOpacityToTransparency source dest    

    dest.metalness = source.metalness / 100
    dest.metalness_map = source.metalnessMap
    dest.metalness_map_on = source.metalnessMapEnable
)

fn ConvertFromTranslucentShader source dest =
(
    ConvertDiffuseColorToBaseColor source dest
    ConvertDiffuseLevelToBaseColorWeight source dest   
    ConvertSpecularColorToReflectivityColor source dest
    ConvertSpecularLevelToReflectivity source dest
    ConvertGlossinessToRoughness source dest
    ConvertSelffIllumToEmission source dest

    dest.transparency = 1.0 - (source.opacity /100)
    --Cannot transfer opacity map, has it should be the reverse of the transparency map
    
    dest.trans_color = source.filter
    dest.trans_color_map = source.filterMap
    dest.trans_color_map_on = source.filterMapEnable  
)

--Internal function that does the parameter mapping
fn ConvertFrom_StandardToPhysical source dest =
(
	if ( false == VerifySource Source or 
		 false == VerifyDestination Dest
		) do
	(
		--Not the suitable nodes
		return undefined
	)

    dest.material_mode = 1 --Advanced
    
    if  (IsProperty source "shaderType") do
    (
        case source.shaderType of
        (
            0 : --Anisotropic
            ConvertFromAnisotropicShader source dest
            1 : --Blinn
            ConvertFromBlinnShader source dest
            2 : --Metal
            ConvertFromMetalShader source dest
            3 : --Multi-Layer
            ConvertFromMultiLayerShader source dest
            4 : --Oren-Nayar-Blinn
            ConvertFromOrenNayarBlinnShader source dest
            5: --Phong
            ConvertFromPhongShader source dest
            6: --Strauss
            ConvertFromStraussShader source dest
            7: --Translucent
            ConvertFromTranslucentShader source dest
        )
    )
    
    if  (IsProperty source "BumpMap") do(
        dest.bump_map = source.BumpMap
    )
    if  (IsProperty source "BumpMapEnable") do(
        dest.bump_map_on = source.BumpMapEnable
    )
    if  (IsProperty source "BumpMapAmount") do(
        dest.bump_map_amt = source.BumpMapAmount / 100 
    )
    
    if  (IsProperty source "DisplacementMap") do(
        dest.displacement_map = source.DisplacementMap
    )
    if  (IsProperty source "DisplacementMapEnable") do(
        dest.displacement_map_on = source.DisplacementMapEnable
    )
    if  (IsProperty source "DisplacementMapAmount") do(
        dest.displacement_map_amt = source.DisplacementMapAmount
	)
	Dest
)

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the dest material
	newMat = PhysicalMaterial()
	
	--return the new material
	newMat

)

--Main entry point from this script
--This function handles the material's creation
fn Conversion standardmat =
(
	if (false == VerifySource standardmat )  do
	(
		--Not the suitable node
		return undefined
	)	
	
	--Create the dest material
	newMat = PhysicalMaterial()
	
	--Call the parameters mapping function to convert
	ConvertFrom_StandardToPhysical standardmat newMat

    if (IsProperty standardmat "name") and (undefined != standardmat.name) and (String == classof standardmat.name)  and (IsProperty newMat "name") do
    (
        newMat.name = standardmat.name
    )

	--return the new material
	newMat
)
