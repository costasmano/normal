//%attributes = {"invisible":true}
If (False:C215)
	// Procedure: ExportDataOpt (pointer; longint; longint; string; string)
	// ACI University Programming Classes
	// Generic ACI Shell Programming
	// Created By: Jim Steinman
	// Date: 10/5/95
	
	// Legend:
	// $1 - pointer - pointer to an array of field pointers
	// $2 - longint - 0 = Text format, 1=Merge Format, 2=4D Format
	// $3 - longint - 0 = No LF after CR; 1= LF after CR
	// $4 - string - Field delimiter
	// $5 - string - Record delimiter
	
	// Purpose: Exports the fields pointed to in the array of pointers.
	// All records in the current selection are exported.
	
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 6 pixels to 1 character
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($i; $j; $k; $LType; $LNoOfFlds; $LRecs; $LFormat; $LCRLF; $LLastPos; $LDataLen; $Lparms; $Lpid; $2; $3)
C_TEXT:C284($sDel)  // Command Replaced was o_C_STRING length was 2
C_POINTER:C301($1; $pFile; $ptr)
C_TEXT:C284($sFilename)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($4; $5)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($tBuffer; $tData; $tParameters)
C_TEXT:C284($sFldDel; $sRecDel)  // Command Replaced was o_C_STRING length was 3

$Lparms:=Count parameters:C259

