/*  

Vray Blend Material to Arnold Layer Material converter script.


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
	"Vray Blend Material"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3072 --Material
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(1033896987L, 256077361L) --Vray Blend Material classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"Arnold Layer Material"
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
	#(2121471519L, 3311509149L) --Arnold Layer Material
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
	"Converts a Vray Blend material to an Arnold Layer Material"
)


/* aiSSurface Basic Params Group */
fn SetBaseColor aiSSurface source =
( 
	
	-- Enable
	aiSSurface.enable2 = source.coatMtl_enable[1]
	aiSSurface.enable3 = source.coatMtl_enable[2]
	aiSSurface.enable4 = source.coatMtl_enable[3]
	aiSSurface.enable5 = source.coatMtl_enable[4]
	aiSSurface.enable6 = source.coatMtl_enable[5]
	aiSSurface.enable7 = source.coatMtl_enable[6]
	aiSSurface.enable8 = source.coatMtl_enable[7]
	
	-- Blend map
	aiSSurface.mix2_shader = source.texmap_blend[1]
	aiSSurface.mix3_shader = source.texmap_blend[2]
	aiSSurface.mix4_shader = source.texmap_blend[3]
	aiSSurface.mix5_shader = source.texmap_blend[4]
	aiSSurface.mix6_shader = source.texmap_blend[5]
	aiSSurface.mix7_shader = source.texmap_blend[6]
	aiSSurface.mix8_shader = source.texmap_blend[7]
	
	-- Mix amount
	aiSSurface.mix2 = source.texmap_blend_multiplier[1]/100
	aiSSurface.mix3 = source.texmap_blend_multiplier[2]/100
	aiSSurface.mix4 = source.texmap_blend_multiplier[3]/100
	aiSSurface.mix5 = source.texmap_blend_multiplier[4]/100
	aiSSurface.mix6 = source.texmap_blend_multiplier[5]/100
	aiSSurface.mix7 = source.texmap_blend_multiplier[6]/100
	aiSSurface.mix8 = source.texmap_blend_multiplier[7]/100
	
	-- Material
	aiSSurface.input1 = source.baseMtl
	aiSSurface.input2 = source.coatmtl[1]
	aiSSurface.input3 = source.coatmtl[2]
	aiSSurface.input4 = source.coatmtl[3]
	aiSSurface.input5 = source.coatmtl[4]
	aiSSurface.input6 = source.coatmtl[5]
	aiSSurface.input7 = source.coatmtl[6]
	aiSSurface.input8 = source.coatmtl[7]
	


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

	
)

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the aiSSurface material
	newMat = ai_layer_shader()
	
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
	newMat = ai_layer_shader()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)
