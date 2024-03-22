//%attributes = {"invisible":true}
//Method: NTI_PrintNTEList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/16, 11:31:14
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/29/17 12:45:51)
	Mods_2017_08_bug
	//  `fix to address bug where element comments were not printed correctly when spanning pages
	// Modified by: Costas Manousakis-(Designer)-(4/30/18 10:09:12)
	Mods_2018_04_bug
	//  `Fix logic determining form names for page1 and pages2 and on. 
	//  `parameter 2 is the base form name. 
	//  ` if "$2_1" is an actual form name it will be used as the 1st page, if not, the use $2 if it is a valid form name 
	//  ` if "$2_2" is an actual form name it will be used as the 2nd page, if not, the use $2 if it is a valid form name 
	
	C_POINTER:C301(NTI_PrintNTEList; $1)
	C_TEXT:C284(NTI_PrintNTEList; $2)
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($FormName_txt; $Page2Form_txt; $baseFormName_txt)
$baseFormName_txt:="Print"
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$baseFormName_txt:=$2
End if 

C_LONGINT:C283($formIndx_L; $Form_1_Indx_L; $form_2_indx_L)
ARRAY TEXT:C222($TableForms_atxt; 0)
FORM GET NAMES:C1167($1->; $TableForms_atxt)
$formIndx_L:=Find in array:C230($TableForms_atxt; $baseFormName_txt)
$Form_1_Indx_L:=Find in array:C230($TableForms_atxt; ($baseFormName_txt+"_1"))
$form_2_indx_L:=Find in array:C230($TableForms_atxt; ($baseFormName_txt+"_2"))

Case of 
	: ($Form_1_Indx_L>0)
		$FormName_txt:=$baseFormName_txt+"_1"
	: ($formIndx_L>0)
		$FormName_txt:=$baseFormName_txt
End case 

Case of 
	: ($Form_2_Indx_L>0)
		$Page2Form_txt:=$baseFormName_txt+"_2"
	: ($formIndx_L>0)
		$Page2Form_txt:=$baseFormName_txt
End case 


If ($FormName_txt="")
	//could not find printing form requested !
	ALERT:C41("Error Printing Records from table "+Table name:C256($1)+" : Requested form ["+$baseFormName_txt+"] could not be found!")
Else 
	
	C_REAL:C285($printHt_R; $PageHt_R)
	C_LONGINT:C283($PaperHt_L; $PaperW_L; $printedHt_L; $numRecs_L; $rec_L)
	C_TEXT:C284(NTI_PrintSection_txt)
	C_TEXT:C284(v_179_020_txt)  //var used to print notes
	C_LONGINT:C283(v_179_006_L)  //var used to indicate note spill over - calculated during the form printing
	NTI_PrintSection_txt:="Header"
	$printedHt_L:=Print form:C5($1->; $FormName_txt; Form header:K43:3)
	$numRecs_L:=Records in selection:C76($1->)
	For ($rec_L; 1; $numRecs_L)
		GOTO SELECTED RECORD:C245($1->; $rec_L)
		LOAD RECORD:C52($1->)
		v_179_006_L:=0  //indicates that we start with all of note need to be printed
		NTI_PrintSection_txt:="Detail"
		$printedHt_L:=$printedHt_L+Print form:C5($1->; $FormName_txt; Form detail:K43:1)
		If (OK=0)
			//need to move whole element to next page
			NTI_PrintSection_txt:="Break0"
			Print form:C5($1->; $FormName_txt; Form break0:K43:14)
			NTI_PrintSection_txt:="Footer"
			Print form:C5($1->; $FormName_txt; Form footer:K43:2)
			PAGE BREAK:C6(>)
			$FormName_txt:=$Page2Form_txt
			NTI_PrintSection_txt:="Header"
			$printedHt_L:=Print form:C5($1->; $FormName_txt; Form header:K43:3)
			NTI_PrintSection_txt:="Detail"
			$printedHt_L:=$printedHt_L+Print form:C5($1->; $FormName_txt; Form detail:K43:1)
			
		End if 
		//need to check if we have to print the overflow of notes for the same element
		If (v_179_006_L>0)
			
			Repeat 
				//need to add break and continue printing the same element until there is no overflow from notes
				NTI_PrintSection_txt:="Break0"
				Print form:C5($1->; $FormName_txt; Form break0:K43:14)
				NTI_PrintSection_txt:="Footer"
				Print form:C5($1->; $FormName_txt; Form footer:K43:2)
				PAGE BREAK:C6(>)
				$FormName_txt:=Replace string:C233($FormName_txt; "_1"; "_2")
				NTI_PrintSection_txt:="Header"
				$printedHt_L:=Print form:C5($1->; $FormName_txt; Form header:K43:3)
				NTI_PrintSection_txt:="Detail"
				$printedHt_L:=$printedHt_L+Print form:C5($1->; $FormName_txt; Form detail:K43:1)
				
			Until (v_179_006_L=0)
			
		End if 
		If (viInspPreviewErr=0)
			
		Else 
			$rec_L:=$numRecs_L+1  //exit if abort from preview
		End if 
	End for 
	//after all elements - finish it
	NTI_PrintSection_txt:="Break0"
	Print form:C5($1->; $FormName_txt; Form break0:K43:14)
	NTI_PrintSection_txt:="Footer"
	Print form:C5($1->; $FormName_txt; Form footer:K43:2)
	//PAGE BREAK(>)
	
End if 

//End NTI_PrintNTEList