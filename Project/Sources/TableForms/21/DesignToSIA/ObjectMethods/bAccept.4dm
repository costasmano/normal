//````````````````````````````````
//```` Not converted data
//```````````````````````````````` 
If (chkSkewAngle=1)
	[Bridge MHD NBIS:1]Item34:100:=trans_vSkewAngle
	PushChange(2; ->[Bridge MHD NBIS:1]Item34:100)
End if 

If (chkNumSpans=1)
	[Bridge MHD NBIS:1]Item45:77:=trans_vNumSpans
	PushChange(2; ->[Bridge MHD NBIS:1]Item45:77)
End if 

If (chkLanesOn=1)
	[Bridge MHD NBIS:1]Item28A:86:=trans_vLanesOn
	PushChange(2; ->[Bridge MHD NBIS:1]Item28A:86)
End if 

If (chkLanesUnder=1)
	[Bridge MHD NBIS:1]Item28B:87:=trans_vLanesUnder
	PushChange(2; ->[Bridge MHD NBIS:1]Item28B:87)
End if 

If (chkADT=1)
	[Bridge MHD NBIS:1]Item29:88:=trans_vADT
	PushChange(2; ->[Bridge MHD NBIS:1]Item29:88)
End if 

If (chkYearADT=1)
	[Bridge MHD NBIS:1]Item30:89:=trans_vADTYear
	PushChange(2; ->[Bridge MHD NBIS:1]Item30:89)
End if 
//````````````````````````````````
//``` Translation
//`````````````````````````````````
If (chkDesignLoad=1)
	[Bridge MHD NBIS:1]Item31:135:=trans_vDesignLoad
	PushChange(2; ->[Bridge MHD NBIS:1]Item31:135)
End if 

If (chkStructure=1)
	[Bridge MHD NBIS:1]Item43:75:=trans_vStructCode
	PushChange(2; ->[Bridge MHD NBIS:1]Item43:75)
	
	//`Save changes to Inspections table  
	[Inspections:27]Item 43:140:=trans_vStructCode
	PushChange(1; ->[Inspections:27]Item 43:140)
	vItem43:=trans_vStructDesc
	vItem43ab:=trans_vStructDesc
End if 

If (chkDeck=1)
	[Bridge MHD NBIS:1]Item107:79:=trans_vDeckCode
	PushChange(2; ->[Bridge MHD NBIS:1]Item107:79)
	
	//`Save changes to Inspections table
	[Inspections:27]Item 107:141:=trans_vDeckCode
	PushChange(1; ->[Inspections:27]Item 107:141)
	vItem107:=trans_vDeckDesc
	
	[Bridge MHD NBIS:1]Item108A:80:=trans_vWearingSurfaceCode
	PushChange(2; ->[Bridge MHD NBIS:1]Item108A:80)
End if 

If (chkScour=1)
	[Bridge MHD NBIS:1]Item113:151:=trans_vScour
	PushChange(2; ->[Bridge MHD NBIS:1]Item113:151)
End if 

If (chkSideWalkLeft=1)
	[Bridge MHD NBIS:1]Item50A:94:=trans_vSideLeft
	PushChange(2; ->[Bridge MHD NBIS:1]Item50A:94)
End if 

If (chkSideWalkRight=1)
	[Bridge MHD NBIS:1]Item50B:95:=trans_vSideRight
	PushChange(2; ->[Bridge MHD NBIS:1]Item50B:95)
End if 

If (chkSpanLength=1)
	[Bridge MHD NBIS:1]Item48:92:=trans_vSpanLength
	PushChange(2; ->[Bridge MHD NBIS:1]Item48:92)
End if 

If (chkWidthOut=1)
	[Bridge MHD NBIS:1]Item52:97:=trans_vWidthOut
	PushChange(2; ->[Bridge MHD NBIS:1]Item52:97)
End if 

If (chkStructLength=1)
	[Bridge MHD NBIS:1]Item49:93:=trans_vStructLength
	PushChange(2; ->[Bridge MHD NBIS:1]Item49:93)
End if 

If (chkCurbOut=1)
	[Bridge MHD NBIS:1]Item51:96:=trans_vWidthCurb
	PushChange(2; ->[Bridge MHD NBIS:1]Item51:96)
End if 

If (chkMinVertUc=1)
	[Bridge MHD NBIS:1]Item54A:107:=trans_vMinVertUc_code
	PushChange(2; ->[Bridge MHD NBIS:1]Item54A:107)
	
	[Bridge MHD NBIS:1]Item54B:108:=trans_vMinVertUc
	PushChange(2; ->[Bridge MHD NBIS:1]Item54B:108)
	
End if 

If (chkMinLatUcRt=1)
	[Bridge MHD NBIS:1]Item55A:110:=trans_vMinLatUcRt_code
	PushChange(2; ->[Bridge MHD NBIS:1]Item55A:110)
	
	[Bridge MHD NBIS:1]Item55B:111:=trans_vMinLatUcRt
	PushChange(2; ->[Bridge MHD NBIS:1]Item55B:111)
End if 

If (chkMinLatUcLt=1)
	[Bridge MHD NBIS:1]Item56:112:=trans_vMinLatUcLt
	PushChange(2; ->[Bridge MHD NBIS:1]Item56:112)
End if 

SAVE RECORD:C53([Bridge MHD NBIS:1])
FlushGrpChgs(2; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)

CANCEL:C270