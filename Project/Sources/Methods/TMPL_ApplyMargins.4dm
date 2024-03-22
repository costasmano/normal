//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/17/10, 19:43:55
	// ----------------------------------------------------
	// Method: TMPL_ApplyMargins
	// Description
	//  ` Copy the margins from one selected (USERSET) 4D Write template to the  others in the selection
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_10
End if 

//If (Records in selection([Templates])>0)

//If (Records in set("UserSet")=1)
//COPY NAMED SELECTION([Templates];"APPLYMARGINSSELECTiON")

//COPY SET("UserSet";"RECORDTOCOPY")
//USE SET("UserSet")
//FIRST RECORD([Templates])
//LOAD RECORD([Templates])
//C_LONGINT($WRAREA_L;$RecToCopyFrom_L)
//C_REAL($WRUnit_r)

//  //If ([Templates]TemplateName="WRT@")
//  //$WRAREA_L:=WR New offscreen area 
//  //WR BLOB TO AREA ($WRAREA_L;[Templates]Template_)
//  //$WRUnit_r:=WR Get doc property ($WRAREA_L;wr unit)
//  //WR SET DOC PROPERTY ($WRAREA_L;wr unit;2)  //pixels - more precise, no rounding errors
//  //WRT_GetSetMargins ($WRAREA_L;"GET")
//  //$RecToCopyFrom_L:=[Templates]TemplateID
//  //USE NAMED SELECTION("APPLYMARGINSSELECTiON")
//  //FIRST RECORD([Templates])
//  //While (Not(End selection([Templates])))
//  //If ([Templates]TemplateID#$RecToCopyFrom_L)

//  //If ([Templates]TemplateName="WRT@")
//  //WR BLOB TO AREA ($WRAREA_L;[Templates]Template_)
//  //$WRUnit_r:=WR Get doc property ($WRAREA_L;wr unit)
//  //WR SET DOC PROPERTY ($WRAREA_L;wr unit;2)  //pixels - more precise, no rounding errors
//  //WRT_GetSetMargins ($WRAREA_L;"SET")
//  //WRT_GetSetMargins ($WRAREA_L;"SET")
//  //WR SET DOC PROPERTY ($WRAREA_L;wr unit;$WRUnit_r)
//  //[Templates]Template_:=WR Area to blob ($WRAREA_L;1)
//  //WR SET AREA PROPERTY ($WRAREA_L;wr modified;0;"")
//  //LogChanges (->[Templates]Template_;->[Templates]TemplateID;->[Templates]TemplateID;->[Templates]TemplateID;0)
//  //SAVE RECORD([Templates])

//  //Else 
//  //ALERT("Template "+[Templates]TemplateName+" not a 4D Write template!")
//  //End if 
//  //End if 
//  //NEXT RECORD([Templates])
//  //End while 

//Else 
//ALERT("Not a 4D Write Template!")
//End if 
//CLEAR NAMED SELECTION("APPLYMARGINSSELECTiON")
//HIGHLIGHT RECORDS([Templates];"RECORDTOCOPY")
//CLEAR SET("RECORDTOCOPY")
//Else 
//ALERT("Must Select one record to use margins!")
//End if 

//Else 
//ALERT("There are no records listed!")

//End if 