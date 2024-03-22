USE NAMED SELECTION:C332("ARCHStartSelection")
SHORT_MESSAGE("Searching....")
SET QUERY DESTINATION:C396(Into set:K19:2; "ARCHSourceSet")
QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]FileID Local:24=ARCHSRC_TBL_L)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If (Records in set:C195("ARCHSourceSet")>0)
	ARCH_SearchforField(ARCHSRC_FLD_L)
	If (Records in set:C195("ARCHFoundSet")>0)
		UNION:C120("ARCHResultSet"; "ARCHFoundSet"; "ARCHResultSet")
	Else 
	End if 
	Results_txt:="Found "+String:C10(Records in set:C195("ARCHFoundSet"))+" records - total of "+String:C10(Records in set:C195("ARCHResultSet"))+" records so far."
	CLEAR SET:C117("ARCHFoundSet")
Else 
	Results_txt:="Found  0 - total of "+String:C10(Records in set:C195("ARCHResultSet"))+" records so far."
End if 
CLOSE WINDOW:C154
If (Records in set:C195("ARCHResultSet")>0)
	OBJECT SET ENABLED:C1123(ARCSRCDone; True:C214)  // Command Replaced was o_ENABLE BUTTON 
End if 
ARCHSRC_FLD_L:=0
ARCHSRC_FLD_txt:=""
OBJECT SET ENABLED:C1123(FindBtn; False:C215)  // Command Replaced was o_DISABLE BUTTON 
CLEAR SET:C117("ARCHSourceSet")