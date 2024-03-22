C_LONGINT:C283(PON_PARENTENV_L; PON_PARENTSTRUNIT_L; PON_PARENTKEY_L; PON_GRANDPARENTKEY_L)
C_BOOLEAN:C305(PON_ADDPROTSYS_b)
PON_PARENTENV_L:=0
PON_PARENTSTRUNIT_L:=0
PON_PARENTKEY_L:=0
PON_GRANDPARENTKEY_L:=0
PON_ADDPROTSYS_b:=False:C215
//ALERT("Add New NBE ELEMENT!")
//need to have a BMS inspection record
If ([Combined Inspections:90]BMSInspID:3<=0)
	//first add a bms inspection record - is needed to store HI results
	G_AddPontisToCombined
End if 

ADD RECORD:C56([PON_ELEM_INSP:179])
If (OK=1)
	PON_ListElements
End if 

//set to no parent after adding
PON_PARENTKEY_L:=0
