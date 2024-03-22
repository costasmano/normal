//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: P_ImportData(pointer;longint;longint;string;string)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - pointer - pointer to an array of field pointers
	//$2 - longint - 0 = Text format, 1=Merge Format, 2=4D Format
	//$3 - longint - 0 = No LF after CR;  1= LF after CR
	//$4 - string - Field delimiter
	//$5 - string - Record delimiter
	
	//Purpose: Imports the fields pointed to in the array of pointers.
	//All records in the current selection are exported.
	
	//Modified 2-10-2000 : CM
	//    Adjusted GOTO XY x param from 6 pixels to 1 character
	
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 

C_LONGINT:C283($i; $j; $LType; $LNoOfFlds; $LFormat; $LCRLF; $LPosition; $LParms; $2; $3; $Lpid)
C_POINTER:C301($pFile; $ptr; $1)
C_TEXT:C284($sFilename)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($4; $5)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($tBuffer; $tField; $tParameters)
C_TEXT:C284($sFldDel; $sRecDel)  // Command Replaced was o_C_STRING length was 3
C_TIME:C306($hDocRef)

$LParms:=Count parameters:C259
If ($LParms=0)  //ExportData is running in its own process
	
	ControlMenuBar(1)  //Set the menu bar for this process so the menu bar is not blank when the 
	//export progress window is being displayed.
	
	Repeat 
		$tParameters:=<>tParameters  //Assign the Interprocess var to a local var
		DELAY PROCESS:C323(Current process:C322; 15)
	Until ($tParameters#"")  //Wait until the msg arrives.
	<>LBackground:=<>LBackground+1
	<>tParameters:=""  //Clear Interprocess var to allow other process to continue
	
	//Copy the sParameters sent in the message into local vars.  
	$ptr:=Get pointer:C304(sParameter($tParameters; 1))
	ARRAY POINTER:C280($pFields; 0)
	COPY ARRAY:C226($ptr->; $pFields)
	$LFormat:=Num:C11(sParameter($tParameters; 2))
	$LCRLF:=Num:C11(sParameter($tParameters; 3))
	$sFldDel:=sParameter($tParameters; 4)
	$sRecDel:=sParameter($tParameters; 5)
	If ($LCRLF=1)
		$sRecDel:=<>sLF
	End if 
	$pFile:=Table:C252(Table:C252($pFields{1}))  //Get a pointer to the file being exported.
	
Else   //ImportData was called within a process so copy the parameters into local vars.
	
	COPY ARRAY:C226($1->; $pFields)
	$LFormat:=$2
	$LCRLF:=$3
	$sFldDel:=$4
	$sRecDel:=$5
	
End if 
If ($LFormat#2)  //Not 4D internal format
	$hDocRef:=Open document:C264("")
Else 
	SET CHANNEL:C77(10; "")
End if 

If (OK=1)
	If ($LParms=0)
		HIDE PROCESS:C324(Current process:C322)  //Put this in the background
	End if 
	
	$LNoOfFlds:=Size of array:C274($pFields)
	$sFilename:=Table name:C256($pFile)
	
	NewWindow(200; 30; 0; 4; "Importing")
	If ($LParms=0)
		UpdatWindArray(""; Current process:C322; True:C214)
	End if 
	$Lpid:=LProcessID("$Logoff")  //Is there a logoff checker
	If ($Lpid>0)
		ON EVENT CALL:C190("")  //Turn off the event handler if on
		PAUSE PROCESS:C319($Lpid)
	End if 
	
	GOTO XY:C161(1; 0)  //2-10-2000 : CM
	MESSAGE:C88("Importing "+$sFilename+"…")
	
	Case of 
		: (($LFormat=0) | ($LFormat=1))  //Text or Merge format
			
			//Build an array of the field types
			ARRAY LONGINT:C221(aLFldTypes; $LNoOfFlds)
			For ($i; 1; $LNoOfFlds)
				GET FIELD PROPERTIES:C258($pFields{$i}; $LType)
				aLFldTypes{$i}:=$LType
			End for 
			
			If (OK=1)
				
				If ($LFormat=1)  // If the "Skip Header Record" check box is selected…
					RECEIVE PACKET:C104($hDocRef; $tBuffer; $sRecDel)  // …just import and ignore the first record.
				End if 
				
				CREATE EMPTY SET:C140($pFile->; "ImportSet")
				
				RECEIVE PACKET:C104($hDocRef; $tBuffer; $sRecDel)
				$i:=0
				
				While (OK=1)
					$i:=$i+1
					CREATE RECORD:C68($pFile->)
					
					$LPosition:=Length:C16($tBuffer)
					If ($LCRLF=1)  //` Makes the last field work like all the rest.
						$tBuffer[[$LPosition]]:=$sFldDel  //If CRLF replace CR with $sFldDel
					Else 
						$tBuffer:=$tBuffer+$sFldDel
					End if 
					
					
					For ($j; 1; $LNoOfFlds)
						$LPosition:=Position:C15($sFldDel; $tBuffer)
						$tField:=Substring:C12($tBuffer; 1; $LPosition-1)
						$tBuffer:=Substring:C12($tBuffer; $LPosition+1)
						If (Substring:C12($tField; 1; 1)=<>sQU)
							$LPosition:=Position:C15((<>sQU+$sFldDel); $tBuffer)
							If ($LPosition>0)
								$tField:=$tField+$sFldDel+Substring:C12($tBuffer; 1; $LPosition-1)
								$tField:=Substring:C12($tField; 2; Length:C16($tField))  // Get rid of the quotation marks.
								$tBuffer:=Substring:C12($tBuffer; $LPosition+1)
							End if 
						End if 
						
						Case of 
							: ((aLFldTypes{$j}=0) | (aLFldTypes{$j}=2))  // Alpha or Text
								$pFields{$j}->:=$tField
							: (aLFldTypes{$j}=4)  // Date
								$pFields{$j}->:=Date:C102($tField)
							: (aLFldTypes{$j}=11)  // Time
								$pFields{$j}->:=Time:C179($tField)
							: (aLFldTypes{$j}=6)  // Boolean 
								$pFields{$j}->:=($tField="True") | ($tField="Yes")
							Else   // Number
								$pFields{$j}->:=Num:C11($tField)
						End case 
					End for 
					
					SAVE RECORD:C53($pFile->)
					ADD TO SET:C119($pFile->; "ImportSet")
					
					If ($i%25=0)  //Don't slow down things just to display
						GOTO XY:C161(2; 1)  //2-10-2000 : CM
						MESSAGE:C88("Record "+String:C10($i))
					End if 
					
					RECEIVE PACKET:C104($hDocRef; $tBuffer; $sRecDel)
					
				End while 
				
				USE SET:C118("ImportSet")
				CLEAR SET:C117("ImportSet")
				
			End if 
			
		: ($LFormat=2)  //4D Format
			CREATE EMPTY SET:C140($pFile->; "ImportSet")
			
			RECEIVE RECORD:C79($pFile->)
			$i:=0
			
			While (OK=1)
				$i:=$i+1
				
				SAVE RECORD:C53($pFile->)
				ADD TO SET:C119($pFile->; "ImportSet")
				
				If ($i%25=0)  //Don't slow down things just to display
					GOTO XY:C161(6; 1)
					MESSAGE:C88("Record "+String:C10($i))
				End if 
				
				RECEIVE RECORD:C79($pFile->)
			End while 
			
			USE SET:C118("ImportSet")
			CLEAR SET:C117("ImportSet")
			
		: ($LFormat=3)  //Use ImportExport Layout
			//Purpose: Allows exporting of records to the current file using a layout
			//Note:  Developer must have created a layout named ImportExport for this to work 
			FldDelimit:=Num:C11($sFldDel)
			RecDelimit:=Num:C11($sRecDel)
			FORM SET INPUT:C55($pFile->; "ImportExport")
			IMPORT TEXT:C168($pFile->; "")
			FORM SET INPUT:C55($pFile->; "Input")
			
	End case 
	
	//FLUSH CACHE
	If ($LParms=0)
		UpdatWindArray(""; Current process:C322; True:C214)
	End if 
	If ($Lpid>0)  //Restore logoff checker
		<>fUsrPresent:=True:C214  //Set as if the user has been here
		RESUME PROCESS:C320($Lpid)
	End if 
	
	CLOSE WINDOW:C154
	
	If ($LParms=0)  //Clear the background processes counter
		<>LBackground:=<>LBackground-1
	Else   //Running in some process updaate the window
		WindowTitle
	End if 
	
End if 

If ($LFormat#2)  //Not 4D internal format
	CLOSE DOCUMENT:C267($hDocRef)
Else 
	SET CHANNEL:C77(11)
End if 
//End of procedure
