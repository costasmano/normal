//%attributes = {"invisible":true}
//Method: ConvertNBITapeToTabDelim
//Description
// Convert a file in NBI tape format to a tab delimited file with header
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/16/17, 09:26:21
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//

C_TIME:C306($NBITape_t; $NBITabDelim_t)

$NBITape_t:=Open document:C264(""; ""; Read mode:K24:5)

If (OK=1)
	C_TEXT:C284($NBITabDelim_txt; $path_txt)
	$path_txt:=GetPath(Document)
	$NBITabDelim_txt:=Replace string:C233(Document; $path_txt; "")
	$NBITabDelim_t:=Create document:C266($path_txt+$NBITabDelim_txt+".txt")
	C_LONGINT:C283($progress_L)
	$progress_L:=Progress New
	Progress SET TITLE($progress_L; "Converting "+Document+" to tab delim")
	Progress SET PROGRESS($progress_L; 0)
	Progress SET BUTTON ENABLED($progress_L; True:C214)
	C_REAL:C285($DocPos_r; $DocSize_r)
	$DocSize_r:=Get document size:C479($NBITape_t)
	C_TEXT:C284($tBuffer_txt; $TabLine_txt)
	RECEIVE PACKET:C104($NBITape_t; $tBuffer_txt; <>sCR)
	C_LONGINT:C283($Lines_L)
	$Lines_L:=1
	C_BOOLEAN:C305($Abort_b)
	$Abort_b:=False:C215
	SEND PACKET:C103($NBITabDelim_t; TabbedNBITapeHeader)
	
	While ((OK=1) & Not:C34($Abort_b))
		If (Substring:C12($tBuffer_txt; 1; 1)=<>sLF)
			//if 1st char is a LF then skip it    
			$tBuffer_txt:=Substring:C12($tBuffer_txt; 2)
		End if 
		
		$TabLine_txt:=InsertTabsInNBILine($tBuffer_txt)
		SEND PACKET:C103($NBITabDelim_t; $TabLine_txt)
		
		If ($Lines_L%5=0)
			$DocPos_r:=Get document position:C481($NBITape_t)
			Progress SET PROGRESS($progress_L; ($DocPos_r/$DocSize_r))
			Progress SET MESSAGE($progress_L; "Read "+String:C10($DocPos_r)+" of "+String:C10($DocSize_r)+" bytes")
		End if 
		
		RECEIVE PACKET:C104($NBITape_t; $tBuffer_txt; <>sCR)
		$Abort_b:=Progress Stopped($progress_L)
		$Lines_L:=$Lines_L+1
	End while 
	
	Progress QUIT($progress_L)
	CLOSE DOCUMENT:C267($NBITabDelim_t)
	CLOSE DOCUMENT:C267($NBITape_t)
End if 

//End ConvertNBITapeToTabDelim