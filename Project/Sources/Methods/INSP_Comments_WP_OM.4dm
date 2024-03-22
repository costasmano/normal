//%attributes = {"invisible":true}
//Method: INSP_Comments_WP_OM
//Description
// object method for Write Pro comments areas in inspection reports
// Parameters
// $1 : $ParamsObject .WPAreaname .fieldptr .formEvent .changeStack
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/15/21, 14:15:09
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_OBJECT:C1216(INSP_Comments_WP_OM; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-12-29T00:00:00 11:02:27)
	Mods_2021_12_bug
	//  `use the on data change event to mark the area as changed. - 
	//  `do clean up and save changes on Losing focus - This is because on data change fires even before leaving the area.
End if 
//
C_OBJECT:C1216($1)

C_TEXT:C284($MyArea_name)
C_POINTER:C301($Field_ptr; $WParea_ptr)
C_LONGINT:C283($FormEvent; $changeStack)

ARRAY TEXT:C222($Properties_a; 0)
OB GET PROPERTY NAMES:C1232($1; $Properties_a)
$MyArea_name:=$1.WPAreaname
$Field_ptr:=$1.fieldptr
$FormEvent:=$1.formEvent
$changeStack:=$1.changeStack

$WParea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $MyArea_name)

C_OBJECT:C1216(INSP_WPOrientation; INSP_WPGenRemarks; INSP_WPElemComments)

C_BLOB:C604($WPAreaExport; $SaveToField)

Case of 
	: ($FormEvent=On Load:K2:1)
		//initialize popup menu
		//OBJECT Get enterable(*;$MyArea_name)
		C_TEXT:C284(menuContext)
		If (menuContext="")
			menuContext:=INSP_CreateWPPopupMenu
		End if 
		//load 
		INSP_LoadComments_WP($1)
		
		OB SET:C1220($WParea_ptr->; "Modified"; False:C215)
		C_OBJECT:C1216($zoomprop_o)
		
		C_OBJECT:C1216(<>INSP_WPAreaZoom_o)
		ARRAY POINTER:C280($wpfieldptrs_aptr; 0)
		ARRAY LONGINT:C221($zooms_ar; 0)
		OB GET ARRAY:C1229(<>INSP_WPAreaZoom_o; "wpfieldpointers"; $wpfieldptrs_aptr)
		OB GET ARRAY:C1229(<>INSP_WPAreaZoom_o; "zooms"; $zooms_ar)
		
		If (Find in array:C230($wpfieldptrs_aptr; $Field_ptr)>0)
			$zoomprop_o:=New object:C1471
			$zoomprop_o[wk zoom:K81:283]:=$zooms_ar{Find in array:C230($wpfieldptrs_aptr; $Field_ptr)}
			$zoomprop_o[wk dpi:K81:86]:=0
			WP SET VIEW PROPERTIES:C1648($WParea_ptr->; $zoomprop_o)
		End if 
		$zoomprop_o:=WP Get view properties:C1649($WParea_ptr->)
		
	: ($FormEvent=On Data Change:K2:15)
		OB SET:C1220($WParea_ptr->; "Modified"; True:C214)  // mark that area has been changed
		$Field_ptr->:=$Field_ptr->  // mark record as changed too
		
	: ($FormEvent=On Losing Focus:K2:8)
		C_BOOLEAN:C305($wpchanged_b)
		$wpchanged_b:=OB Get:C1224($WParea_ptr->; "Modified"; Is boolean:K8:9)
		If ($wpchanged_b)
			WP_CleanupComments($WParea_ptr)
			//save data to the field now
			INSP_SaveComments_WP($1)
			OB SET:C1220($WParea_ptr->; "Modified"; False:C215)  // mark that area has been saved
			
		End if 
		
	: ($FormEvent=On Clicked:K2:4)
		
		If (Contextual click:C713)
			// Display my contextual menu defined in the "On load" form
			C_TEXT:C284($res)
			$res:=Dynamic pop up menu:C1006(menuContext)
			
			If ($res="Show spell dialog")
				//the spell check dialog does not cause a data change event
				//ALERT($res)
				C_OBJECT:C1216($range)
				$range:=WP Text range:C1341($WParea_ptr->; wk end text:K81:164; wk end text:K81:164)
				WP SET TEXT:C1574($range; " "; wk append:K81:179; wk include in range:K81:180)
				WP SET TEXT:C1574($range; ""; wk replace:K81:177; wk include in range:K81:180)
				
			End if 
		End if 
		
	: ($FormEvent=On Unload:K2:2)
		
		C_OBJECT:C1216($viewProps_o)
		$viewProps_o:=WP Get view properties:C1649($WParea_ptr->)
		C_OBJECT:C1216(<>INSP_WPAreaZoom_o)
		ARRAY POINTER:C280($wpfieldptrs_aptr; 0)
		ARRAY LONGINT:C221($zooms_ar; 0)
		OB GET ARRAY:C1229(<>INSP_WPAreaZoom_o; "wpfieldpointers"; $wpfieldptrs_aptr)
		OB GET ARRAY:C1229(<>INSP_WPAreaZoom_o; "zooms"; $zooms_ar)
		If (Find in array:C230($wpfieldptrs_aptr; $Field_ptr)>0)
			$zooms_ar{Find in array:C230($wpfieldptrs_aptr; $Field_ptr)}:=$viewProps_o[wk zoom:K81:283]
		Else 
			APPEND TO ARRAY:C911($wpfieldptrs_aptr; $Field_ptr)
			APPEND TO ARRAY:C911($zooms_ar; $viewProps_o[wk zoom:K81:283])
		End if 
		OB SET ARRAY:C1227(<>INSP_WPAreaZoom_o; "wpfieldpointers"; $wpfieldptrs_aptr)
		OB SET ARRAY:C1227(<>INSP_WPAreaZoom_o; "zooms"; $zooms_ar)
		
		If (menuContext#"")
			RELEASE MENU:C978(menuContext)
			menuContext:=""
		End if 
End case 

//End INSP_Comments_WP_OM