USE [training]
GO
/****** Object:  StoredProcedure [dbo].[GetEmpDetails]    Script Date: 9/5/2022 4:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetEmpDetails](@EMPID INT)
as
begin
select * from emp where EMPNO = @EMPID
end
