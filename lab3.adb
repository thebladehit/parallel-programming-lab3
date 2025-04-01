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
procedure Lab3 is 
   task T1;
   task T2;
   task T3;
   task T4;

   task body T1 is
      a1, e1: Integer;
   begin
      printTextInConsole("T1 started");
      printNewLineInConsole;

      -- Input
      fillMatrixByNums(MV, 1);
      fillMatrixByNums(MC, 1);

      -- Signal to other threads about the end of input data
      Management.signal_input;

      -- Wait for others input
      Management.wait_input;

      -- Find max(Z)
      a1 := findMaxFromVector(Z, 0);
      Management.input_a(a1);

      -- Signal other about the end of the calculation a
      Management.signal_calc_a;

      -- Wait for other calculation a
      Management.wait_calc_a;

      -- Copy a and e
      a1 := Management.copy_a;
      e1 := Management.copy_e;

      -- Calculation
      calculateExpressionPart(a1, e1, 0);

      -- Notify T2 about the end of calculation
      Management.signal_calc_end;

      printTextInConsole("T1 finished");
   exception
      when E: others => 
         Put_Line("Помилка в потоці1: " & Exception_Information(E));
   end T1;

   task body T2 is
      a2, e2: Integer;
   begin
      printTextInConsole("T2 started");
      printNewLineInConsole;

      -- Input
      fillMatrixByNums(MM, 1);

      -- Signal to other threads about the end of input data
      Management.signal_input;

      -- Wait for others input
      Management.wait_input;

      -- Find max(Z)
      a2 := findMaxFromVector(Z, 1);
      Management.input_a(a2);

      -- Signal other about the end of the calculation a
      Management.signal_calc_a;

      -- Wait for other calculation a
      Management.wait_calc_a;

      -- Copy a and e
      a2 := Management.copy_a;
      e2 := Management.copy_e;

      -- Calculation
      calculateExpressionPart(a2, e2, 1);

      -- Wait for other calulation R
      Management.wait_calc_end;

      -- Print output
      printNewLineInConsole;
      printVectorInConsole(R);

      printNewLineInConsole;
      printTextInConsole("T2 finished");
   end T2;

   task body T3 is
      a3, e3: Integer;
   begin
      printTextInConsole("T3 started");
      printNewLineInConsole;

      -- Wait for others input
      Management.wait_input;

      -- Find max(Z)
      a3 := findMaxFromVector(Z, 2);
      Management.input_a(a3);

      -- Signal other about the end of the calculation a
      Management.signal_calc_a;

      -- Wait for other calculation a
      Management.wait_calc_a;

      -- Copy a and e
      a3 := Management.copy_a;
      e3 := Management.copy_e;

      -- Calculation
      calculateExpressionPart(a3, e3, 2);

      -- Notify T2 about the end of calculation
      Management.signal_calc_end;

      printTextInConsole("T3 finished");
   end T3;

   task body T4 is
      a4, e4: Integer;
   begin
      printTextInConsole("T4 started");
      printNewLineInConsole;

      -- Input
      fillVectorByNums(B, 1);
      fillVectorByNums(X, 1);
      fillVectorByNums(Z, 1);
      Management.input_e(1);

      -- Signal to other threads about the end of input data
      Management.signal_input;

      -- Wait for others input
      Management.wait_input;

      -- Find max(Z)
      a4 := findMaxFromVector(Z, 3);
      Management.input_a(a4);

      -- Signal other about the end of the calculation a
      Management.signal_calc_a;

      -- Wait for other calculation a
      Management.wait_calc_a;

      -- Copy a and e
      a4 := Management.copy_a;
      e4 := Management.copy_e;

      -- Calculation
      calculateExpressionPart(a4, e4, 3);

      -- Notify T2 about the end of calculation
      Management.signal_calc_end;

      printTextInConsole("T4 finished");
   end T4;
begin
   printTextInConsole("Main thread started");
end Lab3;