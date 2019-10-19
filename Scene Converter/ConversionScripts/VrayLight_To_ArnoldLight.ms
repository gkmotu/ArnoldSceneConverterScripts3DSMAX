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
	"Vray Light "
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	48 --Light
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(1012233633L, 1607860959L) --Vray Light  classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"Arnold Light"
)

--Returns the destination class of the super class id
fn DestinationSuperClassID =
(
	48 --Light
)
--Returns the class id of the class we use as a destination for conversion
-- so we convert from SourceClassID() to DestinationClassID()
fn DestinationClassID =
(
	#(1728442381L, 3390250245L) --Arnold Light
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
	"Converts a Vray Light to Arnold Light"
)


/* aiSSurface Basic Params Group */
fn SetBaseColor aiSSurface source =
( 
	

	

	-- Area Light
	
	if ( 0 == source.type ) do 
	(
		aiSSurface.shapeType = 3
		
		aiSSurface.portal 						= source.skylightPortal 
		aiSSurface.quadX 						= source.sizeLength
		aiSSurface.quadY 						= source.sizeWidth
		aiSSurface.exposure 					= 8.0f
		aiSSurface.intensity 					= source.multiplier*10.0f
		aiSSurface.lightShapeVisible			= on
		aiSSurface.on 							= source.on								
		aiSSurface.cast_shadows					= source.castShadows					
		
		aiSSurface.texmap						= source.texmap							
		
		aiSSurface.rotation 					= source.rotation
		aiSSurface.pos 							= source.pos
		
		
		if ( source.color_mode == 0 ) do
		(
		aiSSurface.usecolor 					= on
		aiSSurface.color						= source.color							
		)
		
		
		if ( source.color_mode == 1 ) do
		(
		aiSSurface.usekelvin 					= on
		aiSSurface.kelvin 						= source.color_temperature
		
		)
		
		if ( source.texmap_on == off ) do
		(
		aiSSurface.texmap 						= ()										-- We assume the reason to disable means the map does not need to transfer. Else..let me know if you need this.
		
		
		)
		
		
		
		if ( source.nodecay == off ) do
		(
		aiSSurface.normalize 					= on
		)
		if ( source.nodecay == on ) do
		(
		aiSSurface.normalize 					= off
		)
		
		source.targeted 						= off
		aiSSurface.targdist						= 1
				
		
	)
	
	-- Skydome Light
	
	if ( 1 == source.type ) do
	(
		aiSSurface.shapeType = 6
	)
	
	
	-- Point Light
	
	if ( 2 == source.type ) do 
	(
		aiSSurface.shapeType = 0
	)
	
	
	-- Mesh Light
	
	if ( 3 == source.type ) do 
	(
		aiSSurface.shapeType = 8
		aiSSurface.lightMesh = source.mesh_source
	
	)
	
	
	-- Disc Light
	
	if ( 4 == source.type ) do 
	(
		aiSSurface.shapeType = 4
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
   
		
    	
	-- Functions

	SetBaseColor aiSSurface source
	
	
	
	-- Functions	

	aiSSurface
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
	newMat = Arnold_Light()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)



































