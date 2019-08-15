/*  
Corona to Arnold Material converter script.

v0.1a
15th August 2019

Supported slots and functions:

- Diffuse color
- Diffuse Texture
- Bump to Normal ( an additional Arnold bump2D node is added. )
- Specular

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
	"Corona Material"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3072 --Material
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(1891525894L, 1149841885L) --Corona Material classid 
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
	"Converts a Corona material to an Arnold Standard Surface"
)


/* aiSSurface Basic Params Group */


fn SetBaseColor aiSSurface source =
( 
	aiSSurface.base_color = source.colorDiffuse
	aiSSurface.base_color_shader = source.texmapDiffuse
	aiSSurface.specular_shader = source.texmapReflect
	
)


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
