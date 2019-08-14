/* The scripts should always contain at least 10 functions :
	ScriptID, 
	DisplaySourceName(), 
	SourceSuperClassID(), 
	SourceClassID(), 
	DisplayDestinationName() 
	DestinationSuperClassID(), 
	DestinationClassID(), 
	AboutText() and 
	DefaultConversion, Conversion taking a param.
	
This script will have all aiSSurface Surface parameters within a function group, and some lines will be commented-out if params are not represented in the source material
	
*/

/* Class IDs"
 as reported by $.material.classid as string

 Physical Material Source:		"#(1030429932L, 3735928833L)"
 Arnold Standard Destination:	"#(2121471519L, 1660373836L)"
 
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
	aiSSurface.base_color = source.diffuse
	



	-- aiSSurface.base = source.base_weight
	-- aiSSurface.base_shader = source.base_weight_map
	-- aiSSurface.base_connected = source.base_weight_map_on
	
	
	-- aiSSurface.base_color_shader = source.base_color_map
	-- aiSSurface.base_color_connected = source.base_color_map_on
	
	-- aiSSurface.diffuse_roughness = source.diff_roughness
	-- aiSSurface.diffuse_roughness_shader = source.diff_rough_map
	-- aiSSurface.diffuse_roughness_connected = source.diff_rough_map_on
	
	-- aiSSurface.caustics = source. 
	-- aiSSurface.indirect_diffuse = source.
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
	
    
	
	
	aiSSurface.opacity_shader = source.texmap_opacity
	aiSSurface.opacity_connected = source.texmap_opacity_on
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
