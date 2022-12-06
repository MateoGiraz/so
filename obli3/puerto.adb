with Ada.Text_IO; use ADA.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line;
with Ada.Strings;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;



procedure Puerto is
   Seed : Generator;
   Cant_En_Puerto : Integer := 5;
   Cant_Barcos : Integer := 10;
   
   package counter is
      function get_next return integer;
   private
      data: integer := 1;
   end counter;
   package body counter is
      function get_next return integer is
         return_val : integer;
      begin
         return_val := data;
         data := data + 1;
      return return_val;
      end get_next;
   end counter;
   
   Task Grua is
      Entry descarga;
      Entry salirDescarga;
      Entry lugar_siguiente(N : OUT Integer);
      Entry lugar_anterior(N : OUT Integer);
      Entry ocupado(N : OUT Integer);
   end Grua;
   
   Task body Grua is
      cant_barcos_grua: Integer := 0;
      grua_sig : Integer := 1;
      grua_ant : Integer := 0;
   begin
      loop
         select
            when cant_barcos_grua < 2 => accept descarga;
               cant_barcos_grua := cant_barcos_grua + 1;
         or
            accept salirDescarga;
            cant_barcos_grua := cant_barcos_grua - 1;
         or
            accept ocupado(N : OUT Integer) do
               N := cant_barcos_grua;
            end ocupado;
         or
            accept lugar_siguiente(N : OUT Integer) do
               if grua_ant = 1 then
                  N := 2;
                  grua_ant:=2;
               else if grua_ant = 2 then
                     N := 1;
                     grua_ant:=1;
                  else
                     grua_ant:=1;
                     grua_sig:=2;
                     N:=1;
                  end if;
               end if;
            end lugar_siguiente;
         or
            accept lugar_anterior(N : OUT Integer) do
               N := grua_ant;
            end lugar_anterior;
         or
            terminate;
         end select;
      end loop;
   end Grua;
   
    Task Atracadero is
      Entry entraAtracadero;
      Entry saleAtracadero;
      Entry lugar_siguiente(N : OUT Integer);
      Entry lugar_anterior(N : OUT Integer);
      Entry ocupado(N : OUT Integer);
   end Atracadero;
   
   Task body Atracadero is
      cant_barcos_atracadero: Integer := 0;
      lugar_sig : Integer := 1;
      lugar_ant : Integer := 0;
   begin
      loop
         select
            when cant_barcos_atracadero < 2 => accept entraAtracadero;
               cant_barcos_atracadero := cant_barcos_atracadero + 1;
         or
            accept saleAtracadero;
            cant_barcos_atracadero := cant_barcos_atracadero - 1;
         or
            accept ocupado(N : OUT Integer) do
               N := cant_barcos_atracadero;
            end ocupado;
         or
            accept lugar_siguiente(N : OUT Integer) do
               if lugar_ant = 1 then
                  N := 2;
                  lugar_ant:=2;
               else if lugar_ant = 2 then
                     N := 1;
                     lugar_ant:=1;
                  else
                     lugar_ant:=1;
                     lugar_sig:=2;
                     N:=1;
                  end if;
               end if;
            end lugar_siguiente;
         or
            accept lugar_anterior (N : out Integer) do
               N:= lugar_ant;
            end lugar_anterior;
         end select;
      end loop;
   end Atracadero;
   
   
   Task Puerto2 is
      Entry entrar(barcoin: in integer);
      Entry salir;
   end;
   
   Task body Puerto2 is
      en_el_puerto:Integer :=0;
      mibarcoin:Integer;
   begin
      loop
         select
            when en_el_puerto < Cant_En_Puerto => accept entrar(barcoin: in integer) do
                  mibarcoin := barcoin;
                  en_el_puerto := en_el_puerto + 1;
               end entrar;
         or
            accept salir do
               en_el_puerto := en_el_puerto - 1;
            end salir;
         or
            terminate;
         end select;
      end loop;   
   end PUerto2;
   
   task type Barco (numero: integer := counter.get_next);
   task body Barco is
      adentro : Integer;
      fin : Boolean;
      siguiente_grua: Integer;
      siguiente_atracadero : Integer;
   begin
      fin := False;
      Puerto2.entrar(numero);
      Put_Line("Barco " & numero'Image & " accede al puerto");
      delay Duration (Random (Seed) * 10.0);
      while fin /= True loop
         Grua.ocupado(adentro);
         if adentro < 2 then
            Grua.descarga;
            Grua.ocupado(adentro);
            Grua.lugar_siguiente(siguiente_grua);
            Put_Line("Barco " & numero'Image & " accede a descargar a la grua" & siguiente_grua'Image);
            delay Duration (Random (Seed) * 10.0);
            Put_Line("Barco " & numero'Image & " se retira de la grua" & siguiente_grua'Image);
            Grua.salirDescarga;
            Puerto2.salir;
            Put_Line("Barco " & numero'Image & " se retira del puerto ");
            fin := True;
         else
            Atracadero.ocupado(adentro);
            if adentro < 2 then
               Atracadero.entraAtracadero;
               Atracadero.ocupado(adentro);
               Atracadero.lugar_siguiente(siguiente_atracadero);
               Put_Line("Barco " & numero'Image & " accede al atracadero" & siguiente_atracadero'Image);
               delay Duration (Random (Seed) * 10.0);
               Grua.ocupado(adentro);
               while adentro >= 2 loop
                  Grua.ocupado(adentro);
               end loop;
               Atracadero.saleAtracadero;
               Put_Line("Barco " & numero'Image & " se retira del atracadero" & siguiente_atracadero'Image);
            end if;
         end if;
      end loop;
   end Barco;
   
   type ListaBarcos is array (Integer range <>) of Barco;
   
   MisBarcos : ListaBarcos(1 .. Cant_Barcos);
   
begin
   delay 3.0;
   null;
end Puerto;
