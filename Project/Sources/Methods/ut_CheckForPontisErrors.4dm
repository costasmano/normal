//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// ut_CheckForPontisErrors
	// User name (OS): 
	// Date and time: 05/17/05, 12:32:01
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	Mods_2005_CJM04
	// Modified by: costasmanousakis-(Designer)-(10/12/2005 15:42:35)
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(3/7/11 08:59:39)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_BOOLEAN:C305($Error_b)
READ ONLY:C145([BMS Elements:47])

C_LONGINT:C283($Loop_l; $Total_l; $CompareTotal_l; $ErrorCount_l; ElementNo_L)
C_TIME:C306($Start_TIME; $End_TIME)
C_DATE:C307($Start_Date; $End_Date)
$ErrorCount_l:=0
$Start_Date:=Current date:C33(*)
$Start_TIME:=Current time:C178(*)
ARRAY TEXT:C222($Error_atxt; 1)
C_TEXT:C284($Eol_txt)
C_REAL:C285($Total_r)
If (<>PL_LPlatfrm#3)  //on a mac
	$Eol_txt:=Char:C90(13)
Else 
	$Eol_txt:=Char:C90(13)+Char:C90(10)
End if 
C_BOOLEAN:C305($Error_b)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
QUERY:C277([Cond Units:45])
For ($Loop_l; 1; Records in selection:C76([Cond Units:45]))
	
	GOTO SELECTED RECORD:C245([Cond Units:45]; $Loop_l)
	$Error_b:=False:C215
	If (False:C215)
	Else 
		C_TEXT:C284($Error_txt)
		$Error_txt:=Check_CUdata
		If ($Error_txt#"")
			$ErrorCount_l:=$ErrorCount_l+1
			If (Length:C16($Error_atxt{1})>25000)
				INSERT IN ARRAY:C227($Error_atxt; 1; 1)
			End if 
			RELATE ONE:C42([Cond Units:45]Inspection ID:2)
			$Error_atxt{1}:=$Error_atxt{1}+String:C10([Cond Units:45]Cond Unit ID:1)+Char:C90(9)+String:C10([Cond Units:45]Inspection ID:2)+Char:C90(9)+Char:C90(Quote:K15:44)+[BMS Inspections:44]BIN:2+Char:C90(Quote:K15:44)+Char:C90(9)+String:C10([BMS Inspections:44]Insp Date:4)+Char:C90(9)+String:C10(ElementNo_L)+Char:C90(9)+String:C10([Cond Units:45]Environment:4)+Char:C90(9)
			$Error_atxt{1}:=$Error_atxt{1}+$Error_txt+$Eol_txt
		End if 
		$Error_txt:=""  //clear it
	End if 
	
End for 
$End_Date:=Current date:C33(*)
$End_TIME:=Current time:C178(*)

If (Length:C16($Error_atxt{1})>0)
	C_TIME:C306($Doc)
	$Doc:=Create document:C266("PontisErrors_"+Substring:C12(ut_CreateTimeStamp; 1; 12)+".txt")
	SEND PACKET:C103($doc; "Start at "+String:C10($Start_Date)+"-"+String:C10($Start_TIME)+" - End at "+String:C10($End_Date)+"-"+String:C10($End_TIME))
	SEND PACKET:C103($doc; " - Error count is "+String:C10($ErrorCount_l)+$eol_txt+$eol_txt)
	SEND PACKET:C103($doc; "CUID"+Char:C90(9)+"InspID"+Char:C90(9)+"BIN"+Char:C90(9)+"InspDate"+Char:C90(9)+"ElemNo"+Char:C90(9)+"Env"+Char:C90(9)+"ErrorText..."+$eol_txt)
	For ($Loop_l; Size of array:C274($Error_atxt); 1; -1)
		SEND PACKET:C103($Doc; $Error_atxt{$Loop_l})
	End for 
	
	CLOSE DOCUMENT:C267($Doc)
	If (<>PL_LPlatfrm#3)  //we are on a mac
		//_ O _SET DOCUMENT TYPE(document;"TEXT")
		//_ O _SET DOCUMENT CREATOR(document;"ttxt")
	End if 
	//Clear error text array
	For ($Loop_l; Size of array:C274($Error_atxt); 1; -1)
		$Error_atxt{$Loop_l}:=""
	End for 
	ARRAY TEXT:C222($Error_atxt; 0)
	$mypath:=GetPath(Application file:C491)
	C_TEXT:C284($mypath)
	ut_OpenDocument($mypath+document)
Else 
	
End if 

//End ut_CheckForPontisErrors