--The scripts should always contain at least 10 functions :ScriptID, DisplaySourceName(), SourceSuperClassID(), SourceClassID(), DisplayDestinationName() DestinationSuperClassID(), DestinationClassID(), AboutText() and DefaultConversion, Conversion taking a param.
--Script ID that will append to destination
fn ScriptID = 
(
	""
)

--Return the name to be display for the source in the Scene Converter UI
fn DisplaySourceName =
(
	"Standard Material"
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
	"Arnold Material"
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
	#(2121471519L, 1660373836L)--Arnold Material
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
	"About text"
)

--Internal function that does the parameter mapping
fn ConvertFrom_StandardToArnold source dest =
(
	if ( false == VerifySource Source or 
		 false == VerifyDestination Dest
		) do
	(
		--Not the suitable nodes
		return undefined
	)

	-- Put shit here
	Dest.base_color_shader = Source.diffuseMap
	Dest.opacity_shader = Source.opacityMap
	-- Put shit here
    
  
)


--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the dest material
	newMat = ai_standard_surface()
	
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
	newMat = ai_standard_surface()
	
	--Call the parameters mapping function to convert
	ConvertFrom_StandardToArnold standardmat newMat

    if (IsProperty standardmat "name") and (undefined != standardmat.name) and (String == classof standardmat.name)  and (IsProperty newMat "name") do
    (
        newMat.name = standardmat.name
    )

	--return the new material
	newMat
)
