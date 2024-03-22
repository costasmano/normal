If (False:C215)
	// ----------------------------------------------------
	// User name (OS): root
	// User name (4D): Designer
	// Date and time: 10/15/07, 11:38:39
	// ----------------------------------------------------
	// Method: Form Method: [PRJ_ProjectDetails];"AdStatusList"
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	
	//calls
	PRJAD_SortTheColumn
	PRJAD_OpentheRow
End if 

Case of 
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Load:K2:1)
		//C_POINTER(pFile)
		//pFile:=Current form table
		//PV_ConfigureAsList (AdStatusVArea)
		//PV SET AREA PROPERTY (AdStatusVArea;pv column headers height;33)
		
		//PV_InitFormats (AdStatusVArea)
		//PRJ_ShowAdPrjStatus ("VIEWSETTINGS")
		//PV_SetFont (AdStatusVArea;"Arial";12;0)
		
		//PV_SetColumnArrays2 (AdStatusVArea;->PRJAD_Cols_at)
		//PV_SetColumnHeaders2 (AdStatusVArea;->PRJAD_ColNames_at)
		//  //PV_SetColumnWidths (->eArea;0;55;35;65;180;75;75;115;125;150;180;40;35;55;60;35;170;150;0)
		//PV_SetColumnWidths2 (->AdStatusVArea;->PRJAD_ColW_aL)
		//PV_SetColumnFormat (->AdStatusVArea;->PRJAD_ColHorAlign_aL;->PRJAD_ColAlphaF_aL;->PRJAD_ColNumF_aL;->PRJAD_ColDateF_aL;->PRJAD_ColBoolF_aL;->PRJAD_ColPicF_aL)
		//PV SET ROWS HEIGHT (AdStatusVArea;0;0;20)
		//PV SET RANGE PROPERTY (AdStatusVArea;1;1;Size of array(PRJAD_Cols_at);Size of array(PRJAD_RecNum_aL);pv style vert alignment;pv value vert alignment center)
		//PV SET AREA PROPERTY (AdStatusVArea;pv row headers width;1)
		//PV SET AREA PROPERTY (AdStatusVArea;pv show vert grid;pv value on)
		//PV SET HEADER (AdStatusVArea;pv footer center;"Printed on #∂")
		//PV SET HEADER (AdStatusVArea;pv footer right;"Page #p of #P")
		//PV SET PRINT PROPERTY (AdStatusVArea;pv print headers;pv value on;"")
		//PV SET PRINT PROPERTY (AdStatusVArea;pv print grid;pv value on;"")
		//PV SET PRINT PROPERTY (AdStatusVArea;pv print orientation;pv landscape orientation;"")
		//PV SET PRINT PROPERTY (AdStatusVArea;pv print frame each page;pv value off;"")
		//PV SET PRINT PROPERTY (AdStatusVArea;pv print left margin;10;"")
		//PV SET PRINT PROPERTY (AdStatusVArea;pv print right margin;5;"")
		//  //PV SET PRINT PROPERTY (AdStatusVArea;pv print centered ;pv value on )
		
		//PV_SetSelectedRow (AdStatusVArea;0)
		//PV ON EVENT (AdStatusVArea;pv on clicked;"PRJAD_SortTheColumn")
		//PV ON EVENT (AdStatusVArea;pv on double clicked;"PRJAD_OpentheRow")
		//MULTI SORT ARRAY(PRJAD_sortArrays_ap;PRJAD_sortArrayOrder_aL)
		//CREATE SELECTION FROM ARRAY(pFile->;PRJAD_RecNum_aL)
		//SET WINDOW TITLE("Ad Status List ["+String(Records in selection(pFile->))+"]")
		//If (False)
		//C_LONGINT($WL;$WT;$WR;$Wb)
		//GET WINDOW RECT($WL;$WT;$WR;$Wb)
		//SET WINDOW RECT($WL;$WT;($WR+1);$Wb)
		//REDRAW WINDOW
		//SET WINDOW RECT($WL;$WT;$WR;$Wb)
		//REDRAW WINDOW
		
		//End if 
	: (Form event code:C388=On Validate:K2:3)
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
End case 
