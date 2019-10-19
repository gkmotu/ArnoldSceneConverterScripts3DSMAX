/*  

Legacy Composit to OSL Layers converter script.

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
	"Legacy Composit map"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3088 --Map
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(640L, 0L) --Legacy Composit map classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"OSL Layers"
)

--Returns the destination class of the super class id
fn DestinationSuperClassID =
(
	3088 --Map
)
--Returns the class id of the class we use as a destination for conversion
-- so we convert from SourceClassID() to DestinationClassID()
fn DestinationClassID =
(
	#(2305749756L, 1153266751L) --OSL Layers
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
	"Convert Legacy Composit map to OSL Layers map"
)


/* aiSSurface Basic Params Group */
fn SetBaseColor aiSSurface source =
( 
	-- aiSSurface.base_color 				= source.diffuse				-- Diffuse RGB Color


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

	-- SetBaseColor aiSSurface source
	--SetSpecialMaps aiSSurface source
	
	
	-- Functions	
	
	newmap = OSL_Layers()
aiSSurface.sourceMap = newmap

/*
aiSSurface.sourceMap.Visibility1 = source.opacity[1]
aiSSurface.sourceMap.Visibility2 = source.opacity[2]
aiSSurface.sourceMap.Visibility3 = source.opacity[3]
aiSSurface.sourceMap.Visibility4 = source.opacity[4]
aiSSurface.sourceMap.Visibility5 = source.opacity[5]
aiSSurface.sourceMap.Visibility6 = source.opacity[6]
aiSSurface.sourceMap.Visibility7 = source.opacity[7]
aiSSurface.sourceMap.Visibility8 = source.opacity[8]
aiSSurface.sourceMap.Visibility9 = source.opacity[9]
aiSSurface.sourceMap.Visibility10 = source.opacity[10]


*/
aiSSurface.sourceMap.Layer1_map = source.maplist[1]
aiSSurface.sourceMap.Layer2_map = source.maplist[2]
aiSSurface.sourceMap.Layer3_map = source.maplist[3]
aiSSurface.sourceMap.Layer4_map = source.maplist[4]
aiSSurface.sourceMap.Layer5_map = source.maplist[5]
aiSSurface.sourceMap.Layer6_map = source.maplist[6]
aiSSurface.sourceMap.Layer7_map = source.maplist[7]
aiSSurface.sourceMap.Layer8_map = source.maplist[8]
aiSSurface.sourceMap.Layer9_map = source.maplist[9]
aiSSurface.sourceMap.Layer10_map = source.maplist[10]


aiSSurface.sourceMap.Layer1Mix_map = source.mask[1]
aiSSurface.sourceMap.Layer2Mix_map = source.mask[2]
aiSSurface.sourceMap.Layer3Mix_map = source.mask[3]
aiSSurface.sourceMap.Layer4Mix_map = source.mask[4]
aiSSurface.sourceMap.Layer5Mix_map = source.mask[5]
aiSSurface.sourceMap.Layer6Mix_map = source.mask[6]
aiSSurface.sourceMap.Layer7Mix_map = source.mask[7]
aiSSurface.sourceMap.Layer8Mix_map = source.mask[8]
aiSSurface.sourceMap.Layer9Mix_map = source.mask[9]
aiSSurface.sourceMap.Layer10Mix_map = source.mask[10]





)

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the aiSSurface material
	newMat = MultiOutputChannelTexmapToTexmap()
	
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
	newMat = MultiOutputChannelTexmapToTexmap()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)

