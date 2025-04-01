-- ПЗВКС
-- Lab 3 (Програмування для комп’ютерних систем зі спільною пам’яттю)
-- R = max(Z)*(B*MV) + e*X*(MM*MC)
-- MV, MC - 1 thread
-- MM, R - 2 thread
-- B,X, e, Z - 4 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 30.03.2025

with Data; use Data;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Real_Time;
use Ada.Real_Time;
procedure Lab3 is 
   task T1 is
      pragma Storage_Size(20_000_000);
   end T1;

   task body T1 is
   begin
      Start_Time := Clock;
      printTextInConsole("Main thread started");
      fillMatrixByNums(MV, 1);
      fillMatrixByNums(MC, 1);
      fillMatrixByNums(MM, 1);
      fillVectorByNums(B, 1);
      fillVectorByNums(X, 1);
      fillVectorByNums(Z, 1);
      e := 1;

      a := findMaxFromVector(Z, 0);
      calculateExpressionPart(a, e, 0);

      --  printNewLineInConsole;
      --  printVectorInConsole(R);

      printTextInConsole("Main thread finished");

      End_Time := Clock;
      Elapsed_Time := End_Time - Start_Time;

      printNewLineInConsole;
      printNewLineInConsole;
      Put_Line ("Execution time: " & Duration'Image(To_Duration(Elapsed_Time)) & " seconds");
   end T1;
begin
   null;
end Lab3;