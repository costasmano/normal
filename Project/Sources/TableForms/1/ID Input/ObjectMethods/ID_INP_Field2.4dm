If (False:C215)
	//SC [Bridge MHD NBIS]BDEPT on layout [Bridge MHD NBIS];"BDEPT Input".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	Mods_2005_CM01
	
End if 

C_TEXT:C284($bin)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($bdept; $oldBdept)  // Command Replaced was o_C_STRING length was 6
C_LONGINT:C283($recs)
C_TEXT:C284($text)  // Command Replaced was o_C_STRING length was 255
C_BOOLEAN:C305($vbContinue)

$oldBdept:=Old:C35([Bridge MHD NBIS:1]BDEPT:1)
$vbContinue:=True:C214
If ($oldBdept#[Bridge MHD NBIS:1]BDEPT:1)
	$text:="Warning : You are changing BDEPT from "+$oldBdept+" to "+[Bridge MHD NBIS:1]BDEPT:1+" !!!"
	$text:=$text+<>sCR+"  Are you sure you want to continue with the change?"
	CONFIRM:C162($text; "Continue"; "Cancel")
	If (OK#1)
		[Bridge MHD NBIS:1]BDEPT:1:=$oldBdept
		REDRAW:C174([Bridge MHD NBIS:1]BDEPT:1)
		$vbContinue:=False:C215
	End if 
End if 

If ($vbContinue)
	
	$bin:=[Bridge MHD NBIS:1]BIN:3
	$bdept:=[Bridge MHD NBIS:1]BDEPT:1
	//COPY NAMED SELECTION([Bridge MHD NBIS];"BDEPTChkSelection")
	SET QUERY DESTINATION:C396(Into variable:K19:4; $recs)
	//PUSH RECORD([Bridge MHD NBIS])
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$bdept; *)
	QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]BIN:3#$bin)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	//$recs:=Records in selection([Bridge MHD NBIS])
	If ($recs>=1)
		$text:="Warning:"+<>sCR+<>sCR+"There already "
		Case of 
			: ($recs=1)
				$text:=$text+"is one record "
			: ($recs>1)
				$text:=$text+"are "+String:C10($recs)+" records "
		End case 
		$text:=$text+"with BDEPT='"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 1)+"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 2; 2)
		$text:=$text+"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 4; 3)+"'."+<>sCR+<>sCR+"Please verify."
		ALERT:C41($text)
		GOTO OBJECT:C206([Bridge MHD NBIS:1]BDEPT:1)
	End if 
	
	PushChange(1; Self:C308)
	//Change added on 1/31/2001
	[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BDEPT:1; 1)
	PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
	// End of change made on 1/31/2001
	
	[Bridge MHD NBIS:1]Town Name:175:=Get_Town_Name([Bridge MHD NBIS:1]BDEPT:1)
	[Bridge MHD NBIS:1]Item2:60:=Get_District([Bridge MHD NBIS:1]BDEPT:1)
	[Bridge MHD NBIS:1]Item3:61:=Get_County([Bridge MHD NBIS:1]BDEPT:1)
	[Bridge MHD NBIS:1]Item4:62:=Get_Place([Bridge MHD NBIS:1]BDEPT:1)
	[Bridge MHD NBIS:1]RPC_Codes:183:=Get_RPCCode([Bridge MHD NBIS:1]BDEPT:1)
	[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; Get_Town_Code([Bridge MHD NBIS:1]BDEPT:1); 4)
	PushChange(1; ->[Bridge MHD NBIS:1]Town Name:175)
	PushChange(1; ->[Bridge MHD NBIS:1]Item2:60)
	PushChange(1; ->[Bridge MHD NBIS:1]Item3:61)
	PushChange(1; ->[Bridge MHD NBIS:1]Item4:62)
	PushChange(1; ->[Bridge MHD NBIS:1]RPC_Codes:183)
	PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
	
	vTown:=[Bridge MHD NBIS:1]Town Name:175+" (D-"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))+")"
	//Reset Town list
	C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER
	$k:=Find in array:C230(aTownName_; [Bridge MHD NBIS:1]Town Name:175)
	If ($k>0)
		aTownName_:=$k
	Else 
		aTownName_:=1
	End if 
	REDRAW:C174(aTownName_)
End if 