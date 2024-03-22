//Method: [Templates].Input.SavetoFile
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/05/21, 17:38:49
	// ----------------------------------------------------
	//Created : 
End if 
//
C_TEXT:C284($choicemenu)
$choicemenu:="Load from file;Load from Db field"
C_LONGINT:C283($choice)
$choice:=Pop up menu:C542($choicemenu)

C_POINTER:C301($Wparea_ptr)
$Wparea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")


Case of 
	: ($choice=1)
		C_TEXT:C284($file)
		ARRAY TEXT:C222($files_atxt; 0)
		$file:=Select document:C905(""; ""; "Select WP file to import from"; 0; $files_atxt)
		If (Ok=1)
			C_OBJECT:C1216($file_o)
			$file_o:=Path to object:C1547($files_atxt{1})
			C_BLOB:C604($wrblb)
			
			Case of 
				: ($file_o.extension=".4WP")  //write pro file
					DOCUMENT TO BLOB:C525($files_atxt{1}; $wrblb)
					$Wparea_ptr->:=WP New:C1317($wrblb)
					
				: ($file_o.extension=".4W7")  //write file
					$Wparea_ptr->:=WP Import document:C1318($files_atxt{1})
					
				Else 
					ALERT:C41("File extension "+$file_o.extension+" is not supported! Only Write Pro (.4wp) or 4D Write (.4w7) files are supported.")
			End case 
			
		End if 
		
	: ($choice=2)
		CONFIRM:C162("All changes will be lost! Continue?")
		If (OK=1)
			LOAD RECORD:C52([Templates:86])
			$WpArea_ptr->:=WP New:C1317([Templates:86]Template_:3)
			InitChangeStack(1)  // clear the change stack too
		End if 
End case 



//End [Templates].Input.SavetoFile