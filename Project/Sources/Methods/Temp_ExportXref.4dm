//%attributes = {"invisible":true}
//Temp_ExportXref
//Mar-2001 : CM
//Method to create an Xreference file which is a
//80 char cross reference of the old Item8 coding with the new
//The fields are :
//1-3 : State code
//4-18 : New Structure number
//19 : 1st digit of item 5
//20-22 : blank spaces (3)
//23-25 : State code
//26-40 : Old Structure number
//41 : 1st digit of item 5
//42-44 : blank spaces (3)
//45-50 : date of change (MMDDYY)
//51-53 : blank spaces(3)
//54-78 : Reason for change
//79-80 : blank spaces (2)

C_TIME:C306($dXrefFile)
C_TEXT:C284($t)  // Command Replaced was o_C_STRING length was 82// 80 char record + 2 for CRLF
C_LONGINT:C283($Recs; $Interval; $i; $j)

$Recs:=Records in selection:C76([Bridge MHD NBIS:1])

$dXrefFile:=Create document:C266("XREF.DAT"; "TEXT")
If (Ok=1)
	<>ProgressPID:=StartProgress("XrefExport"; "None"; "Creating Item 8 Xref Report")
	$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	UpdateProgress(1; $Recs)
	
	For ($i; 1; $Recs)
		$t:="251"+[Bridge MHD NBIS:1]Item8:206+Substring:C12([Bridge MHD NBIS:1]Item5:59; 1; 1)+"   "
		$t:=$t+"251"+[Bridge MHD NBIS:1]BIN:3+[Bridge MHD NBIS:1]Bridge Key:2+Substring:C12([Bridge MHD NBIS:1]Item5:59; 1; 1)+"   "
		//date of change = Mar-30-2001
		$t:=$t+"033001"+"   "+"Standardize Bridge IDs   "+"  "+<>sCR+<>sLF
		
		SEND PACKET:C103($dXrefFile; $t)
		
		RELATE MANY:C262([Bridge MHD NBIS:1])
		FIRST RECORD:C50([NBIS Secondary:3])
		For ($j; 1; Records in selection:C76([NBIS Secondary:3]))
			$t:="251"+[Bridge MHD NBIS:1]Item8:206+Substring:C12([NBIS Secondary:3]Item5:4; 1; 1)+"   "
			$t:=$t+"251"+[Bridge MHD NBIS:1]BIN:3+[Bridge MHD NBIS:1]Bridge Key:2+Substring:C12([NBIS Secondary:3]Item5:4; 1; 1)+"   "
			$t:=$t+"033001"+"   "+"Standardize Bridge IDs   "+"  "+<>sCR+<>sLF
			SEND PACKET:C103($dXrefFile; $t)
			NEXT RECORD:C51([NBIS Secondary:3])
		End for 
		
		If ($i%$Interval=0)  //Don't slow down things just to display
			UpdateProgress($i; $Recs)
		End if 
		NEXT RECORD:C51([Bridge MHD NBIS:1])
		
	End for 
	POST OUTSIDE CALL:C329(<>ProgressPID)
	CLOSE DOCUMENT:C267($dXrefFile)
End if 

