//%attributes = {"invisible":true}
If (False:C215)
	//purpose : Select BIN records from a text file containing a list of BINS
	//date created : 8/2003 
	//Copied and modified M_LoadBINfile; removed Dialog ListType  
End if 

C_TIME:C306($dImportFile)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 15
C_TEXT:C284($tBuffer; $vType; $vHeader)
C_LONGINT:C283($acounter; $vHeadCheck)
C_LONGINT:C283($FormWindow)

ARRAY TEXT:C222($asBINS; 5000)  //Command Replaced was o_ARRAY string length was 16

CREATE SET:C116([Conslt Rating:63]; "TempSet1")

$dImportFile:=Open document:C264(""; "TEXT")  //prompt user for input file
If (OK=1)
	
	//initialize variables
	$BIN:=""
	$acounter:=1
	
	// skip 1st line if a header
	If ($vHeadCheck=1)
		RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
	End if 
	
	SET CURSOR:C469(4)
	
	While (Ok=1)
		RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
		If (Substring:C12($tBuffer; 1; 1)=<>sLF)
			//if 1st char is a LF then skip it    
			$tBuffer:=Substring:C12($tBuffer; 2)
		End if 
		//exclude blank lines
		If ($tBuffer#"")
			//MESSAGE(" tBuffer "+$tBuffer)
			$BIN:=$tBuffer
			If ($acounter<5000)
				$asBINS{$acounter}:=$BIN+"@"
				$acounter:=$acounter+1
			Else 
				$acounter:=$acounter+1
			End if 
			
		End if 
	End while 
	
	SET CURSOR:C469(0)
	
	//close the input file
	CLOSE DOCUMENT:C267($dImportFile)
	If ($acounter>5000)
		ALERT:C41("Number of BINs found in text file  exceeds 5000"+<>sCR+"Only first 5000 will be searched for.")
	Else 
		ALERT:C41(" Searching for "+String:C10($acounter-1)+" BINs")
	End if 
	
	SET CURSOR:C469(4)
	
	// load query into a temp set
	SET QUERY DESTINATION:C396(Into set:K19:2; "TempSet2")
	QUERY WITH ARRAY:C644([Conslt Rating:63]BIN:1; $asBINS)
	
	//reset the query destination  
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	INTERSECTION:C121("TempSet1"; "TempSet2"; "ResultSet")
	
	USE SET:C118("ResultSet")
	
	SET CURSOR:C469(0)
	
	//reset the window title
	RegionTitle
	
	CLEAR SET:C117("TempSet1")
	CLEAR SET:C117("TempSet2")
	CLEAR SET:C117("ResultSet")
End if 
