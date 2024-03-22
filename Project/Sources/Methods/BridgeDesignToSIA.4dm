//%attributes = {"invisible":true}
If (False:C215)
	//BridgeDesignToSIA 
	//8/2003
	//When the Initial Inspection flag gets checked, 
	//copy the bridge design records to [Bridge MHD NBIS] table
	
	
	// Modified by: costasmanousakis-(Designer)-(2/27/2007 15:52:09)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(11/30/07 12:18:10)
	Mods_2007_CM_5401
End if 
// 1) Check if a Bridge Design record exists  
READ ONLY:C145([Bridge Design:75])
QUERY:C277([Bridge Design:75]; [Bridge Design:75]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([Bridge Design:75]; [Bridge Design:75]ADVDate:4; <)

If (Records in selection:C76([Bridge Design:75])=0)
	ALERT:C41("There is no related bridge design data.")
Else 
	REDUCE SELECTION:C351([Bridge Design:75]; 1)
	// 2) Display dialog box so users can select which data to copy to SI&A  
	// 3) Do the translation and copy the records to Master table  
	// CENTER_WINDOW (330;200)
	If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
		C_LONGINT:C283($WW; $WH)
		FORM GET PROPERTIES:C674([Dialogs:21]; "DesignToSIA"; $WW; $WH)
		//$WW:=$WW/2
		CENTER_WINDOW($WW; 400; Plain window:K34:13)
		FORM SET INPUT:C55([Dialogs:21]; "DesignToSIA")
		ADD RECORD:C56([Dialogs:21])
		CLOSE WINDOW:C154
	Else 
		C_TEXT:C284($msg)
		$msg:="Data from the Bridge Design table were not transferred to the SI&A record!"
		$msg:=$msg+<>sCR+"You can try again at another time by checking off and then back on the Initial In"+"spection checkbox!"
		ALERT:C41($msg)
	End if 
End if 
READ WRITE:C146([Bridge Design:75])