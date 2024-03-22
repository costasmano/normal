//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_SetAddRemoveStatus
// User name (OS): cjmiller
// Date and time: 10/12/04, 11:54:20
// ----------------------------------------------------
// Description
// This method is called to set add or remove status for this months import or cre
//
//
// Parameters
//$1 Year of import or transfer
//$2 Month of Import or transfer
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2011_06  // CJ Miller`06/14/11, 11:04:58      ` Type all local variables for v11
End if 
C_TEXT:C284($1; $Year_s; $QueryYear_s)  // Command Replaced was o_C_STRING length was 4
C_TEXT:C284($2; $Month_s; $QueryMonth_s)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($Month_l; $Year_l)
$Year_s:=$1
$Month_s:=$2
$Year_l:=Num:C11($1)
$Month_l:=Num:C11($2)

//Get this months records
QUERY:C277([SD_History:89]; [SD_History:89]SD_Year:2=$Year_s; *)
QUERY:C277([SD_History:89];  & ; [SD_History:89]SD_Month:3=$Month_s)

SELECTION TO ARRAY:C260([SD_History:89]; $RecordNumber_al; [SD_History:89]Bin:1; $Bin_as; [SD_History:89]Item41:15; $Item41_as)

//set up this months [SD_History]SD_AddRemoveStatus_s

If ($Month_l=1)  //we are doing last years export
	$QueryYear_s:=String:C10($Year_l-1)
	$QueryMonth_s:="12"
Else 
	$QueryYear_s:=String:C10($Year_l)
	$QueryMonth_s:=String:C10($Month_l-1; "00")
End if 
//set up adds
C_LONGINT:C283($Loop_l)
For ($Loop_l; 1; Size of array:C274($Bin_as))
	
	QUERY:C277([SD_History:89]; [SD_History:89]SD_Year:2=$QueryYear_s; *)
	QUERY:C277([SD_History:89];  & ; [SD_History:89]SD_Month:3=$QueryMonth_s; *)
	QUERY:C277([SD_History:89];  & [SD_History:89]Bin:1=$Bin_as{$Loop_l})
	
	Case of 
		: (Records in selection:C76([SD_History:89])=0)
			GOTO RECORD:C242([SD_History:89]; $RecordNumber_al{$Loop_l})
			LOAD RECORD:C52([SD_History:89])
			
			[SD_History:89]SD_DefectAddRemoveStatus_s:16:="A"
			If ([SD_History:89]Item41:15="P")
				[SD_History:89]SD_PostedAddRemoveStatus_s:18:="A"
			End if 
			SAVE RECORD:C53([SD_History:89])
			UNLOAD RECORD:C212([SD_History:89])
		: (Records in selection:C76([SD_History:89])=1)
			
			LOAD RECORD:C52([SD_History:89])
			Case of 
				: ($Item41_as{$Loop_l}="P") & ([SD_History:89]Item41:15="P")
				: ($Item41_as{$Loop_l}="P") & ([SD_History:89]Item41:15#"P")
					GOTO RECORD:C242([SD_History:89]; $RecordNumber_al{$Loop_l})
					LOAD RECORD:C52([SD_History:89])
					[SD_History:89]SD_PostedAddRemoveStatus_s:18:="A"
					SAVE RECORD:C53([SD_History:89])
					UNLOAD RECORD:C212([SD_History:89])
				: ($Item41_as{$Loop_l}#"P") & ([SD_History:89]Item41:15="P")  //DO NOTHING AS THIS WILL BE HANDLED BELOW IN SECOND PASS
					
			End case 
	End case 
End for 


//Get last months records and set up removes
QUERY:C277([SD_History:89]; [SD_History:89]SD_Year:2=$QueryYear_s; *)
QUERY:C277([SD_History:89];  & ; [SD_History:89]SD_Month:3=$QueryMonth_s)
SELECTION TO ARRAY:C260([SD_History:89]; $RecordNumber_al; [SD_History:89]Bin:1; $Bin_as; [SD_History:89]Item41:15; $Item41_as)

For ($Loop_l; 1; Size of array:C274($Bin_as))
	
	QUERY:C277([SD_History:89]; [SD_History:89]SD_Year:2=$Year_s; *)
	QUERY:C277([SD_History:89];  & ; [SD_History:89]SD_Month:3=$Month_s; *)
	QUERY:C277([SD_History:89];  & [SD_History:89]Bin:1=$Bin_as{$Loop_l})
	
	Case of 
		: (Records in selection:C76([SD_History:89])=0)
			GOTO RECORD:C242([SD_History:89]; $RecordNumber_al{$Loop_l})
			LOAD RECORD:C52([SD_History:89])
			Case of 
				: ([SD_History:89]SD_DefectAddRemoveStatus_s:16="")
					[SD_History:89]SD_DefectAddRemoveStatus_s:16:="R"
				: ([SD_History:89]SD_DefectAddRemoveStatus_s:16="A")
					[SD_History:89]SD_DefectAddRemoveStatus_s:16:="B"
			End case 
			If ([SD_History:89]Item41:15="P")
				Case of 
					: ([SD_History:89]SD_PostedAddRemoveStatus_s:18="")
						[SD_History:89]SD_PostedAddRemoveStatus_s:18:="R"
					: ([SD_History:89]SD_PostedAddRemoveStatus_s:18="A")
						[SD_History:89]SD_PostedAddRemoveStatus_s:18:="B"
				End case 
			End if 
			
			SAVE RECORD:C53([SD_History:89])
			UNLOAD RECORD:C212([SD_History:89])
		: (Records in selection:C76([SD_History:89])=1)
			LOAD RECORD:C52([SD_History:89])
			Case of 
				: ($Item41_as{$Loop_l}="P") & ([SD_History:89]Item41:15="P")
				: ($Item41_as{$Loop_l}="P") & ([SD_History:89]Item41:15#"P")
					GOTO RECORD:C242([SD_History:89]; $RecordNumber_al{$Loop_l})
					LOAD RECORD:C52([SD_History:89])
					Case of 
						: ([SD_History:89]SD_PostedAddRemoveStatus_s:18="")
							[SD_History:89]SD_PostedAddRemoveStatus_s:18:="R"
						: ([SD_History:89]SD_PostedAddRemoveStatus_s:18="A")
							[SD_History:89]SD_PostedAddRemoveStatus_s:18:="B"
					End case 
					SAVE RECORD:C53([SD_History:89])
					UNLOAD RECORD:C212([SD_History:89])
				: ($Item41_as{$Loop_l}#"P") & ([SD_History:89]Item41:15="P")  //DO NOTHING AS THIS was HANDLED ABOVE IN FIRST PASS
					//GOTO RECORD([SD_History];$RecordNumber_al{$Loop_l})
					//LOAD RECORD([SD_History])
					//[SD_History]SD_PostedAddRemoveStatus_s:="R"
			End case 
	End case 
	
End for 



//End SD_SetAddRemoveStatus