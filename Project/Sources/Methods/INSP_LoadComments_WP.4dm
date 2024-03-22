//%attributes = {"invisible":true}
//Method: INSP_LoadComments_WP
//Description
// Load comments from a field into a Write Pro Area
// Parameters
// $1 : $ParamObj
//  // .WPAreaname
//  // .fieldptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/19/21, 10:37:36
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(INSP_LoadComments_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-12-20T00:00:00 14:32:47)
	Mods_2021_12_bug
	//  `
End if 
//

C_OBJECT:C1216($1)

C_POINTER:C301($fieldPtr)
C_TEXT:C284($WPAreaName)

$fieldPtr:=$1.fieldptr
$WPAreaName:=$1.WPAreaname

C_BLOB:C604($WPAreaExport; $SaveToField)
C_POINTER:C301($WParea_ptr)

$SaveToField:=$fieldPtr->
$WParea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $WPAreaName)


If (BLOB size:C605($SaveToField)=0)
	//empty 
	//start with blank area 
	C_OBJECT:C1216($body)
	//$WParea_ptr->:=WP New
	$WParea_ptr->:=INSP_InitializeWPArea(New object:C1471("templateType"; "normal"))
	$body:=WP Text range:C1341($WParea_ptr->; wk start text:K81:165; wk end text:K81:164)
	WP SET TEXT:C1574($body; ""; wk replace:K81:177; wk include in range:K81:180)
	WP SET ATTRIBUTES:C1342($body; wk font family:K81:65; "Arial"; wk font size:K81:66; 11)
	
Else 
	C_LONGINT:C283($blobCompression)
	BLOB PROPERTIES:C536($SaveToField; $blobCompression)
	If ($blobCompression#0)
		EXPAND BLOB:C535($SaveToField)
	End if 
	C_TEXT:C284($dataTag)
	C_LONGINT:C283($offset)
	$offset:=0
	BLOB TO VARIABLE:C533($SaveToField; $dataTag; $offset)
	
	If ($dataTag="WPAREA")
		BLOB TO VARIABLE:C533($SaveToField; $WPAreaExport; $offset)
		$WParea_ptr->:=WP New:C1317($WPAreaExport)
	Else 
		//do we do an alert????
	End if 
	
End if 
WP SET ATTRIBUTES:C1342($WParea_ptr->; wk layout unit:K81:78; wk unit inch:K81:172)
//  //End INSP_LoadComments_WP