/*  

Vray Light Material to Arnold Material converter script.

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
	"Vray Light Material"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3072 --Material
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(2093950526L, 1062943161L) --Vray Light  classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"Physical Material"
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
	#(1030429932L, 3735928833L) --Physical Material
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
	"Converts a Vray Light material to a Physical Material"
)


/* aiSSurface Basic Params Group */
fn SetBaseColor aiSSurface source =
( 
	-- reset initial emission based output
	aiSSurface.base_weight = 0.0
	aiSSurface.emission = 1.0

	-- Additional Attributes

	aiSSurface.emit_color = source.color
	aiSSurface.emit_color_map_on = source.texmap_on
	aiSSurface.emit_color_map = source.texmap

	local physical_scale = 1500

	if(source.compensate_exposure) do
	(
		local p = SceneExposureControl.exposureControl

		if p != undefined do 
		(
		   physical_scale = p.physical_scale
		)

		aiSSurface.emit_luminance = source.multiplier / 3.1415 * physical_scale
   )


   -- Cutout map

   aiSSurface.cutout_map_on = source.opacity_texmap_on
   aiSSurface.cutout_map = source.opacity_texmap

	

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
	
	
	
	-- Functions	

	aiSSurface
)

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the aiSSurface material
	newMat = PhysicalMaterial()
	
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
	newMat = PhysicalMaterial()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)
