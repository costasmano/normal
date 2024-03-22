// Object Method: [Parameters];"Input".EditJson
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/10/20, 14:08:12
	// ----------------------------------------------------
	// First Release
	Mods_2020_06
	// Modified by: Costas Manousakis-(Designer)-(8/11/20 17:07:13)
	Mods_2020_08_bug
	//  `when parameter is blank make a starting object with a single attribute
	// Modified by: Costas Manousakis-(Designer)-(2023-06-20 13:35:18)
	Mods_2023_06_bug
	//  `fix case where data returned from JSON editor is a collection - data was not saved
End if 

C_TEXT:C284($param)
$param:=[Parameters:107]Description:2
C_BOOLEAN:C305($editjson_b)
C_OBJECT:C1216($temp_o)

$editjson_b:=False:C215
If ($param="")
	$editjson_b:=True:C214  //if parameter is blank then we can make a new one
	C_OBJECT:C1216($blank_o)
	OB SET:C1220($blank_o; "newattr"; "newValue")
	$param:=JSON Stringify:C1217($blank_o)
Else 
	C_BOOLEAN:C305(4DError_b)
	C_TEXT:C284($lastMethOnError)
	$lastMethOnError:=Method called on error:C704
	4DError_b:=False:C215
	ON ERR CALL:C155("4D_Errors")
	
	$temp_o:=JSON Parse:C1218($param; Is object:K8:27)  //convert to object
	
	ON ERR CALL:C155($lastMethOnError)
	
	If (4DError_b)
		ALERT:C41("Parameter description is not a valid JSON!\n"+$param)
		4DError_b:=False:C215
	Else 
		$editjson_b:=True:C214
	End if 
	
End if 

If ($editjson_b)
	
	jsonEditor(->$param)
	
	If ($param#"")
		//the editor should always return an non-blank string if it is a valid json
		// but check it just in case!
		C_TEXT:C284($lastMethOnError)
		$lastMethOnError:=Method called on error:C704
		4DError_b:=False:C215
		ON ERR CALL:C155("4D_Errors")
		
		$temp_o:=JSON Parse:C1218($param; Is object:K8:27)  //convert to object
		
		ON ERR CALL:C155($lastMethOnError)
		
		If (4DError_b)
			ALERT:C41("Returned string is not a valid JSON or is blank!\n"+$param)
			4DError_b:=False:C215
		Else 
			
			//parsing worked, determine what is the correct type
			C_BOOLEAN:C305($updateparam_b)
			$updateparam_b:=True:C214
			
			Case of 
				: (Not:C34(JSON Parse:C1218($param; Is object:K8:27)=Null:C1517))
					//it is an object
					$param:=JSON Stringify:C1217(JSON Parse:C1218($param; Is object:K8:27); *)
				: (Not:C34(JSON Parse:C1218($param; Is collection:K8:32)=Null:C1517))
					//it is a collection
					$param:=JSON Stringify:C1217(JSON Parse:C1218($param; Is collection:K8:32); *)
					
				Else 
					G_MyConfirm("JSON returned is not an object or a collection! Update Parameter?\n"+\
						JSON Stringify:C1217(JSON Parse:C1218($param)); "Update"; "Leave as is")
					$updateparam_b:=(OK=1)
					
			End case 
			
			If ($updateparam_b)
				If ($param#[Parameters:107]Description:2)
					[Parameters:107]Description:2:=$param
					PushChange(1; ->[Parameters:107]Description:2)
				End if 
			End if 
			
		End if 
	Else 
		//editor returned a blank string
		ALERT:C41("Blank string returned by the JSON editor! Check your edits!")
	End if 
	
End if 