//%attributes = {"invisible":true}
If (False:C215)
	If (False:C215)
		// ----------------------------------------------------
		// User name (OS): costasmanousakis
		// User name (4D): Designer
		// Date and time: 03/14/06, 14:33:06
		// ----------------------------------------------------
		// Method: Temp_updRRBrgNoToReal
		// Description
		// Convert RRBrgNo to Real value
		// 
		// Parameters
		// ----------------------------------------------------
		Mods_2006_CM03
		Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
	End if 
	
	C_TIME:C306($InpFile)
	C_REAL:C285($NewRRNum_r)
	C_TEXT:C284($BIN; $RRBRGNum_txt; $Input_line_txt; $LinePart2_txt)
	$inpFile:=Open document:C264(""; "TEXT")
	C_LONGINT:C283($TabPos)
	If (OK=1)
		RECEIVE PACKET:C104($inpFile; $Input_line_txt; <>sCR)
		While (OK=1)
			$BIN:=Substring:C12($Input_line_txt; 1; 3)
			$LinePart2_txt:=Substring:C12($Input_line_txt; 5)
			$TabPos:=Position:C15(<>sTAB; $LinePart2_txt)
			$RRBRGNum_txt:=Substring:C12($LinePart2_txt; 1; ($TabPos-1))
			If (Num:C11($RRBRGNum_txt)=0)
				ALERT:C41("Zero Value???")
			End if 
			//SET QUERY DESTINATION(Into variable ;$BridgeRecFound)
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
			If (Records in selection:C76([Bridge MHD NBIS:1])#1)
				ALERT:C41("Bad BIN???")
			Else 
				ut_LoadRecord(->[Bridge MHD NBIS:1])
				//[Bridge MHD NBIS]RRBridgeNo:=Round(Num($RRBRGNum_txt);3)
				UNLOAD RECORD:C212([Bridge MHD NBIS:1])
			End if 
			$NewRRNum_r:=Round:C94(Num:C11($RRBRGNum_txt); 3)
			If (Num:C11($RRBRGNum_txt)#$NewRRNum_r)
				ALERT:C41("Rounding error???")
			End if 
			
			RECEIVE PACKET:C104($inpFile; $Input_line_txt; <>sCR)
		End while 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		CLOSE DOCUMENT:C267($inpFile)
	End if 
	
End if 
