------------------------------------------------------------------------------
--                        M A G I C   R U N T I M E                         --
--                                                                          --
--                       Copyright (C) 2020, AdaCore                        --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

with VSS.Strings.Internals;

package body VSS.String_Vectors is

   use type VSS.Implementation.String_Vectors.String_Vector_Data_Access;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Virtual_String_Vector) is
   begin
      VSS.Implementation.String_Vectors.Reference (Self.Data);
   end Adjust;

   ------------
   -- Append --
   ------------

   procedure Append
     (Self : in out Virtual_String_Vector'Class;
      Item : VSS.Strings.Virtual_String'Class) is
   begin
      VSS.Implementation.String_Vectors.Append
        (Self.Data, VSS.Strings.Internals.Data_Access_Constant (Item).all);
   end Append;

   -------------
   -- Element --
   -------------

   function Element
     (Self  : Virtual_String_Vector'Class;
      Index : Positive) return VSS.Strings.Virtual_String is
   begin
      if Self.Data /= null and then Index <= Self.Data.Last then
         return
           VSS.Strings.Internals.To_Virtual_String (Self.Data.Data (Index));

      else
         return VSS.Strings.Empty_Virtual_String;
      end if;
   end Element;

   -----------
   -- First --
   -----------

   overriding function First (Self : Reversible_Iterator) return Natural is
   begin
      return (if Self.Last > 0 then 1 else 0);
   end First;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Virtual_String_Vector) is
   begin
      VSS.Implementation.String_Vectors.Unreference (Self.Data);
   end Finalize;

   -------------
   -- Iterate --
   -------------

   function Iterate
     (Self : Virtual_String_Vector'Class) return Reversible_Iterator is
   begin
      return (Last => Self.Length);
   end Iterate;

   ----------
   -- Last --
   ----------

   overriding function Last (Self : Reversible_Iterator) return Natural is
   begin
      return Self.Last;
   end Last;

   ------------
   -- Length --
   ------------

   function Length (Self : Virtual_String_Vector'Class) return Natural is
   begin
      return (if Self.Data = null then 0 else Self.Data.Last);
   end Length;

   ----------
   -- Next --
   ----------

   overriding function Next
     (Self     : Reversible_Iterator;
      Position : Natural) return Natural is
   begin
      return (if Position < Self.Last then Position + 1 else 0);
   end Next;

   --------------
   -- Previous --
   --------------

   overriding function Previous
     (Self     : Reversible_Iterator;
      Position : Natural) return Natural is
   begin
      return (if Position > 0 then Position - 1 else 0);
   end Previous;

   ----------
   -- Read --
   ----------

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Self   : out Virtual_String_Vector) is
   begin
      raise Program_Error;
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Self   : Virtual_String_Vector) is
   begin
      raise Program_Error;
   end Write;

end VSS.String_Vectors;
