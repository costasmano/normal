//%attributes = {"invisible":true}
//Method: WRP_convertWRTTemplates
//Description
// convert all WRT templates to Write pro
// create new teamplates with the same 'last name'
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/04/21, 19:21:56
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
End if 
//

QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRT@")
ARRAY LONGINT:C221($templateIDS_aL; 0)
SELECTION TO ARRAY:C260([Templates:86]TemplateID:1; $templateIDS_aL)
ARRAY TEXT:C222($WpTemplateNames_atxt; 0)
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP@"; *)
QUERY:C277([Templates:86];  | ; [Templates:86]TemplateName:2="WP@")
SELECTION TO ARRAY:C260([Templates:86]TemplateName:2; $WpTemplateNames_atxt)

ARRAY TEXT:C222($results_atxt; Size of array:C274($templateIDS_aL))
C_OBJECT:C1216($WPAREA)
C_BLOB:C604($WPBlob; $WRTBlob)
//start the bar
C_OBJECT:C1216($progress)
$progress:=ProgressNew("Conveting WRT templates to WP"; Size of array:C274($templateIDS_aL); True:C214; " wrt template"; 3)
C_TEXT:C284($newName; $templDesc; $oldname)
C_BOOLEAN:C305($Convert_b; $useSameAnswer_b; $sameNameAnswer_b)
$useSameAnswer_b:=False:C215
C_LONGINT:C283($templ)
C_BOOLEAN:C305(4DError_b)
For ($templ; 1; Size of array:C274($templateIDS_aL))
	//update progress
	UpdateProgressNew($progress; $templ)
	
	QUERY:C277([Templates:86]; [Templates:86]TemplateID:1=$templateIDS_aL{$templ})
	$oldname:=[Templates:86]TemplateName:2
	If ([Templates:86]TemplateName:2="WRTemplate@")
		$newName:="WP"+Substring:C12([Templates:86]TemplateName:2; 3)
	Else 
		$newName:="WRP"+Substring:C12([Templates:86]TemplateName:2; 4)
	End if 
	
	$results_atxt{$templ}:=$oldname+Char:C90(Tab:K15:37)+String:C10(BLOB size:C605([Templates:86]Template_:3))
	$templDesc:=[Templates:86]TemplateDesc:4+" - converted to Write Pro"
	$WRTBlob:=[Templates:86]Template_:3
	C_LONGINT:C283($samename_L)
	$samename_L:=Find in array:C230($WpTemplateNames_atxt; $newName)
	$Convert_b:=True:C214
	If ($samename_L>0)
		
		Case of 
			: ($useSameAnswer_b)
			Else 
				CONFIRM:C162("Template "+$newName+" exists!"; "Replace"; "Skip")
				$sameNameAnswer_b:=(OK=1)
				CONFIRM:C162("Use the same response ("+Choose:C955($sameNameAnswer_b; "Replace"; "Skip")+") for all?"; "Use same"; "Ask again")
				$useSameAnswer_b:=(OK=1)
		End case 
		
		If ($sameNameAnswer_b)
			QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$newName)
			If (ut_LoadRecordInteractive(->[Templates:86]))
			Else 
				$Convert_b:=False:C215
			End if 
		Else 
			$Convert_b:=False:C215
		End if 
		
	Else 
		CREATE RECORD:C68([Templates:86])
		Inc_Sequence("TemplateInc"; ->[Templates:86]TemplateID:1)
	End if 
	If ($Convert_b)
		4DError_b:=False:C215
		ON ERR CALL:C155("4D_Errors")
		$WPAREA:=WP New:C1317($WRTBlob)
		If (Not:C34(4DError_b))
			WP EXPORT VARIABLE:C1319($WPAREA; $WPBlob; wk 4wp:K81:4; wk normal:K81:7)
		End if 
		ON ERR CALL:C155("")
		If (4DError_b)
			C_TEXT:C284($msg)
			$msg:="Error converting template "+$oldname+"!\rError number, code and descriptions are:\r"
			C_LONGINT:C283($errloop)
			For ($errloop; 1; Size of array:C274(SQL_InternalDescriptions_atxt))
				$msg:=$msg+String:C10(SQLErrorNumbers_al{$errloop})+" - "+SQL_InternalCodes_atxt{$errloop}+" - "+SQL_InternalDescriptions_atxt{$errloop}+"\r"
			End for 
			ALERT:C41($msg)
			$results_atxt{$templ}:=$results_atxt{$templ}+Char:C90(Tab:K15:37)+"Error "+Char:C90(Tab:K15:37)+String:C10(SQLErrorNumbers_al{1})+" "+SQL_InternalDescriptions_atxt{1}
		Else 
			$results_atxt{$templ}:=$results_atxt{$templ}+Char:C90(Tab:K15:37)+$newName+Char:C90(Tab:K15:37)+String:C10(BLOB size:C605($WPBlob))
			[Templates:86]TemplateName:2:=$newName
			[Templates:86]TemplateDesc:4:=$templDesc
			[Templates:86]Template_:3:=$WPBlob
			SAVE RECORD:C53([Templates:86])
			UNLOAD RECORD:C212([Templates:86])
		End if 
	Else 
		$results_atxt{$templ}:=$results_atxt{$templ}+Char:C90(Tab:K15:37)+"Skipped"
	End if 
	
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($progress; "progress"; Is longint:K8:6)))
		//abort loop
		$templ:=Size of array:C274($templateIDS_aL)+1
	End if 
	
End for 

//quit progress
Progress QUIT(OB Get:C1224($progress; "progress"; Is longint:K8:6))

C_TIME:C306($logFile_t)
C_TEXT:C284($logFile_txt)
ARRAY TEXT:C222($Files_atxt; 0)
$logFile_txt:=Select document:C905(""; ".txt"; "Select file to save conversion log"; File name entry:K24:17; $Files_atxt)

If (OK=1)
	$logFile_txt:=$Files_atxt{1}
	C_TEXT:C284($Log_txt)
	C_BLOB:C604($fileBlob_x)
	$Log_txt:="4DWrite name"+Char:C90(Tab:K15:37)+"BlobSize"+Char:C90(Tab:K15:37)+"WriteProName"+Char:C90(Tab:K15:37)+"BlobSize"+"\n"
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($results_atxt))
		$Log_txt:=$Log_txt+$results_atxt{$loop_L}+"\n"
	End for 
	TEXT TO BLOB:C554($Log_txt; $fileBlob_x; UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($logFile_txt; $fileBlob_x)
	SHOW ON DISK:C922($logFile_txt)
End if 

//End WRP_convertWRTTemplates