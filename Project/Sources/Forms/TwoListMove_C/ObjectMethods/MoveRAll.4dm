//move all from left to right
Form:C1466.OmitC.combine(Form:C1466.UseC)
Form:C1466.OmitC:=Form:C1466.OmitC.orderBy(Form:C1466.orderbycriteria)
Form:C1466.UseC.resize(0)