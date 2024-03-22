//%attributes = {"invisible":true}
If (False:C215)
	If (False:C215)
		// ----------------------------------------------------
		// User name (OS): costasmanousakis
		// User name (4D): Designer
		// Date and time: 03/28/06, 09:19:24
		// ----------------------------------------------------
		// Method: Temp_UpdateItem26
		// Description
		// Update Item 26 from a text file produced by T Quattromani - Planning
		// 
		// Parameters
		// ----------------------------------------------------
		Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	End if 
	C_TIME:C306($InpFile)
	C_LONGINT:C283($TabPos)
	C_LONGINT:C283($NumLines_L)
	C_TEXT:C284($BIN; $Input_line_txt; $LinePart2_txt; $col1_txt; $col3_txt; $col4_txt; $col5_xtx; $col6_txt; $FedFC_txt)
	C_TEXT:C284($LastBIN_txt)
	//_O_MAP FILE TYPES("TEXT"; "TXT"; "Text files")
	//_O_MAP FILE TYPES("TEXT"; "txt"; "Text files")
	$inpFile:=Open document:C264(""; "TEXT")
	If (OK=1)
		RECEIVE PACKET:C104($inpFile; $Input_line_txt; <>sCR)
		$LastBIN_txt:=""
		$NumLines_L:=1
		SHORT_MESSAGE("Reading...")
		While (OK=1)
			$TabPos:=Position:C15(<>sTAB; $Input_line_txt)
			$BIN:=Substring:C12($Input_line_txt; ($TabPos+1); 3)
			Case of 
				: ($BIN="BIN")
					
				: ($LastBIN_txt#$BIN)
					$LinePart2_txt:=Substring:C12($Input_line_txt; ($TabPos+5))
					$TabPos:=Position:C15(<>sTAB; $LinePart2_txt)
					$LinePart2_txt:=Substring:C12($LinePart2_txt; ($TabPos+1))
					$TabPos:=Position:C15(<>sTAB; $LinePart2_txt)
					$LinePart2_txt:=Substring:C12($LinePart2_txt; ($TabPos+1))
					$TabPos:=Position:C15(<>sTAB; $LinePart2_txt)
					$LinePart2_txt:=Substring:C12($LinePart2_txt; ($TabPos+1))
					$TabPos:=Position:C15(<>sTAB; $LinePart2_txt)
					$LinePart2_txt:=Substring:C12($LinePart2_txt; ($TabPos+1))
					$TabPos:=Position:C15(<>sTAB; $LinePart2_txt)
					$FedFC_txt:=Substring:C12($LinePart2_txt; 1; ($TabPos-1))
					If (Num:C11($FedFC_txt)=0)
						ALERT:C41("Zero Value??? "+$Input_line_txt)
					Else 
						$FedFC_txt:=String:C10(Num:C11($FedFC_txt); "00")
					End if 
					//SET QUERY DESTINATION(Into variable ;$BridgeRecFound)
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
					If (Records in selection:C76([Bridge MHD NBIS:1])#1)
						ALERT:C41("Bad BIN??? "+$BIN)
					Else 
						ut_LoadRecord(->[Bridge MHD NBIS:1])
						If ([Bridge MHD NBIS:1]Item26:120#$FedFC_txt)
							[Bridge MHD NBIS:1]Item26:120:=$FedFC_txt
							LogChanges(->[Bridge MHD NBIS:1]Item26:120; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
							SAVE RECORD:C53([Bridge MHD NBIS:1])
						End if 
						
						UNLOAD RECORD:C212([Bridge MHD NBIS:1])
					End if 
					$LastBIN_txt:=$BIN
					
			End case 
			If (($NumLines_L%20)=0)
				MESSAGE:C88(".."+String:C10($NumLines_L))
				//FLUSH CACHE
			End if 
			
			RECEIVE PACKET:C104($inpFile; $Input_line_txt; <>sCR)
			$NumLines_L:=$NumLines_L+1
			
		End while 
		
		CLOSE WINDOW:C154
		CLOSE DOCUMENT:C267($inpFile)
	End if 
	
End if 
