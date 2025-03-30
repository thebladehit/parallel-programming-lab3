-- ПЗВКС
-- Lab 2 (Програмування для комп’ютерних систем зі спільною пам’яттю)
-- R = max(Z)*(B*MV) + e*X*(MM*MC)
-- MV, MC - 1 thread
-- MM, R - 2 thread
-- B,X, e, Z - 4 thread
-- Ярмолка Богдан Ігорович
-- ІМ-22
-- 30.03.2025

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Data;

package body Data is
   procedure printNewLineInConsole is
   begin
      New_Line;
   end printNewLineInConsole;

   procedure printTextInConsole(text: String) is
   begin
      Put(text);
   end printTextInConsole;

   procedure printVectorInConsole(V: Vector) is
   begin
      for i in 1..N loop
         Put(Item => Integer'Image(V(i)));
      end loop;
   end printVectorInConsole;

   procedure fillVectorByNums(V: in out Vector; num: Integer) is
   begin
      for i in 1..N loop
         V(i) := num;
      end loop;
   end fillVectorByNums;

   procedure fillMatrixByNums(M: in out Matrix; num: Integer) is
   begin
      for i in 1..N loop
         for j in 1..N loop
            M(i, j) := num;
         end loop;
      end loop;
   end fillMatrixByNums;

   procedure calculateExpressionPart(aThread: Integer; eThread: Integer; threadNum: Integer) is
      MMMC: Matrix;
      eX: Vector;
      eXMMMC: Vector;
      BMV: Vector;
      aBMV: Vector;
   begin
      MMMC := multiplyMatrices(MM, MC, threadNum);
      eX := multiplyVectorOnScalar(X, eThread, threadNum);
      eXMMMC := multiplyVectorOnMatrix(eX, MMMC, threadNum);
      BMV := multiplyVectorOnMatrix(B, MV, threadNum);
      aBMV := multiplyVectorOnScalar(BMV, aThread, threadNum);
      sumVectors(aBMV, eXMMMC, R, threadNum);
   end calculateExpressionPart;

   procedure sumVectors(firstV: Vector; secondV: Vector; resV: in out Vector; threadNum: Integer) is
      startPos: Integer := threadNum * H + 1;
      endPos: Integer := threadNum * H + H;
   begin
      for i in startPos..endPos loop
         resV(i) := firstV(i) + secondV(i);
      end loop;
   end sumVectors;

   function multiplyMatrices(firstM: Matrix; secondM: Matrix; threadNum: Integer) return Matrix is
      startPos: Integer := threadNum * H + 1;
      endPos: Integer := threadNum * H + H;
      resM: Matrix;
   begin
      for i in 1..N loop
         for j in startPos..endPos loop
            resM(i, j) := 0;
            for k in 1..N loop
               resM(i, j) := resM(i, j) + firstM(i, k) * secondM(k, j);
            end loop;
         end loop;
      end loop;
      return resM;
   end multiplyMatrices;

   function multiplyVectorOnScalar(V: Vector; scalar: Integer; threadNum: Integer) return Vector is
      resV: Vector;
      startPos: Integer := threadNum * H + 1;
      endPos: Integer := threadNum * H + H;
   begin
      for i in startPos..endPos loop
         resV(i) := V(i) * scalar;
      end loop; 
      return resV;
   end multiplyVectorOnScalar;

   function multiplyVectorOnMatrix(V: Vector; M: Matrix; threadNum: Integer) return Vector is
      resV: Vector;
      startPos: Integer := threadNum * H + 1;
      endPos: Integer := threadNum * H + H;
   begin
      for i in startPos..endPos loop
         resV(i) := 0;
         for j in 1..N loop
            resV(i) := resV(i) + V(j) * M(j, i);
         end loop;
      end loop;
      return resV;
   end multiplyVectorOnMatrix;

   function findMaxFromVector(V: Vector; threadNum: Integer) return Integer is
      startPos: Integer := threadNum * H + 1;
      endPos: Integer := threadNum * H + H;
      localMax: Integer := V(startPos);
   begin
      for i in (startPos + 1)..endPos loop
         if V(i) > localMax then
            localMax := V(i);
         end if;
      end loop;
      return localMax;
   end findMaxFromVector;
end Data;