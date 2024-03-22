//%attributes = {"invisible":true}
// ut_ReturnUserDocFolder
// Description
// This method will return logged in users documents directory + additional folder(s) specified in param 1
// Parameters
// $0 : Documents folder with any subfolder(s)
// $1 : Subfolders to documents folder - should be in format :
//  // folder1+folder separator+folder2+folder separator....
// ----------------------------------------------------
If (False:C215)
	// User name (OS): charlesmiller
	// Date and time: 05/20/11, 10:51:24
	// ----------------------------------------------------
	Mods_2011_05  //r002 CJ Miller`05/20/11, 10:51:26
	// Modified by: Costas Manousakis-(Designer)-(12/28/18 10:39:51)
	Mods_2018_12_bug
	//  `attempt to address CallReference #594
	//  //use new constant "Documents folder" ; allow multiple levels of subforlders to be created
	// Modified by: Costas Manousakis-(Designer)-(2022-01-11T00:00:00 13:48:49)
	Mods_2022_01
	//  `Change if running as a server, return the Data file folder.
End if 
//C_LONGINT($Platform_l)
//PLATFORM PROPERTIES($Platform_l)
//C_TEXT($DirectorySymbol_txt)
//Case of 
//: ($Platform_l=Windows)
//$DirectorySymbol_txt:="\\"
//Else 
//$DirectorySymbol_txt:=":"
//End case 
C_TEXT:C284($0; $Folder_txt)
//$Folder_txt:=System folder(User preferences_user)
//$Folder_txt:=Replace string($Folder_txt;"Preferences:";"")
//$Folder_txt:=Replace string($Folder_txt;"Library:";"Documents")

If (Application type:C494=4D Server:K5:6)
	$Folder_txt:=Get 4D folder:C485(Data folder:K5:33)
Else 
	$Folder_txt:=System folder:C487(Documents folder:K41:18)
End if 


If (Test path name:C476($Folder_txt)=Is a folder:K24:2)
	
Else 
	CREATE FOLDER:C475($Folder_txt)
	
End if 

//$Folder_txt:=$Folder_txt+$DirectorySymbol_txt
If (Count parameters:C259=1)
	C_TEXT:C284($1; $subfolder_txt)
	$subfolder_txt:=$1
	ARRAY TEXT:C222($subfolders_atxt; 0)
	ut_TextToArray($subfolder_txt; ->$subfolders_atxt; Folder separator:K24:12)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($subfolders_atxt))
		
		If (Test path name:C476($Folder_txt+$subfolders_atxt{$loop_L})=Is a folder:K24:2)
			
		Else 
			CREATE FOLDER:C475($Folder_txt+$subfolders_atxt{$loop_L})
			
		End if 
		$Folder_txt:=$Folder_txt+$subfolders_atxt{$loop_L}+Folder separator:K24:12
		
	End for 
	
End if 
$0:=$Folder_txt
//End ut_ReturnUserDocFolder