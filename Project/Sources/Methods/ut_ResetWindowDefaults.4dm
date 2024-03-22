//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/09/16, 13:36:59
//----------------------------------------------------
//Method: ut_ResetWindowDefaults
//Description
//This method will delete and therefore reset debugger pane. It can be used as a basis for resetting other windows from a designer perspective as well
// Parameters
// ----------------------------------------------------
If (False:C215)
	C_TEXT:C284(ut_ResetWindowDefaults; $1)
End if 
C_TEXT:C284($1; $Path_txt)

Case of 
	: ($1="Debugger")
		$Path_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)+"4D Window Bounds v"+Substring:C12(Application version:C493; 1; 2)+Folder separator:K24:12+"coreDialog"+Folder separator:K24:12+"[projectForm]"+Folder separator:K24:12+"4ddebugger.json"
		If (Test path name:C476($Path_txt)=Is a document:K24:1)
			DELETE DOCUMENT:C159($Path_txt)
		End if 
		
		
	: ($1="Explorer")
		$Path_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)+"4D Window Bounds v"+Substring:C12(Application version:C493; 1; 2)+Folder separator:K24:12+"development"+Folder separator:K24:12+"[projectForm]"+Folder separator:K24:12+"Explorer.json"
		If (Test path name:C476($Path_txt)=Is a document:K24:1)
			DELETE DOCUMENT:C159($Path_txt)
		End if 
		
	: ($1="pref_Database")
		$Path_txt:=Get 4D folder:C485(Active 4D Folder:K5:10)+"4D Window Bounds v"+Substring:C12(Application version:C493; 1; 2)+Folder separator:K24:12+"development"+Folder separator:K24:12+"[projectForm]"+Folder separator:K24:12+"pref_Database.json"
		If (Test path name:C476($Path_txt)=Is a document:K24:1)
			DELETE DOCUMENT:C159($Path_txt)
		End if 
		
End case 

//End ut_ResetWindowDefaults

