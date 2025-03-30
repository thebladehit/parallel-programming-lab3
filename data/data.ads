-- ПЗВКС
-- Lab 3 (Програмування для комп’ютерних систем зі спільною пам’яттю)
-- R = max(Z)*(B*MV) + e*X*(MM*MC)
-- MV, MC - 1 thread
-- MM, R - 2 thread
-- B,X, e, Z - 4 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 30.03.2025

with Ada.Synchronous_Task_Control;
use Ada.Synchronous_Task_Control;
with Ada.Task_Attributes;

package Data is
   N: Integer := 4;
   P: Integer := 4;
   H: Integer := N / P;

   type Vector is array (1..N) of Integer;
   type Matrix is array (1..N, 1..N) of Integer;

   a, e: Integer;
   R, B, X, Z: Vector;
   MV, MC, MM: Matrix;
   
   procedure printNewLineInConsole;
   procedure printTextInConsole(text: String);
   procedure printVectorInConsole(V: Vector);
   procedure fillVectorByNums(V: in out Vector; num: Integer);
   procedure fillMatrixByNums(M: in out Matrix; num: Integer);
   procedure calculateExpressionPart(aThread: Integer; eThread: Integer; threadNum: Integer);
   procedure sumVectors(firstV: Vector; secondV: Vector; resV: in out Vector; threadNum: Integer);
   function multiplyMatrices(firstM: Matrix; secondM: Matrix; threadNum: Integer) return Matrix;
   function multiplyVectorOnScalar(V: Vector; scalar: Integer; threadNum: Integer) return Vector;
   function multiplyVectorOnMatrix(V: Vector; M: Matrix; threadNum: Integer) return Vector;
   function findMaxFromVector(V: Vector; threadNum: Integer) return Integer;
end Data;