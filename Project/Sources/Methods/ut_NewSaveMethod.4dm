//%attributes = {"invisible":true}
//Method: ut_NewSaveMethod
//Description
// Save method text from method editor- called form On Save macro.
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 11/21/11, 14:44:10
	//----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(2/19/14 16:52:11)
	Mods_2014_02_bug
	//  `added check if vars are defined
	Mods_2019_07  //Modify code to save better folder structure when saving mnethdos and to identify Form methdods
	//Modified by: Chuck Miller (7/16/19 17:02:22)
	Mods_2020_04  //Modified so that of BOX not found export is skipped
	//Modified by: Chuck (4/28/20 16:06:56)
	// Modified by: Costas Manousakis-(Designer)-(8/13/20 16:46:07)
	Mods_2020_08_bug
	//  `check if BOX volume or Box Sync folder are found. fix 000 file created outsode folder (there was an extra folder separator)
	// Modified by: manousakisc (7/9/2021)
	Mods_2021_07
	//  `added on error call to catch error creating first folder
	// Modified by: Costas Manousakis-(Designer)-(2022-06-07 18:55:57)
	Mods_2022_06
	//  `removed extra fileseparators when building folder path for form object methods
	//  `added optional 3rd param with the method text
	// Modified by: Costas Manousakis-(Designer)-(2023-10-24 18:40:20)
	Mods_2023_10
	//  `added checks for Box when in Mac OS 11 - Box folder is in Library:CloudStorage:Box-Box:
End if 

C_TEXT:C284($MethodName_txt; $1; $2; $DirectorySymbol_txt; $MethodPath_txt)
$MethodName_txt:=$1
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$MethodPath_txt:=$2
	
End if 

ARRAY TEXT:C222($MethodsNames_atxt; 0)
ARRAY TEXT:C222($MethodsPath_atxt; 0)
ut_NewTextToArray($MethodName_txt; ->$MethodsNames_atxt; ".")

ut_NewTextToArray($MethodPath_txt; ->$MethodsPath_atxt; "/")

C_TEXT:C284($text; $structurePath_txt; $Folder_txt; $methodPath_txt)
C_TIME:C306($vDocRef)
C_LONGINT:C283($ACount_L)

$structurePath_txt:=Structure file:C489
//Else 
//$structurePath_txt:=<>SavedMethodFolder_txt
//End if 

C_LONGINT:C283($Loop_l)

$Loop_l:=Length:C16($structurePath_txt)
If (Position:C15(Folder separator:K24:12; $structurePath_txt)>0)
	Repeat 
		$Loop_l:=$Loop_l-1
	Until ($structurePath_txt[[$Loop_l]]=Folder separator:K24:12)
	$structurePath_txt:=Substring:C12($structurePath_txt; $Loop_l+1)
End if 
$structurePath_txt:=Replace string:C233($structurePath_txt; ".4db"; "")
$structurePath_txt:=Replace string:C233($structurePath_txt; " "; "_")
$Folder_txt:=System folder:C487(Documents folder:K41:18)
ARRAY TEXT:C222($Volumes_atxt; 0)
C_BOOLEAN:C305($BoxFound_B)

