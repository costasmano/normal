//SC vDtTmPg

C_TEXT:C284(vDtTmPg)
C_LONGINT:C283(vCurrPage)  //Command Replaced was o_C_INTEGER
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
//vDtTmPg:="Page "+String(vCurrPage)+" of "+String(vRptPages)+◊sCR
vDtTmPg:="Page "+String:C10(vCurrPage)+<>sCR
vDtTmPg:=vDtTmPg+String:C10(vRptDate)+<>sCR
vDtTmPg:=vDtTmPg+String:C10(vRptTime; 5)