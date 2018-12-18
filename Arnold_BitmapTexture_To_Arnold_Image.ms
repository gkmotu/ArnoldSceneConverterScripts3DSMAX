--The scripts should always contain at least 10 functions :ScriptID, DisplaySourceName(), SourceSuperClassID(), SourceClassID(), DisplayDestinationName() DestinationSuperClassID(), DestinationClassID(), AboutText() and DefaultConversion, Conversion taking a param.
--Script ID that will append to destination
fn ScriptID = 
(
	""
)

--Return the name to be display for the source in the Scene Converter UI
fn DisplaySourceName =
(
	"Bitmap Texture"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3088 --Texture
)
--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(0x240L, 0x0L) --Bitmap Texture
)

--Return the name to be display for the destination in the Scene Converter UI
fn DisplayDestinationName =
(
		"Arnold Image"
)

--Returns the destination class of the super class id
fn DestinationSuperClassID =
(
	3088 --Texture
)
--Returns the class id of the class we use as a destination for conversion
-- so we convert from SourceClassID() to DestinationClassID()
fn DestinationClassID =
(
	#(2121471519L, 2907943210L) --Arnold Image
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
	"About Text"
)


--Internal function that does the parameter mapping
fn ConvertFrom_BitmapTextureToArnoldImage Source Dest =
(
	if ( false == VerifySource Source or 
		 false == VerifyDestination Dest
		) do
	(
		--Not the suitable nodes
		return undefined
	)
	----- Put shit here
	Dest.filename = Source.fileName
	----- Put shit here
)

--This function is used as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case the default parameters are loaded.
fn DefaultConversion source /*not used*/ =
(
	newTexture = ai_image()
	
	--return the new texture
	newTexture
)

--Main entry point from this script
--This function handles the texture's creation
fn Conversion BBitmapTexture =
(
	if (false == VerifySource BBitmapTexture )  do
	(
		--Not the suitable node
		return undefined
	)	
	
	newTexture = ai_image()
	
	--Call the parameters mapping function to convert
	ConvertFrom_BitmapTextureToArnoldImage BBitmaptexture newTexture
	
	if (IsProperty BBitmaptexture "name") and (undefined != BBitmaptexture.name) and (String == classof BBitmaptexture.name)  and (IsProperty newTexture "name") do
	(
		newTexture.name = BBitmaptexture.name
	)
	
	--return the new texture
	newTexture
)