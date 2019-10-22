/*  

Corona Color to MDColor


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
	"Corona Color"
)

--Returns the source class of the super class id 
fn SourceSuperClassID =
(
	3088 --Map
)

--Returns the class id of the source class we use as a source for conversion
fn SourceClassID =
(
	#(1749183946L, 925065940L) --Corona Color classid 
)

--Return the name to be display for the destination in the Scene Converter UI - must be in the order than the destination class ids
fn DisplayDestinationName =
(
	"MDColor"
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
	#(2140830621L, 1875767309L) --MDColor map
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
	"Converts a Corona Bitmap to an Arnold Image node"
)


/* aiSSurface Basic Params Group */
fn SetBaseColor aiSSurface source =
( 
if ( source.method == 0 ) do
	(
		aiSSurface.Mode = "Color" 
	)	
	
	if ( source.method == 1 ) do
	(
		aiSSurface.Mode = "RGB"
				
	)	

	if ( source.method == 2 ) do
	(
		aiSSurface.Mode = "Kelvin"
	)




	aiSSurface.Color = source.color
	aiSSurface.RGB = source.colorHdr
	aiSSurface.Kelvin = source.temperature
	


		

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

--This function is use as entry when the source is missing (due to a missing plugin) and cannot be completly loaded. 
--In that case a default object is created and returned.
fn DefaultConversion source /*Not used*/=
(
	--Create the aiSSurface material
	newMat = OSL_MDColor()
	
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
	newMat = OSL_MDColor()
	
	--Call the parameters mapping function to convert
	ConvertFromSourceToaiSSurface sourceMat newMat
	
	--return the new material
	newMat
)
