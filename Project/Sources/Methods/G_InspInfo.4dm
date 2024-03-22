//%attributes = {"invisible":true}
//G_InspInfo
If (False:C215)
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(5/2/08 11:50:36)
	Mods_2008_CM_5403
	//  `Get the storage only if the shift key is pressed while running this method.
	// Modified by: Costas Manousakis-(Designer)-(4/14/15 17:30:20)
	Mods_2015_04
	//  `changed window type to Plain window
	// Modified by: Costas Manousakis-(Designer)-(2022-07-11 13:16:37)
	Mods_2022_07
	//  `added object parameter to DIALOG command to change the label on the form
End if 

C_TEXT:C284(vModifiedBy; vRecordCmts)
C_DATE:C307(vDateC; vDateM)
C_TIME:C306(vTimeC; vTimeM)
vModifiedBy:=[Inspections:27]Modified By:134
vDateC:=[Inspections:27]DateCreated:135
vTimeC:=[Inspections:27]TimeCreated:136
vDateM:=[Inspections:27]DateModified:137
vTimeM:=[Inspections:27]TimeModified:138
SET CURSOR:C469(4)
vRecordCmts:="Insp ID :<"+String:C10([Inspections:27]InspID:2)+">.  "
vRecordCmts:=vRecordCmts+"Comb Insp ID :<"+String:C10([Combined Inspections:90]ID:6)+">.  "
vRecordCmts:=vRecordCmts+"Pontis Insp ID :<"+String:C10([BMS Inspections:44]Inspection ID:1)+">.  "
If (Shift down:C543)
	vRecordCmts:=vRecordCmts+"Approx. Storage : "+String:C10(fInspSize; "##,###,##0 bytes")
End if 
SET CURSOR:C469(0)
C_LONGINT:C283($fWitdh; $fHeight)
FORM GET PROPERTIES:C674([Dialogs:21]; "RecordInfo"; $fWitdh; $fHeight)
NewWindow($fWitdh; $fHeight; 0; Plain window:K34:13)
DIALOG:C40([Dialogs:21]; "RecordInfo"; New object:C1471("modifiedLabel"; "This inspection was created by"))
vModifiedBy:=""
vRecordCmts:=""