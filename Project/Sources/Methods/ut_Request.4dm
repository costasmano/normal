//%attributes = {"invisible":true}
// ----------------------------------------------------
// User name (OS): costasmanousakis
// User name (4D): Designer
// Date and time: 01/27/07, 18:30:32
// ----------------------------------------------------
// Method: ut_Request
// Description
// Replacement for Request function
// 
// Parameters
// $0 : result_text
// $1 : Propmpt_text
// $2 : Choise List -optional pointer to text or string array
// $3 : Default text -optional
// $4 : AcceptButton text -optional
// $5 : CancelButton Text -optional
// $6 : PageNumber of form -optional
// ----------------------------------------------------
If (False:C215)
	//First Release
	Mods_2007_CM05a
	// Modified by: costasmanousakis-(Designer)-(2/4/08 14:05:21)
	Mods_2008_CM_5402
	//Declare ut_Request_Value_txt as text - helps with CTRL-V
	// Modified by: costasmanousakis-(Designer)-(10/25/10 16:51:42)
	Mods_2010_10
	//  `Added optional parameter 6 to go to a second page for a method using the Combo box and
	//  `to allow to delete entries in the dropdown.
	// Modified by: costasmanousakis-(Designer)-(10/18/11 08:15:19)
	Mods_2011_10
	//  `Added BlankMenu to enable cut and Paste.
End if 
C_TEXT:C284($1; ut_Request_prompt_txt; $3; ut_Request_Value_txt; $0; $Result_txt)
C_TEXT:C284($4; ut_Request_OKBtn_txt; $5; ut_Request_CancBtn_txt)  // Command Replaced was o_C_STRING length was 20
ut_Request_prompt_txt:=$1
C_POINTER:C301($2; $ChoiseList_ptr)
ARRAY TEXT:C222(ut_Request_Choises; 0)
C_LONGINT:C283(ut_Request_Page_L)
ut_Request_Page_L:=0
If (Count parameters:C259>1)
	$ChoiseList_ptr:=$2
	C_LONGINT:C283($ListSize_L; $i; $Typeofptr)
	$Typeofptr:=Type:C295($ChoiseList_ptr->)
	If (($Typeofptr=String array:K8:15) | ($Typeofptr=Text array:K8:16))
		$ListSize_L:=Size of array:C274($ChoiseList_ptr->)
		ARRAY TEXT:C222(ut_Request_Choises; $ListSize_L)
		For ($i; 1; $ListSize_L)
			ut_Request_Choises{$i}:=$ChoiseList_ptr->{$i}
		End for 
	End if 
	
Else 
End if 
If (Count parameters:C259>2)
	ut_Request_Value_txt:=$3
Else 
	ut_Request_Value_txt:=""
End if 
ut_Request_OKBtn_txt:=""
If (Count parameters:C259>3)
	ut_Request_OKBtn_txt:=$4
End if 
If (ut_Request_OKBtn_txt="")
	ut_Request_OKBtn_txt:="OK"
End if 
ut_Request_CancBtn_txt:=""
If (Count parameters:C259>4)
	ut_Request_CancBtn_txt:=$5
End if 
If (ut_Request_CancBtn_txt="")
	ut_Request_CancBtn_txt:="Cancel"
End if 
If (Count parameters:C259>5)
	C_LONGINT:C283($6)
	ut_Request_Page_L:=$6
End if 
If ((ut_Request_Page_L<1) | (ut_Request_Page_L>2))
	ut_Request_Page_L:=1
End if 

$Result_txt:=""
C_LONGINT:C283($promptWin; $widt; $ht)
FORM GET PROPERTIES:C674([Dialogs:21]; "ut_Request"; $widt; $ht)
CENTER_WINDOW($widt; $ht; 0; "")
SET MENU BAR:C67("BlankMenu")
DIALOG:C40([Dialogs:21]; "ut_Request")
CLOSE WINDOW:C154
If (OK=1)
	$Result_txt:=ut_Request_Value_txt
End if 
If (ut_Request_Page_L=2)
	C_LONGINT:C283($SourceArr_size_L; $modArraySize_L; $loop_L)
	C_LONGINT:C283($Typeofptr)
	$Typeofptr:=Type:C295($ChoiseList_ptr->)
	If (($Typeofptr=String array:K8:15) | ($Typeofptr=Text array:K8:16))
		$SourceArr_size_L:=Size of array:C274($ChoiseList_ptr->)
		$modArraySize_L:=Size of array:C274(ut_Request_Choises)
		If ($SourceArr_size_L#$modArraySize_L)
			
			For ($loop_L; $SourceArr_size_L; 1; -1)
				If (Find in array:C230(ut_Request_Choises; $ChoiseList_ptr->{$loop_L})>0)
				Else 
					DELETE FROM ARRAY:C228($ChoiseList_ptr->; $loop_L)
				End if 
			End for 
		End if 
		
	End if 
	
End if 
ARRAY TEXT:C222(ut_Request_Choises; 0)
ut_Request_prompt_txt:=""
$0:=$Result_txt