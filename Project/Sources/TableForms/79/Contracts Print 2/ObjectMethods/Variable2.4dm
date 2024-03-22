//SC vDtTmPg

C_TEXT:C284(vDtTmPg)

//vDtTmPg:="Page "+String(vCurrPage)+" of "+String(vRptPages)+◊sCR
//vDtTmPg:="Page "+String(vCurrPage)+◊sCR
vDtTmPg:=""
vDtTmPg:=vDtTmPg+String:C10(vRptDate; 7)+<>sCR
vDtTmPg:=vDtTmPg+String:C10(vRptTime; 5)