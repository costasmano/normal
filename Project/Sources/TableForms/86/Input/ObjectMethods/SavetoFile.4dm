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
$choicemenu:="WP file;HTML file;HTML mime file;Word;Save To Db field"
C_LONGINT:C283($choice)
$choice:=Pop up menu:C542($choicemenu)
C_POINTER:C301($Wparea_ptr)
$Wparea_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
C_TEXT:C284($file)
ARRAY TEXT:C222($files_atxt; 0)

Case of 
	: ($choice=1)
		//Wp file
		$file:=Select document:C905(""; ""; "Select WP file to export to"; File name entry:K24:17; $files_atxt)
		If (OK=1)
			WP EXPORT DOCUMENT:C1337($Wparea_ptr->; $files_atxt{1}; wk 4wp:K81:4; wk normal:K81:7)
			SHOW ON DISK:C922($files_atxt{1})
		End if 
	: ($choice=2)
		//HTML file
		$file:=Select document:C905(""; ""; "Select html file to export to"; File name entry:K24:17; $files_atxt)
		If (OK=1)
			WP EXPORT DOCUMENT:C1337($Wparea_ptr->; $files_atxt{1}; wk web page complete:K81:2; wk normal:K81:7)
			SHOW ON DISK:C922($files_atxt{1})
		End if 
	: ($choice=3)
		$file:=Select document:C905(""; ""; "Select mime html file to export to"; File name entry:K24:17; $files_atxt)
		If (OK=1)
			WP EXPORT DOCUMENT:C1337($Wparea_ptr->; $files_atxt{1}; wk mime html:K81:1; wk normal:K81:7)
			SHOW ON DISK:C922($files_atxt{1})
		End if 
	: ($choice=4)
		$file:=Select document:C905(""; ""; "Select word file to export to"; File name entry:K24:17; $files_atxt)
		If (OK=1)
			WP EXPORT DOCUMENT:C1337($Wparea_ptr->; $files_atxt{1}; wk docx:K81:277; wk normal:K81:7)
			SHOW ON DISK:C922($files_atxt{1})
		End if 
		
	: ($choice=5)
		C_BLOB:C604($WPblob)
		WP EXPORT VARIABLE:C1319($Wparea_ptr->; $WPblob; wk 4wp:K81:4; wk normal:K81:7)
		[Templates:86]Template_:3:=$WPblob
		PushChange(1; ->[Templates:86]Template_:3)
		Template_Size_L:=BLOB size:C605([Templates:86]Template_:3)
		
End case 

//End [Templates].Input.SavetoFile