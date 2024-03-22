//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/29/08, 08:27:54
	// ----------------------------------------------------
	// Method: M_ExecArchiveLog
	// Description
	// Method to execute the archive Log to file operation,
	// either locally or on the server.
	// Launches :
	ArchiveLogFile($p1; $p2; $p3)
	
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(6/10/11 08:34:54)
	Mods_2011_06
	//  `Do not send job to server if no Archive log records have been selected!
End if 
C_LONGINT:C283(vlArchRecstoExport; r1; r2; r3; r4; CBDelete; $TempWin)
C_DATE:C307(vDate)
r1:=0
r2:=0
r3:=0
r4:=0
CBDelete:=1
C_BOOLEAN:C305($DoArchive_b; $RunLocal_b)
$DoArchive_b:=False:C215

C_LONGINT:C283($W; $H)
FORM GET PROPERTIES:C674([Dialogs:21]; "ArchiveDlog"; $W; $H)
//$TempWin:=Open form window([Dialogs];"ArchiveDlog";Movable dialog box )
CENTER_WINDOW($W; $H; Movable dialog box:K34:7)
DIALOG:C40([Dialogs:21]; "ArchiveDlog")
CLOSE WINDOW:C154
$DoArchive_b:=(OK=1)
If ($DoArchive_b)
	C_TEXT:C284($Archopt_txt; $NumDel_txt; $DelDate_txt; $DelOpt_txt; $msg_txt; $p1; $p2; $p3)
	C_LONGINT:C283($pid)
	$p1:=""
	$p2:=""
	$p3:=""
	C_DATE:C307($year)
	$RunLocal_b:=True:C214
	$DelOpt_txt:=String:C10(CBDelete)
	Case of 
		: (r1=1)
			$Archopt_txt:="1"
			$p2:=$DelOpt_txt
		: (r2=1)
			$Archopt_txt:="2"
			$NumDel_txt:=String:C10(vlArchRecstoExport)
			$p2:=$NumDel_txt
			$p3:=$DelOpt_txt
		: (r3=1)
			$Archopt_txt:="3"
			$DelDate_txt:=String:C10(vDate)
			$p2:=$DelDate_txt
			$p3:=$DelOpt_txt
		: (r4=1)
			$Archopt_txt:="4"
			$p2:=$DelOpt_txt
	End case 
	$p1:=$Archopt_txt
	If (Application type:C494=4D Remote mode:K5:5)
		$msg_txt:="Execute the Export ArchiveLog operation on the server or locally?"
		CONFIRM:C162($msg_txt; "Server"; "Local")
		If (OK=1)
			$RunLocal_b:=False:C215
			//Verify export...
			C_LONGINT:C283($Records_L)
			Case of 
				: ($p1="1")
					$year:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33(*))))
					QUERY:C277([Activity Log:59]; [Activity Log:59]dDate:5<$year)
				: ($p1="2")
					ALL RECORDS:C47([Activity Log:59])
					ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28; >)
					REDUCE SELECTION:C351([Activity Log:59]; Num:C11($p2))
				: ($p1="3")
					QUERY:C277([Activity Log:59]; [Activity Log:59]dDate:5<Date:C102($p2))
				: ($p1="4")
					ALL RECORDS:C47([Activity Log:59])
			End case 
			$Records_L:=Records in selection:C76([Activity Log:59])
			If ($Records_L>0)
				$msg_txt:="A total of "+String:C10($Records_L)+" records from the [Activity Log] table"
				$msg_txt:=$msg_txt+" will be exported"
				If (CBDelete=1)
					$msg_txt:=$msg_txt+" and then deleted leaving "+String:C10(Records in table:C83([Activity Log:59])-$Records_L)+" records!"
				Else 
					$msg_txt:=$msg_txt+"!"
				End if 
				$msg_txt:=$msg_txt+"  Submit job to the server?"
				CONFIRM:C162($msg_txt)
				If (OK=1)
					//submit job to server
					$pid:=Execute on server:C373("ArchiveLogFile"; <>LStackSize; "ExportArchiveLog"; $p1; $p2; $p3)
					If ($pid=0)
						ALERT:C41("Error starting the Export Archive")
					End if 
				End if 
			Else 
				ALERT:C41("There were no Archive Log records selected for exporting!")
			End if 
			
		End if 
	End if 
	If ($RunLocal_b)
		$pid:=New process:C317("ArchiveLogFile"; <>LStackSize; "ExportArchiveLog"; $p1; $p2; $p3; *)
		If ($pid=0)
			ALERT:C41("Error starting the Export Archive")
		End if 
	End if 
	
End if 