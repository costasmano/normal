//%attributes = {"invisible":true}
//procedure: ChkActLogQueue
//purpose: if the Activitlog queue (Status=0) is greater than 1000 request to send
If (False:C215)
	//by: Albert Leung
	//created: 10/1/98
	//
	// Modified by: Costas Manousakis-(Designer)-(5/10/19 09:21:22)
	Mods_2019_05
	//  `also check if current user is the one allowed to transfer
	
End if 
C_LONGINT:C283($recs)
C_TEXT:C284($t)

If ((<>Transfer#-1) & (<>TxUserName=Current user:C182))
	SET QUERY DESTINATION:C396(Into variable:K19:4; $recs)
	QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0)
	//$recs:=Records in selection([Activity Log])
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs>1000)
		$t:="There are "+String:C10($recs)+" changes to be transferred."+<>sCR+<>sCR
		$t:=$t+"Do you wish to send these changes now?"
		CONFIRM:C162($t)
		If (Ok=1)
			M_Exec Transfer
		End if 
	End if 
End if 