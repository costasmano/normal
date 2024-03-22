//Method: [Templates];"Input".3D Button

C_OBJECT:C1216($header; $headerpic)

C_POINTER:C301($Wparea_ptr)
$Wparea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
C_PICTURE:C286($pict)
C_BLOB:C604($imagetempl)
C_COLLECTION:C1488($pics_co; $anchored_co; $inline_co)
C_OBJECT:C1216($pic_o)
$pics_co:=WP Get elements:C1550($Wparea_ptr->; wk type image:K81:192)
$anchored_co:=WP Get elements:C1550($Wparea_ptr->; wk type image anchored:K81:248)
$inline_co:=WP Get elements:C1550($Wparea_ptr->; wk type image inline:K81:247)
For each ($pic_o; $pics_co)
	WP GET ATTRIBUTES:C1345($pic_o; wk image:K81:169; $pict)
	SET PICTURE TO PASTEBOARD:C521($pict)
End for each 
CONFIRM:C162("Do from template IMG_BMSLetterHead_MAC or file"; "Template"; "File")
If (Ok=1)
	SET BLOB SIZE:C606($imagetempl; 0)
	Begin SQL
		select [Templates].[Template_]
		from [templates]
		where [Templates].[TemplateName] = 'IMG_BMSLetterHead_MAC'
		into :$imagetempl ;
	End SQL
	BLOB TO VARIABLE:C533($imagetempl; $pict)
	SET PICTURE TO PASTEBOARD:C521($pict)
	$headerpic:=WP Add picture:C1536($Wparea_ptr->; $pict)
Else 
	C_TEXT:C284($logo)
	ARRAY TEXT:C222($logos_atxt; 0)
	$logo:=Select document:C905(""; ""; "Pick the logo"; 0; $logos_atxt)
	
	If (OK=1)
		
		DOCUMENT TO BLOB:C525($logos_atxt{1}; $imagetempl)
		BLOB TO PICTURE:C682($imagetempl; $pict)
		C_OBJECT:C1216($header_o)
		$header_o:=WP Get header:C1503($Wparea_ptr->; 1)
		WP INSERT PICTURE:C1437($header_o; $pict; wk replace:K81:177)
		
		//$headerpic:=WP Add picture($Wparea_ptr->;$pict)
		
	End if 
	
End if 

//WP SET ATTRIBUTES($headerpic;wk anchor origin;wk header box)
//WP SET ATTRIBUTES($headerpic;wk anchor horizontal align;wk center)
//WP SET ATTRIBUTES($headerpic;wk anchor vertical align;wk center)
//WP SET ATTRIBUTES($headerpic;wk width;"8.25in";wk height;wk auto)
//End [Templates].Input.3D Button