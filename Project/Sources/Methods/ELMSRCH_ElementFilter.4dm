//%attributes = {"invisible":true}
//Method: ELMSRCH_ElementFilter
//Description
// Filter the current selection of [ElementsSafety] to keep only the latest
// element for each BIN.
// To be Used when searching by Elements in method CreateRandomSetForDefElement
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/08/17, 15:52:50
	// ----------------------------------------------------
	//Created : 
	Mods_2017_06_bug
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23)
	Mods_2021_12_bug
	//  `clean up code
End if 
//
C_LONGINT:C283($StartMilli_L; $OrderByMilli_L; $endLoopMilli_L; $selToArraymilli_L; $MakeSEtMilli_L; $DoneSetMilli_L)
$StartMilli_L:=Milliseconds:C459
C_TEXT:C284($currBIN_txt)
C_LONGINT:C283($CurrElNo_L)
C_DATE:C307($CurrDate_d)
C_LONGINT:C283($progressBar_L)
$progressBar_L:=Progress New
Progress SET TITLE($progressBar_L; "Filtering Elements")
Progress SET BUTTON ENABLED($progressBar_L; False:C215)

If (Records in selection:C76([ElementsSafety:29])>0)
	ARRAY TEXT:C222($BINs_atxt; 0)
	ARRAY INTEGER:C220($ElmNos_aL; 0)
	ARRAY DATE:C224($InspDates_ad; 0)
	ARRAY LONGINT:C221($ElmIDs_aL; 0)
	ARRAY LONGINT:C221($RemainingIDs_aL; 0)
	Progress SET MESSAGE($progressBar_L; "Loading data")
	
	SELECTION TO ARRAY:C260([ElementsSafety:29]; $ElmIDs_aL; [ElementsSafety:29]ElementNo:1; $ElmNos_aL; [Inspections:27]Insp Date:78; $InspDates_ad; [Bridge MHD NBIS:1]BIN:3; $BINs_atxt)
	$selToArraymilli_L:=Milliseconds:C459
	ARRAY LONGINT:C221($RemainingIDs_aL; Size of array:C274($ElmIDs_aL))
	Progress SET MESSAGE($progressBar_L; "Sorting data")
	
	MULTI SORT ARRAY:C718($BINs_atxt; >; $ElmNos_aL; >; $InspDates_ad; <; $ElmIDs_aL)
	$OrderByMilli_L:=Milliseconds:C459
	C_LONGINT:C283($loop_L)
	$currBIN_txt:=$BINs_atxt{1}
	$CurrElNo_L:=$ElmNos_aL{1}
	$CurrDate_d:=$InspDates_ad{1}
	$RemainingIDs_aL{1}:=$ElmIDs_aL{1}
	Progress SET MESSAGE($progressBar_L; "Screening elements")
	Progress SET PROGRESS($progressBar_L; 0)
	
	For ($loop_L; 2; Size of array:C274($ElmIDs_aL))
		If ($BINs_atxt{$loop_L}=$currBIN_txt) & ($ElmNos_aL{$loop_L}=$CurrElNo_L)
			$RemainingIDs_aL{$loop_L}:=0  //zero id : therefore nothing
		Else 
			$currBIN_txt:=$BINs_atxt{$loop_L}
			$CurrElNo_L:=$ElmNos_aL{$loop_L}
			$CurrDate_d:=$InspDates_ad{$loop_L}
			$RemainingIDs_aL{$loop_L}:=$ElmIDs_aL{$loop_L}
		End if 
		Progress SET PROGRESS($progressBar_L; $loop_L/Size of array:C274($ElmIDs_aL))
		
	End for 
	$endLoopMilli_L:=Milliseconds:C459
	
	Progress SET MESSAGE($progressBar_L; "Applying screening")
	
	CREATE SELECTION FROM ARRAY:C640([ElementsSafety:29]; $RemainingIDs_aL)
	$DoneSetMilli_L:=Milliseconds:C459
	
End if 

Progress QUIT($progressBar_L)

//End ELMSRCH_ElementFilter
