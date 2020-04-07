
with Ada.Streams.Stream_IO;

with Magic.Stream_Element_Buffers;
with Magic.Strings.Conversions;
with Magic.Text_Streams.Memory;
with Magic.JSON.Streams.Writers;

procedure Test_JSON_Writer is
   Stream  : aliased Magic.Text_Streams.Memory.Memory_UTF8_Output_Stream;
   Writer  : aliased Magic.JSON.Streams.Writers.JSON_Simple_Writer;
   File    : Ada.Streams.Stream_IO.File_Type;
   Success : Boolean := True;

begin
   Writer.Set_Stream (Stream'Unchecked_Access);
   Writer.Start_Document (Success);

   Writer.Start_Object (Success);

   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("name"), Success);
   Writer.String_Value
     (Magic.Strings.Conversions.To_Magic_String ("Some name"), Success);
   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("names"), Success);
   Writer.Start_Array (Success);
   Writer.String_Value
     (Magic.Strings.Conversions.To_Magic_String ("Some"), Success);
   Writer.String_Value
     (Magic.Strings.Conversions.To_Magic_String ("name"), Success);
   Writer.End_Array (Success);
   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("is"), Success);
   Writer.Boolean_Value (False, Success);
   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("no"), Success);
   Writer.Boolean_Value (True, Success);
   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("empty"), Success);
   Writer.Null_Value (Success);
   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("integer"), Success);
   Writer.Integer_Value (15, Success);
   Writer.Key_Name
     (Magic.Strings.Conversions.To_Magic_String ("float"), Success);
   Writer.Float_Value (20.5, Success);

   writer.End_Object (Success);

   Writer.End_Document (Success);

   Ada.Streams.Stream_IO.Create
     (File, Ada.Streams.Stream_IO.Out_File, "json.json");
   Magic.Stream_Element_Buffers.Stream_Element_Buffer'Write
     (Ada.Streams.Stream_IO.Stream (File), Stream.Buffer);
   Ada.Streams.Stream_IO.Close (File);
end Test_JSON_Writer;