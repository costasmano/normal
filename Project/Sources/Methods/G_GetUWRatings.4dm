//%attributes = {"invisible":true}
If (False:C215)
	//G_GetUWRatings
	//Get rating values from the previous UW approved Inspection report.  
	//Created Oct-2002
	
	Mods_2004_CM11
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 11:13:14)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/21/2007 10:25:59)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(12/5/07 09:50:12)
	Mods_2007_CM_5401  // combine selection to arrays
	// Modified by: Costas Manousakis-(Designer)-(12/14/15 17:15:38)
	Mods_2015_12_bug
	//  `Added progress messages and an Alert at the end when a UW inspection was found.
End if 

C_BOOLEAN:C305($vbShowAlert)
If (Count parameters:C259=1)
	C_BOOLEAN:C305($1)
	$vbShowAlert:=$1
Else 
	$vbShowAlert:=True:C214
End if 

//save the current sele of Safety Elmts and images
CUT NAMED SELECTION:C334([ElementsSafety:29]; "CurrInspElmts")
CUT NAMED SELECTION:C334([Standard Photos:36]; "CurrInspPhotos")
C_DATE:C307($vdCurrInspDate)
$vdCurrInspDate:=[Inspections:27]Insp Date:78
//save the current record-so we don't loose changes.
PUSH RECORD:C176([Inspections:27])
//start messaging window
SHORT_MESSAGE("Searching for Approved UW inspections dated before "+String:C10($vdCurrInspDate)+"..."+<>sCR)
READ ONLY:C145([Inspections:27])
QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspApproved:167=BMS Approved; *)  //get approved inspections
QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78<$vdCurrInspDate; *)  //before this one
QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6="DV@")  //and type Dive
ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)

//prepare arrays for data from dive inspection
ARRAY INTEGER:C220($aElmtCodeF; 0)
ARRAY TEXT:C222($aElmtAltRatF; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aElmtDescF; 0)  //Command Replaced was o_ARRAY string length was 40
C_LONGINT:C283($i; $vlNumInsps; $vlNumelmts; $vlLastRtnDV; $k; $j)
C_DATE:C307($vdUWDate)
C_TEXT:C284($vsInsptype)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($vITM60UW; $vITM61UW; $vITM62UW; $vITM58UW; $vITM59UW)  // Command Replaced was o_C_STRING length was 2
C_BOOLEAN:C305($vbDiveInspfound)

