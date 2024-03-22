//%attributes = {"invisible":true}
If (False:C215)
	//Temp_fix_d1
	//Method to fix all item 6B and 100 in district 1
	C_LONGINT:C283($recs; $i)
	
	
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="DIST1")
	//QUERY([Bridge MHD NBIS]; & [Bridge MHD NBIS]Item6B=True)
	$recs:=Records in selection:C76([Bridge MHD NBIS:1])
	
	ALERT:C41("Found  "+String:C10($recs)+" DIST 1 records")
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	For ($i; 1; $recs)
		//InitChangeStack (1)
		[Bridge MHD NBIS:1]Item6B:64:=False:C215
		// PushChange (1;->[Bridge MHD NBIS]Item6B)
		//FlushChanges (1;->[Bridge MHD NBIS]BIN;->[Bridge MHD NBIS]BIN;->
		//[Bridge MHD NBIS]BIN;0)
		LogChanges(->[Bridge MHD NBIS:1]Item6B:64; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
		NEXT RECORD:C51([Bridge MHD NBIS:1])
	End for 
	//APPLY TO SELECTION([Bridge MHD NBIS];[Bridge MHD NBIS]Item6B:=False)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="DIST1"; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item100:121#"0")
	$recs:=Records in selection:C76([Bridge MHD NBIS:1])
	
	ALERT:C41("Found  "+String:C10($recs)+" records")
	//APPLY TO SELECTION([Bridge MHD NBIS];[Bridge MHD NBIS]Item100:="0")
End if 