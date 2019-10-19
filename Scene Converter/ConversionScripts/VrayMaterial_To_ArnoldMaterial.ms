/*  

Vray to Arnold Material converter script.

v0.1a
14th August 2019

Supported slots and functions:

- Diffuse color
- Diffuse Texture
- Opacity
- Bump to Normal ( an additional Arnold bump2D node is added. )

gkmotu@gmail.com for bugs

*/

--Script ID that will append to destination
fn ScriptID = 
(
	""
)

--Return the name to be display for the source in the Scene Converter UI
fn DisplaySourceName =
(
	"Vray Material"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3072 --Material
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(935280431L, 1882483036L) --Vray Material classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"Arnold Standard Surface"
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
	#(2121471519L, 1660373836L) --Arnold Standard Material
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
	"Converts a Vray material to an Arnold Standard Surface"
)


/* aiSSurface Basic Params Group */
fn SetBaseColor aiSSurface source =
( 
	aiSSurface.base_color 				= source.diffuse				-- Diffuse RGB Color
	aiSSurface.base_color_shader 			= source.texmap_diffuse				-- Diffuse Texture
	aiSSurface.base_connected 			= source.texmap_diffuse_on			-- Map on/off

	aiSSurface.diffuse_roughness 			= source.diffuse_roughness			-- Diffuse roughness Float
	aiSSurface.diffuse_roughness_shader 		= source.texmap_roughness			-- Roughness Texture
	aiSSurface.diffuse_roughness_connected 		= source.texmap_roughness_on			-- Map on/off
	

	aiSSurface.emission_color 			= source.selfIllumination			-- Emission color
	aiSSurface.emission				= source.selfIllumination_multiplier		-- Emission float
	aiSSurface.emission_color_shader		= source.texmap_self_illumination		-- Emission Texture
	aiSSurface.emission_color_connected		= source.texmap_self_illumination_on		-- Map on/off

	-- Specular color needs to go to Arnold float as well
	aiSSurface.specular_color 			= source.reflection				-- Specular RGB Color
	aiSSurface.specular_roughness 			= source.reflection_glossiness			-- Specular Roughness float
	aiSSurface.specular_color_shader		= source.texmap_reflection			-- Specular Texture
	aiSSurface.specular_color_connected		= source.texmap_reflection_on			-- Map on/off

	aiSSurface.specular_roughness_shader		= source.texmap_reflectionGlossiness		-- Specular Roughness Texture
	aiSSurface.specular_roughness_connected		= source.texmap_reflectionGlossiness_on		-- Map on/off

	aiSSurface.specular_IOR				= source.reflection_ior				-- Specular IOR
	aiSSurface.metalness				= source.reflection_metalness			-- Metalness float
	aiSSurface.metalness_shader 			= source.texmap_metalness			-- Metalness Texture
	aiSSurface.metalness_connected 			= source.texmap_metalness_on			-- Map on/off




	--- Vray reflection color to float.
	
	
	
	if(source.refraction != undefined) do
	(
	aiSSurface.transmission = source.refraction.r/255
	)
	if(source.refraction == undefined) do
	(
	aiSSurface.transmission = 0
	)
	
	
	
	
	
	
	
	vrayRefraction = source.refraction
	
	
		
		
	aiSSurface.transmission_color			= vrayRefraction				-- Transmission RGB color
	aiSSurface.transmission_shader			= source.texmap_refraction			-- Transmission texture
	aiSSurface.transmission_connected		= source.texmap_refraction_on			-- Transmission map on/off

	aiSSurface.opacity_shader 			= source.texmap_opacity				-- Opacity Texture
	aiSSurface.opacity_connected 			= source.texmap_opacity_on			-- Map on/off


)
	



fn SetSpecialMaps aiSSurface source =
(
	-- Normal takes original Bump map through a Bump2D shader 
	if(source.texmap_bump != undefined) do
	(
		local Bump2DMap = ai_bump2d name:"Bump"
	
		Bump2DMap.bump_map_shader = source.texmap_bump
		Bump2DMap.bump_map = 1.0
		Bump2DMap.bump_height = source.texmap_bump_multiplier / 5.0f -- look into calibrating.
	
		aiSSurface.normal_shader = Bump2DMap
	)
	
	aiSSurface.normal_connected = source.texmap_bump_on
	
)

	
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
	SetSpecialMaps aiSSurface source
	
	
	-- Functions	

	aiSSurface
)

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the aiSSurface material
	newMat = standard_surface()
	
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
	newMat = ai_standard_surface()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)
