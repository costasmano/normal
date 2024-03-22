// Method: [ElementsSafety];"Rpt DefElem Comments2"
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 

Case of 
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=vPageNo+1
		
	: (Form event code:C388=On Printing Detail:K2:18)
		//Set Doc Margins (vCmtsArea)
		//WR INSERT STYLED TEXT (vCmtsArea;vCmtsArea_)
		
End case 