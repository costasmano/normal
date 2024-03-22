//%attributes = {"invisible":true}
If (False:C215)
	//preocedure: P_OutofFreqRep
	// Modified by: costasmanousakis-(Designer)-(10/26/2005 11:59:26)
	Mods_2005_CM18
	Mods_2022_05  //Changed code to use Listboxes when available 
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255//What is the main window title?
C_POINTER:C301(pFile)  //The file that is current
C_TEXT:C284(DefInLay)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(DefOutLay)  // Command Replaced was o_C_STRING length was 255

C_LONGINT:C283(D1_month; D2_month; D3_month; D4_month; D5_month; Dive_month)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(MBTA_month; MDC_month; MTA_month; MPA_month; DEM_month; DNR_month)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(S_reqd; S_made; S_month; S_1ytd; S_2ytd; S_3ytd)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(A_reqd; A_made; A_month; A_1ytd; A_2ytd; A_3ytd)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(total_reqd; total_made; total_month; total_1ytd; total_2ytd; total_3ytd)  //Command Replaced was o_C_INTEGER

pFile:=->[Out of Freq:70]
DefInLay:="I_OutofFreq"  //Default input layout
DefOutLay:="O_OutofFreq"  //Default output layout
If (ut_UseListBox(Current method name:C684))
	DefOutLay:=DefOutLay+"_LB"
End if 
MainTitle:="Out of Frequency"
GModSelection(->[Out of Freq:70]; DefInLay; DefOutLay; MainTitle; 620; 450; 1; Plain window:K34:13; 3; ->[Out of Freq:70]Date_Created:1; "<")