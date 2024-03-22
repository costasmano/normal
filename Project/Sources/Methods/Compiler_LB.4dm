//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 01/11/12, 12:51:50
//----------------------------------------------------
//Method: Compiler_LB
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_01  //r001
	//Modified by: Charles Miller (1/11/12 12:51:52)
	Mods_2012_03  //r003 `Add code to use list box for Inventory button on 
	//Modified by: Charles Miller (3/29/12 14:16:30)
	Mods_2013_06  //r001 ` Add new functionality to save and load users and groups including saveing and loading log in info
	//Modified by: Charles Miller (6/20/13 14:34:48)
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:40:57)
	Mods_2013_09
	//  `Added Dates
	// Modified by: Costas Manousakis-(Designer)-(12/23/13 10:53:42)
	Mods_2013_12
	//  `moved methods from Compiler_methods
	// Modified by: Costas Manousakis-(Designer)-(4/10/17 12:46:21)
	Mods_2017_04
	//  `C_LONGINT(LB_ProcessNBEQuery; $0)
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:28:15)
	Mods_2020_06  //Add list box output forms
	//Modified by: Chuck (6/25/20 15:43:49)
End if 
If (Not:C34(Is compiled mode:C492))
	C_LONGINT:C283(LB_Header1_l; LB_Header2_l; LB_Header3_l; LB_Header4_l; LB_Header5_l; LB_Header6_l; LB_Header7_l; LB_Header8_l; LB_Header9_l; LB_Header10_l)
	C_LONGINT:C283(LB_Header11_l; LB_Header12_l; LB_Header13_l; LB_Header14_l; LB_Header15_l; LB_Header16_l; LB_Header17_l; LB_Header18_l; LB_Header19_l; LB_Header20_l)
	C_LONGINT:C283(LB_Header21_l; LB_Header22_l; LB_Header23_l; LB_Header24_l; LB_Header25_l; LB_Header26_l; LB_Header27_l; LB_Header28_l; LB_Header29_l; LB_Header30_l)
	C_LONGINT:C283(LB_Header31_l; LB_Header32_l; LB_Header33_l; LB_Header34_l; LB_Header35_l; LB_Header36_l; LB_Header37_l; LB_Header38_l; LB_Header39_l; LB_Header40_l)
	
	C_TEXT:C284(LB_Header1_txt; LB_Header2_txt; LB_Header3_txt; LB_Header4_txt; LB_Header5_txt; LB_Header6_txt; LB_Header7_txt; LB_Header8_txt; LB_Header9_txt; LB_Header10_txt)
	C_TEXT:C284(LB_Header11_txt; LB_Header12_txt; LB_Header13_txt; LB_Header14_txt; LB_Header15_txt; LB_Header16_txt; LB_Header17_txt; LB_Header18_txt; LB_Header19_txt; LB_Header20_txt)
	C_TEXT:C284(LB_Header21_txt; LB_Header22_txt; LB_Header23_txt; LB_Header24_txt; LB_Header25_txt; LB_Header26_txt; LB_Header27_txt; LB_Header28_txt; LB_Header29_txt; LB_Header30_txt)
	C_TEXT:C284(LB_Header31_txt; LB_Header32_txt; LB_Header33_txt; LB_Header34_txt; LB_Header35_txt; LB_Header36_txt; LB_Header37_txt; LB_Header38_txt; LB_Header39_txt; LB_Header40_txt)
	
	C_TEXT:C284(LB_Detail1_txt; LB_Detail2_txt; LB_Detail3_txt; LB_Detail4_txt; LB_Detail5_txt; LB_Detail6_txt; LB_Detail7_txt; LB_Detail8_txt; LB_Detail9_txt; LB_Detail10_txt)
	C_TEXT:C284(LB_Detail11_txt; LB_Detail12_txt; LB_Detail13_txt; LB_Detail14_txt; LB_Detail15_txt; LB_Detail16_txt; LB_Detail17_txt; LB_Detail18_txt; LB_Detail19_txt; LB_Detail20_txt)
	C_TEXT:C284(LB_Detail21_txt; LB_Detail22_txt; LB_Detail23_txt; LB_Detail24_txt; LB_Detail25_txt; LB_Detail26_txt; LB_Detail27_txt; LB_Detail28_txt; LB_Detail29_txt; LB_Detail30_txt)
	C_TEXT:C284(LB_Detail31_txt; LB_Detail32_txt; LB_Detail33_txt; LB_Detail34_txt; LB_Detail35_txt; LB_Detail36_txt; LB_Detail37_txt; LB_Detail38_txt; LB_Detail39_txt; LB_Detail40_txt)
	
	C_REAL:C285(LB_Detail1_r; LB_Detail2_r; LB_Detail3_r; LB_Detail4_r; LB_Detail5_r; LB_Detail6_r; LB_Detail7_r; LB_Detail8_r; LB_Detail9_r; LB_Detail10_r)
	C_REAL:C285(LB_Detail11_r; LB_Detail12_r; LB_Detail13_r; LB_Detail14_r; LB_Detail15_r; LB_Detail16_r; LB_Detail17_r; LB_Detail18_r; LB_Detail19_r; LB_Detail20_r)
	C_REAL:C285(LB_Detail21_r; LB_Detail22_r; LB_Detail23_r; LB_Detail24_r; LB_Detail25_r; LB_Detail26_r; LB_Detail27_r; LB_Detail28_r; LB_Detail29_r; LB_Detail30_r)
	C_REAL:C285(LB_Detail31_r; LB_Detail32_r; LB_Detail33_r; LB_Detail34_r; LB_Detail35_r; LB_Detail36_r; LB_Detail37_r; LB_Detail38_r; LB_Detail39_r; LB_Detail40_r)
	
	C_DATE:C307(LB_Detail1_d; LB_Detail2_d; LB_Detail3_d; LB_Detail4_d; LB_Detail5_d; LB_Detail6_d; LB_Detail7_d; LB_Detail8_d; LB_Detail9_d; LB_Detail10_d)
	C_DATE:C307(LB_Detail11_d; LB_Detail12_d; LB_Detail13_d; LB_Detail14_d; LB_Detail15_d; LB_Detail16_d; LB_Detail17_d; LB_Detail18_d; LB_Detail19_d; LB_Detail20_d)
	C_DATE:C307(LB_Detail21_d; LB_Detail22_d; LB_Detail23_d; LB_Detail24_d; LB_Detail25_d; LB_Detail26_d; LB_Detail27_d; LB_Detail28_d; LB_Detail29_d; LB_Detail30_d)
	C_DATE:C307(LB_Detail31_d; LB_Detail32_d; LB_Detail33_d; LB_Detail34_d; LB_Detail35_d; LB_Detail36_d; LB_Detail37_d; LB_Detail38_d; LB_Detail39_d; LB_Detail40_d)
	
	C_PICTURE:C286(LB_Detail1_pct; LB_Detail2_pct; LB_Detail3_pct; LB_Detail4_pct; LB_Detail5_pct; LB_Detail6_pct; LB_Detail7_pct; LB_Detail8_pct; LB_Detail9_pct; LB_Detail10_pct)
	C_PICTURE:C286(LB_Detail11_pct; LB_Detail12_pct; LB_Detail13_pct; LB_Detail14_pct; LB_Detail15_pct; LB_Detail16_pct; LB_Detail17_pct; LB_Detail18_pct; LB_Detail19_pct; LB_Detail20_pct)
	C_PICTURE:C286(LB_Detail21_pct; LB_Detail22_pct; LB_Detail23_pct; LB_Detail24_pct; LB_Detail25_pct; LB_Detail26_pct; LB_Detail27_pct; LB_Detail28_pct; LB_Detail29_pct; LB_Detail30_pct)
	C_PICTURE:C286(LB_Detail31_pct; LB_Detail32_pct; LB_Detail33_pct; LB_Detail34_pct; LB_Detail35_pct; LB_Detail36_pct; LB_Detail37_pct; LB_Detail38_pct; LB_Detail39_pct; LB_Detail40_pct)
	
	C_BOOLEAN:C305(LB_Detail1_b; LB_Detail2_b; LB_Detail3_b; LB_Detail4_b; LB_Detail5_b; LB_Detail6_b; LB_Detail7_b; LB_Detail8_b; LB_Detail9_b; LB_Detail10_b)
	C_BOOLEAN:C305(LB_Detail11_b; LB_Detail12_b; LB_Detail13_b; LB_Detail14_b; LB_Detail15_b; LB_Detail16_b; LB_Detail17_b; LB_Detail18_b; LB_Detail19_b; LB_Detail20_b)
	C_BOOLEAN:C305(LB_Detail21_b; LB_Detail22_b; LB_Detail23_b; LB_Detail24_b; LB_Detail25_b; LB_Detail26_b; LB_Detail27_b; LB_Detail28_b; LB_Detail29_b; LB_Detail30_b)
	C_BOOLEAN:C305(LB_Detail31_b; LB_Detail32_b; LB_Detail33_b; LB_Detail34_b; LB_Detail35_b; LB_Detail36_b; LB_Detail37_b; LB_Detail38_b; LB_Detail39_b; LB_Detail40_b)
	
	
	C_LONGINT:C283(LB_SortDirection1_l; LB_SortDirection2_l; LB_SortDirection3_l; LB_SortDirection4_l; LB_SortDirection5_l; LB_SortDirection6_l; LB_SortDirection7_l; LB_SortDirection8_l; LB_SortDirection9_l; LB_SortDirection10_l)
	C_LONGINT:C283(LB_SortDirection11_l; LB_SortDirection12_l; LB_SortDirection13_l; LB_SortDirection14_l; LB_SortDirection15_l; LB_SortDirection16_l; LB_SortDirection17_l; LB_SortDirection18_l; LB_SortDirection19_l; LB_SortDirection20_l)
	C_LONGINT:C283(LB_SortDirection21_l; LB_SortDirection22_l; LB_SortDirection23_l; LB_SortDirection24_l; LB_SortDirection25_l; LB_SortDirection26_l; LB_SortDirection27_l; LB_SortDirection28_l; LB_SortDirection29_l; LB_SortDirection30_l)
	C_LONGINT:C283(LB_SortDirection31_l; LB_SortDirection32_l; LB_SortDirection33_l; LB_SortDirection34_l; LB_SortDirection35_l; LB_SortDirection36_l; LB_SortDirection37_l; LB_SortDirection38_l; LB_SortDirection39_l; LB_SortDirection40_l)
	C_TEXT:C284(ColumnWidths_txt; NamedSelection_txt)
	C_LONGINT:C283(LB_RowStyle_l)
	C_LONGINT:C283(LB_Reports)
	C_TEXT:C284(ButtonpopupText)
	
	//From LB_ProcessINSPQuery1 which is a demo one and not in use
	
	C_TEXT:C284(TeamLeaderName_txt; LBRowNumber_txt)
	C_TEXT:C284(SecondTeamLdrName_txt)
	C_LONGINT:C283(TeamLdr2HeaderVar_L; RecIDHeaderVar_L; dateHeaderVar_L; descHeaderVar_L; BINHeaderVar_L; bdeptHeaderVar_L; TeamLdrHeaderVar_L; RowNoHeaderVar_L; TypeHeaderVar_L; RevHeaderVar_L; ComplHeaderVar_L; ApprHeaderVar_L)
	C_LONGINT:C283(LB_SortDirection_l; RevPicHeaderVar_L; ApprPicHeaderVar_L)
	C_PICTURE:C286(INSPLB_pict_Rev_p; INSPLB_pict_app_p)
	
	//LIST BOXES USED ON
	//[Bridge MHD NBIS];"BRIDGE INPUT"
	C_LONGINT:C283(ConsutantInspections; ConsutantRatings; RatingReports; Secondary; Inspections; InventoryPhotos; LBRow_L)
	C_BOOLEAN:C305(InDoubleClick_B)
	If (False:C215)
		//LB_PROCESSINSPQUERY1
		C_LONGINT:C283(LB_ProcessINSPQuery1; $0)
		
		//LB_PROCESSINSPQUERY2
		C_LONGINT:C283(LB_ProcessINSPQuery2; $0)
		
		//LB_CONTROLLISTBOXDISPLAY
		C_TEXT:C284(LB_ControlListBoxDisplay; $1)
		C_LONGINT:C283(LB_ControlListBoxDisplay; $2)
		C_TEXT:C284(LB_ControlListBoxDisplay; $3)
		C_TEXT:C284(LB_ControlListBoxDisplay; $4)
		
		//LB_PROCESSELEMSFTYQUERY1
		C_LONGINT:C283(LB_ProcessElemSftyQuery1; $0)
		
		//LB_PROCESSSTANDARDPHOTOSQUERY
		C_LONGINT:C283(LB_ProcessStandardPhotosQuery; $0)
		
		//LB_PROCESSCONDUNITSQUERY
		C_LONGINT:C283(LB_ProcessCondUnitsQuery; $0)
		
		//LB_SETUPVARIABLECOLUMN
		C_LONGINT:C283(LB_SetUPVariableColumn; $1)
		C_POINTER:C301(LB_SetUPVariableColumn; $2)
		C_POINTER:C301(LB_SetUPVariableColumn; $3)
		C_POINTER:C301(LB_SetUPVariableColumn; $4)
		C_POINTER:C301(LB_SetUPVariableColumn; $5)
		C_TEXT:C284(LB_SetUPVariableColumn; $6)
		
		//LB_SETUPFIELDCOLUMN
		C_LONGINT:C283(LB_SetUPFieldColumn; $1)
		C_POINTER:C301(LB_SetUPFieldColumn; $2)
		C_POINTER:C301(LB_SetUPFieldColumn; $3)
		C_POINTER:C301(LB_SetUPFieldColumn; $4)
		
		//LB_ELEMTSFTSTDREPORT
		C_BOOLEAN:C305(LB_ElemtSftStdReport; $1)
		
		
		C_LONGINT:C283(LB_ResizeWindow; $1)
		C_TEXT:C284(LB_ResizeWindow; $2)
		
		C_LONGINT:C283(LB_ProcessNBEQuery; $0)
		
		C_LONGINT:C283(LB_CSLT_Rating; $0)
		C_LONGINT:C283(LB_CSLT_Inspection; $0)
		C_LONGINT:C283(LB_ListContracts; $0)
		C_LONGINT:C283(LB_ContractMaintenance; $0)
		C_LONGINT:C283(LB_ConsAddressMatch; $0)
		
		C_LONGINT:C283(LB_BridgeProgramSort; $0)
		
		C_LONGINT:C283(LB_ProjectDetailSort; $0)
		C_LONGINT:C283(LB_DesignContractSort; $0)
		
		C_TEXT:C284(LB_ResetHeaders; $1)
		
	End if 
	
End if 
ARRAY TEXT:C222(arrColNames; 0)
ARRAY TEXT:C222(arrHeaderNames; 0)
ARRAY POINTER:C280(arrColVars; 0)
ARRAY POINTER:C280(arrHeaderVars; 0)
ARRAY BOOLEAN:C223(arrColsVisible; 0)
ARRAY POINTER:C280(arrStyles; 0)
ARRAY LONGINT:C221(LB_StyleArray_al; 0)
ARRAY TEXT:C222(ButtonPopupButtonlabels_atxt; 0)
ARRAY TEXT:C222(ButtonPopupCommands_atxt; 0)

//For special 1 column list box created and used in saving and loading user log in info
ARRAY TEXT:C222(LBGeneric_atxt; 0)
ARRAY BOOLEAN:C223(LBGeneric_ab; 0)



//End Compiler_LB