If ($Lparms=0)  //ExportData is running in its own process
	
	ControlMenuBar(1)
	// export progress window is being displayed.
	
	Repeat 
		$tParameters:=<>tParameters  //Assign the Interprocess var to a local var
		DELAY PROCESS:C323(Current process:C322; 15)
	Until ($tParameters#"")  //Wait until the msg arrives.
	<>LBackground:=<>LBackground+1
	<>tParameters:=""  //Clear Interprocess var to allow other process to continue
	
	// Copy the sParameters sent in the message into local vars.
	$ptr:=Get pointer:C304(sParameter($tParameters; 1))
	ARRAY POINTER:C280($pFields; 0)
	COPY ARRAY:C226($ptr->; $pFields)
	$LFormat:=Num:C11(sParameter($tParameters; 2))
	$LCRLF:=Num:C11(sParameter($tParameters; 3))
	$sFldDel:=sParameter($tParameters; 4)
	$sRecDel:=sParameter($tParameters; 5)
	If ($LCRLF=1)
		$sRecDel:=$sRecDel+<>sLF
	End if 
	$pFile:=Table:C252(Table:C252($pFields{1}))  //Get a pointer to the file being exported.
	USE NAMED SELECTION:C332("◊ExportSelection")
	CLEAR NAMED SELECTION:C333("◊ExportSelection")
Else   //ExportData was called within a process so copy the parameters into local vars.
	
	COPY ARRAY:C226($1->; $pFields)
	$LFormat:=$2
	$LCRLF:=$3
	$sFldDel:=$4
	$sRecDel:=$5
	
End if 

SET CHANNEL:C77(12; "")
If (OK=1)
	
	//  If ($Lparms=0)
	//    HIDE PROCESS(Current process)  `Put this in the background
	//  End if 
	
	FIRST RECORD:C50($pFile->)
	$LRecs:=Records in selection:C76($pFile->)
	
	$LNoOfFlds:=Size of array:C274($pFields)
	$sFilename:=Table name:C256($pFile)
	
	NewWindow(200; 30; 0; 4; "Exporting")
	If ($LParms=0)
		UpdatWindArray(""; Current process:C322; True:C214)
		$Lpid:=LProcessID("$Logoff")  //Is there a logoff checker
		If ($Lpid>0)
			ON EVENT CALL:C190("")  //Turn off event handler if on
			PAUSE PROCESS:C319($Lpid)
		End if 
	End if 
	
	GOTO XY:C161(1; 0)
	MESSAGE:C88("Exporting "+$sFilename+" Recs…")
	
	Case of 
		: (($LFormat=0) | ($LFormat=1))  //Text or Merge format
			
			// Build an array of the field types
			ARRAY LONGINT:C221(aLFldTypes; $LNoOfFlds)
			For ($i; 1; $LNoOfFlds)
				GET FIELD PROPERTIES:C258($pFields{$i}; $LType)
				aLFldTypes{$i}:=$LType
			End for 
			
			
			If ($LFormat=1)  //Merge Format. Export the fieldnames first
				$sDel:=$sFldDel
				$tBuffer:=""
				For ($i; 1; $LNoOfFlds)
					If ($i=$LNoOfFlds)  //we are exporting the last fieldname
						$sDel:=$sRecDel
					End if 
					$tBuffer:=$tBuffer+sFriendlyName(Field name:C257($pFields{$i}))+$sDel
				End for 
				SEND PACKET:C103($tBuffer)
			End if 
			
			// now export the records
			$tBuffer:=" "*32000
			$LLastPos:=0
			
			For ($i; 1; $LRecs)
				$sDel:=$sFldDel
				
				For ($j; 1; $LNoOfFlds)
					
					If ($j=$LNoOfFlds)  //we are exporting the last field of the record
						$sDel:=$sRecDel
					End if 
					
					Case of 
						: ((aLFldTypes{$j}#0) & (aLFldTypes{$j}#2) & (aLFldTypes{$j}#6))  //then convert it to a string
							$tData:=(String:C10(($pFields{$j})->)+$sDel)
							
						: (aLFldTypes{$j}=6)  //It's a boolean
							If ($pFields{$j}->)
								$tData:="True"+$sDel
							Else 
								$tData:="False"+$sDel
							End if 
							
						Else 
							$tData:=(($pFields{$j}->)+$sDel)
					End case 
					
					$LDataLen:=Length:C16($tData)
					If ($LLastPos+$LDataLen>30000)
						SEND PACKET:C103(Substring:C12($tBuffer; 1; $LLastPos))
						$tBuffer:=" "*32000
						$LLastPos:=0
					End if 
					For ($k; 1; $LDataLen)
						$tBuffer[[$LLastPos+$k]]:=$tData[[$k]]
					End for 
					$LLastPos:=$LLastPos+$LDataLen
					
				End for 
				
				NEXT RECORD:C51($pFile->)
				
				If ($i%10=0)  //	Don't slow down things just to display
					GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
					MESSAGE:C88("Record "+String:C10($i)+" of "+String:C10($LRecs))
				End if 
				
			End for 
			
			If ($LLastPos>0)
				SEND PACKET:C103(Substring:C12($tBuffer; 1; $LLastPos))
			End if 
			
		: ($LFormat=2)  //4D Format
			For ($i; 1; $LRecs)
				
				SEND RECORD:C78($pFile->)
				
				NEXT RECORD:C51($pFile->)
				
				If ($i%10=0)  //	Don't slow down things just to display
					GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
					MESSAGE:C88("Record "+String:C10($i)+" of "+String:C10($LRecs))
				End if 
				
			End for 
			
		: ($LFormat=3)  //Use ImportExport Layout
			// Purpose: Allows exporting of records to the current file using a layout
			// Note: Developer must have created a layout named ImportExport for this to work
			FldDelimit:=Num:C11($sFldDel)
			RecDelimit:=Num:C11($sRecDel)
			FORM SET OUTPUT:C54($pFile->; "ImportExport")
			EXPORT TEXT:C167($pFile->; "")
			FORM SET OUTPUT:C54($pFile->; "Output")
			
	End case 
	
	If ($LParms=0)
		UpdatWindArray(""; Current process:C322; True:C214)
		If ($Lpid>0)  //Restore logoff checker
			<>fUsrPresent:=True:C214  //Set as if the user has been here
			RESUME PROCESS:C320($Lpid)
		End if 
	End if 
	CLOSE WINDOW:C154
	SET CHANNEL:C77(11)  //Close the document
	
	If ($Lparms=0)  //Clear the background processes counter
		<>LBackground:=<>LBackground-1
	End if 
	
End if   //OK=1
// End of procedure