VOLUME LIST:C471($Volumes_atxt)
$BoxFound_B:=(Find in array:C230($Volumes_atxt; "Box@")>0)
$BoxFound_B:=$BoxFound_B | (Test path name:C476(Replace string:C233($Folder_txt; "Documents"; "Box Sync"))=Is a folder:K24:2)
$BoxFound_B:=$BoxFound_B | (Test path name:C476(Replace string:C233(\
System folder:C487(User preferences_user:K41:4); "Application Support"; "CloudStorage"+Folder separator:K24:12+"Box-Box"))=Is a folder:K24:2)
If ($BoxFound_B)
	
	Case of 
		: (Find in array:C230($Volumes_atxt; "Box")>0)  // we are using new verion box drive
			$Folder_txt:=Replace string:C233($Folder_txt; "Documents"; "Box")+"ma dot"+Folder separator:K24:12
		: (Test path name:C476(Replace string:C233($Folder_txt; "Documents"; "Box Sync"))=Is a folder:K24:2)
			$Folder_txt:=Replace string:C233($Folder_txt; "Documents"; "Box Sync")+"ma dot"+Folder separator:K24:12
		: (Test path name:C476(Replace string:C233(\
			System folder:C487(User preferences_user:K41:4); "Application Support"; "CloudStorage"+Folder separator:K24:12+"Box-Box"))=Is a folder:K24:2)
			$Folder_txt:=Replace string:C233(\
				System folder:C487(User preferences_user:K41:4); \
				"Application Support"; "CloudStorage"+Folder separator:K24:12+"Box-Box")+\
				"ma dot"+Folder separator:K24:12
	End case 
	
	//If (Find in array($Volumes_atxt;"Box")>0)  // we are using new verion box drive
	//$Folder_txt:=Replace string($Folder_txt;"Documents";"Box")+"ma dot"+Folder separator
	//Else 
	//$Folder_txt:=Replace string($Folder_txt;"Documents";"Box Sync")+"ma dot"+Folder separator
	//End if 
	If (Test path name:C476($Folder_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($Folder_txt)
	End if 
	$structurePath_txt:=$Folder_txt+$structurePath_txt
	
	If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($structurePath_txt)
	End if 
	
	
	C_TEXT:C284($TimeStamp_txt)
	C_LONGINT:C283($FolderCreateLoop_L)
	$TimeStamp_txt:=String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")+String:C10(Current time:C178; HH MM SS:K7:1)
	$TimeStamp_txt:=Replace string:C233($TimeStamp_txt; ":"; "")
	C_LONGINT:C283($SizeofMethodPath_L; $SizeofMethodName_L)
	C_BOOLEAN:C305($CreateDocument_B; $IsTableFormMethod_B; $IsProjectFormMethod_B)
	$CreateDocument_B:=True:C214
	$SizeofMethodPath_L:=Size of array:C274($MethodsPath_atxt)
	$SizeofMethodName_L:=Size of array:C274($MethodsNames_atxt)
	$MethodName_txt:=$MethodsNames_atxt{$SizeofMethodName_L}
	
	
	C_TEXT:C284($TableName_txt)
	C_BOOLEAN:C305($IsTableFormMethod_B; $IsProjectFormMethod_B)
	$IsTableFormMethod_B:=False:C215
	$IsProjectFormMethod_B:=False:C215
	C_BOOLEAN:C305(4DError_b)
	4DError_b:=False:C215
	ON ERR CALL:C155("4D_Errors")
	Case of 
			
		: ($MethodsPath_atxt{1}="[tableForm]")
			$structurePath_txt:=$structurePath_txt+Folder separator:K24:12+$MethodsPath_atxt{2}+Folder separator:K24:12
			If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($structurePath_txt)
			End if 
			$structurePath_txt:=$structurePath_txt+$MethodsPath_atxt{3}+Folder separator:K24:12
			If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($structurePath_txt)
			End if 
			If ($MethodsPath_atxt{$SizeofMethodPath_L}="{formMethod}")
				$structurePath_txt:=$structurePath_txt+"Form Method"+Folder separator:K24:12
				If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($structurePath_txt)
				End if 
				$IsTableFormMethod_B:=True:C214
			Else 
				$structurePath_txt:=$structurePath_txt+$MethodsPath_atxt{$SizeofMethodPath_L}+Folder separator:K24:12
				If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($structurePath_txt)
				End if 
			End if 
			
		: ($MethodsPath_atxt{1}="[projectForm]")
			
			$structurePath_txt:=$structurePath_txt+Folder separator:K24:12+"Project Forms"+Folder separator:K24:12
			If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($structurePath_txt)
			End if 
			$structurePath_txt:=$structurePath_txt+$MethodsPath_atxt{2}+Folder separator:K24:12
			If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($structurePath_txt)
			End if 
			If ($MethodsPath_atxt{$SizeofMethodPath_L}="{formMethod}")
				$structurePath_txt:=$structurePath_txt+"Form Method"+Folder separator:K24:12
				If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($structurePath_txt)
				End if 
				$IsProjectFormMethod_B:=True:C214
			Else 
				$structurePath_txt:=$structurePath_txt+$MethodsPath_atxt{$SizeofMethodPath_L}+Folder separator:K24:12
				If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
				Else 
					CREATE FOLDER:C475($structurePath_txt)
				End if 
			End if 
			
		: ($MethodsPath_atxt{1}="[databaseMethod]")
			
			$structurePath_txt:=$structurePath_txt+Folder separator:K24:12+"data base Methods"+Folder separator:K24:12
			If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($structurePath_txt)
			End if 
			
		Else 
			
			$structurePath_txt:=$structurePath_txt+Folder separator:K24:12+$MethodsPath_atxt{$SizeofMethodPath_L}+Folder separator:K24:12
			If (Test path name:C476($structurePath_txt)=Is a folder:K24:2)
			Else 
				CREATE FOLDER:C475($structurePath_txt)
			End if 
			
	End case 
	ON ERR CALL:C155("")
	
	$CreateDocument_B:=Not:C34(4DError_b)
	
	If (4DError_b)
		ALERT:C41("Error creating folder "+$structurePath_txt)
	Else 
		If ($IsTableFormMethod_B | $IsProjectFormMethod_B)
			
			CONFIRM:C162("Have you changed the Form, or the form method"; "Form"; "Form Method")
			$CreateDocument_B:=OK=0
			
		End if 
		
	End if 
	
	4DError_b:=False:C215
	
	If ($CreateDocument_B)
		ARRAY TEXT:C222($Documents_atxt; 0)
		CLEAR VARIABLE:C89($Documents_atxt)
		DOCUMENT LIST:C474($structurePath_txt; $Documents_atxt)
		
		
		If (Count parameters:C259>2)
			C_TEXT:C284($3)
			$text:=$3
		Else 
			GET MACRO PARAMETER:C997(Full method text:K5:17; $text)
		End if 
		
		C_LONGINT:C283($loc_l; $BCount_L; $LCount_L)
		$loc_l:=Find in array:C230(<>DesignMethodNames_atxt; $MethodsPath_atxt{$SizeofMethodPath_L})
		If ($loc_l>0)
		Else 
			$loc_l:=Find in array:C230(<>DesignMethodNames_atxt; $MethodPath_txt)
			
		End if 
		$ACount_L:=Size of array:C274($Documents_atxt)
		If ($ACount_L=0)
			$ACount_L:=1
		End if 
		If ($loc_l>0)
			//$BCount_L:=<>DesignMethodBCount_aL{$loc_l}
			//<>DesignMethodACount_aL{$loc_l}:=<>DesignMethodACount_aL{$loc_l}+1
			//$ACount_L:=<>DesignMethodACount_aL{$loc_l}
			//If ($BCount_L=0)
			//<>DesignMethodBCount_aL{$loc_l}:=1
			//<>DesignMethodSaved_aB{$loc_l}:=True
			
			If (Find in array:C230($Documents_atxt; $MethodName_txt+"_000_@")>0)
			Else 
				$vDocRef:=Create document:C266($structurePath_txt+$MethodName_txt+"_000_"+Substring:C12($TimeStamp_txt; 3)+".txt")
				If (OK=1)
					SEND PACKET:C103($vDocRef; <>DesignMethodCode_atxt{$loc_l})
					CLOSE DOCUMENT:C267($vDocRef)
				End if 
			End if 
			//End if 
		Else 
			APPEND TO ARRAY:C911(<>DesignMethodNames_atxt; $MethodName_txt)
			APPEND TO ARRAY:C911(<>DesignMethodCode_atxt; "")
			
		End if 
		
		$vDocRef:=Create document:C266($structurePath_txt+$MethodName_txt+"_"+String:C10($ACount_L; "000")+"_"+Substring:C12($TimeStamp_txt; 3)+".txt")
		If (OK=1)
			SEND PACKET:C103($vDocRef; $text)
			CLOSE DOCUMENT:C267($vDocRef)
		End if 
		
	End if 
End if 

//End ut_NewSaveMethod