//initialize some values
$vITM60UW:=""
$vITM61UW:=""
$vITM62UW:=""
$vdUWDate:=!00-00-00!
$vbDiveInspfound:=False:C215
If (Records in selection:C76([Inspections:27])>0)
	//found approved UW inspections 
	//look for the last Routine dive insp
	ARRAY TEXT:C222($asInspType; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY DATE:C224($adInspDate; 0)
	SELECTION TO ARRAY:C260([Inspections:27]Insp Type:6; $asInspType; [Inspections:27]Insp Date:78; $adInspDate)
	$vlNumInsps:=Records in selection:C76([Inspections:27])
	$vlLastRtnDV:=-1  //last routine Dive insp
	For ($i; 1; $vlNumInsps)
		If (($asInspType{$i}="DVE") | ($asInspType{$i}="DVL"))
			$vlLastRtnDV:=$i
			$i:=$vlNumInsps+1
		End if 
	End for 
	If ($vlLastRtnDV<0)
		//If there is no Routine Dive -    
		$vlLastRtnDV:=$vlNumInsps  //check all Dive Inspections.
	End if 
	
	$k:=0  //number of combined elements
	
	FIRST RECORD:C50([Inspections:27])
	For ($i; 1; $vlLastRtnDV)
		$vsInspType:=[Inspections:27]Insp Type:6
		If ($vsInspType#"DV@")
			//reached a non-dive inspection
			$i:=$vlNumInsps+1
		Else 
			//found a dive inspection
			$vbDiveInspfound:=True:C214
			//get values - only the latest
			If ($vITM60UW="")
				$vITM60UW:=[Inspections:27]Item 60 UW:66
			End if 
			If ($vITM61UW="")
				$vITM61UW:=[Inspections:27]Item 61 UW:72
			End if 
			If ($vITM62UW="")
				$vITM62UW:=[Inspections:27]Item 62 UW:165
			End if 
			If (($vsInspType="DVE") | ($vsInspType="DVL"))
				//get inspection date
				$vdUWDate:=[Inspections:27]Insp Date:78
			End if 
			MESSAGE:C88("Found Routine Dive Inspection dated "+String:C10($vdUWDate)+". Retrieving Elements..."+<>sCR)
			//get elements related to it...
			G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
			$vlNumElmts:=Records in selection:C76([ElementsSafety:29])
			ARRAY INTEGER:C220($aElmtCode; 0)
			ARRAY TEXT:C222($aElmtAltRat; 0)  //Command Replaced was o_ARRAY string length was 2
			ARRAY TEXT:C222($aItemCateg; 0)  //Command Replaced was o_ARRAY string length was 3
			ARRAY TEXT:C222($aElmtDesc; 0)  //Command Replaced was o_ARRAY string length was 40
			SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $aElmtCode; [ElementsSafety:29]AltRating:21; $aElmtAltRat; [ElementsSafety:29]Description:22; $aElmtDesc)
			//instead of relate on selection use query with array
			//to avoid problems when in transaction.
			//RELATE ONE SELECTION([ElementsSafety];[ElementDict])
			QUERY WITH ARRAY:C644([ElementDict:30]ElementNo:1; $aElmtCode)
			DISTINCT VALUES:C339([ElementDict:30]Category:3; $aItemCateg)
			If (Size of array:C274($aItemCateg)>0)
				If (Find in array:C230($aItemCateg; "N58")>0)
					$vITM58UW:=[Inspections:27]Item 58:79
				End if 
				If (Find in array:C230($aItemCateg; "N59")>0)
					$vITM59UW:=[Inspections:27]Item 59:80
				End if 
			Else 
				$vITM58UW:=""
				$vITM59UW:=""
			End if 
			//Combine these arrays with the previous ones if any
			//        `this way we keep the latest values
			For ($j; 1; $vlNumElmts)
				If (Find in array:C230($aElmtCodeF; $aElmtCode{$j})<0)
					//Not in array - so add it
					$k:=$k+1
					INSERT IN ARRAY:C227($aElmtCodeF; $k)
					INSERT IN ARRAY:C227($aElmtAltRatF; $k)
					INSERT IN ARRAY:C227($aElmtDescF; $k)
					$aElmtCodeF{$k}:=$aElmtCode{$j}
					$aElmtAltRatF{$k}:=$aElmtAltRat{$j}
					$aElmtDescF{$k}:=$aElmtDesc{$j}
				End if 
			End for 
			
		End if 
		NEXT RECORD:C51([Inspections:27])
	End for 
	
End if 
READ WRITE:C146([Inspections:27])
POP RECORD:C177([Inspections:27])
ONE RECORD SELECT:C189([Inspections:27])
If ($vbDiveInspfound)
	MESSAGE:C88("Updating Current inspection..."+<>sCR)
	//Get all ElementsSafety records for the current inspection
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
	//Update the current values from the collected ones
	If ($vITM60UW#"")
		[Inspections:27]Item 60 UW:66:=$vITM60UW
		PushChange(1; ->[Inspections:27]Item 60 UW:66)
	End if 
	If ($vITM61UW#"")
		[Inspections:27]Item 61 UW:72:=$vITM61UW
		PushChange(1; ->[Inspections:27]Item 61 UW:72)
	End if 
	If ($vITM62UW#"")
		[Inspections:27]Item 62 UW:165:=$vITM62UW
		PushChange(1; ->[Inspections:27]Item 62 UW:165)
	End if 
	If ($vdUWDate#!00-00-00!)
		[Inspections:27]Item 93b:67:=$vdUWDate
		PushChange(1; ->[Inspections:27]Item 93b:67)
	End if 
	
	C_LONGINT:C283($vlInspElmts; $vlUWElmts)
	$vlInspElmts:=Records in selection:C76([ElementsSafety:29])
	$vlUWElmts:=Size of array:C274($aElmtCodeF)
	
	If ($vlUWElmts>0)
		If ($vlInspElmts>0)
			MESSAGE:C88("Updating Current inspection elements..."+<>sCR)
			
			FIRST RECORD:C50([ElementsSafety:29])
			For ($i; 1; $vlInspElmts)
				$k:=Find in array:C230($aElmtCodeF; [ElementsSafety:29]ElementNo:1)
				If ($k>0)
					//avoid un-needed changes
					If ([ElementsSafety:29]AltRating:21#$aElmtAltRatF{$k})
						[ElementsSafety:29]AltRating:21:=$aElmtAltRatF{$k}
						LogChanges(->[ElementsSafety:29]AltRating:21; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
						//Get the element desc from the UW insp if the current desc is blank
						If ([ElementsSafety:29]Description:22="Blank@")
							[ElementsSafety:29]Description:22:=$aElmtDescF{$k}
							LogChanges(->[ElementsSafety:29]Description:22; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
						End if 
						SAVE RECORD:C53([ElementsSafety:29])
					End if 
				End if 
				NEXT RECORD:C51([ElementsSafety:29])
			End for 
		End if 
	End if 
	
End if 

//close messaging window
CLOSE WINDOW:C154

//restore the element selection
USE NAMED SELECTION:C332("CurrInspElmts")
USE NAMED SELECTION:C332("CurrInspPhotos")
//restore the BMS Inspection

If ($vbShowAlert)
	If (Not:C34($vbDiveInspfound))
		ALERT:C41("Did not find any Approved UnderWater Inspections dated before "+String:C10($vdCurrInspDate))
	Else 
		ALERT:C41("Searched for Approved UnderWater Inspections dated before "+String:C10($vdCurrInspDate)+".  Found a Routine UW inspection dated "+String:C10($vdUWDate))
	End if 
End if 