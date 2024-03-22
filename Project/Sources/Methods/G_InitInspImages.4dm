//%attributes = {"invisible":true}
//G_InitInspImages
//Initialize Inspection Image vars.
//Should be called by Inspection form method at On Load event
If (False:C215)
	
	// Modified by: Costas Manousakis-(Designer)-(4/29/19 14:04:18)
	Mods_2019_04
	//  `initialize the NTI_ImageSortNeeded_b in the on Load event
End if 

If (Form event code:C388=On Load:K2:1)
	C_BOOLEAN:C305(NTI_ImageSortNeeded_b)
	NTI_ImageSortNeeded_b:=False:C215
End if 

C_LONGINT:C283(vNextPhotoSeq; vNextSketchSeq; vNextChartSeq)  //Command Replaced was o_C_INTEGER

COPY NAMED SELECTION:C331([Standard Photos:36]; "TempPicts")
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Photo)
vNextPhotoSeq:=Records in selection:C76([Standard Photos:36])+1
USE NAMED SELECTION:C332("TempPicts")
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Sketch)
vNextSketchSeq:=Records in selection:C76([Standard Photos:36])+1
USE NAMED SELECTION:C332("TempPicts")
QUERY SELECTION:C341([Standard Photos:36]; [Standard Photos:36]PictType:5=BMS Chart)
vNextChartSeq:=Records in selection:C76([Standard Photos:36])+1
USE NAMED SELECTION:C332("TempPicts")
CLEAR NAMED SELECTION:C333("TempPicts")
G_SortInspImages