function CalcularConsumoPrimer(
         FornecedorProdutoQuimico: Integer;
         GramaturaInterna: Currency;
         GramaturaExterna: Currency;
         ComprimentoItem: Currency;
         LarguraItem: Currency;
         UnidMedidaItem: String;
         PintarParteInterna: Boolean;
         PintarParteExterna: Boolean): Currency;
var Divisor: Currency;         
begin
  case FornecedorProdutoQuimico of
   1: // Rochesa
     begin
      GramaturaInterna := GramaturaInterna * 0.9;
      GramaturaExterna := GramaturaExterna * 0.8;
     end;
   2: // quimpil
     begin
      GramaturaInterna := GramaturaInterna * 0.8;
      GramaturaExterna := GramaturaExterna * 0.7;     
     end;
   end;  
  
  // Para converter para M
  if (UnidMedidaItem = 'M')  then Divisor := 1   else
  if (UnidMedidaItem = 'CM') then Divisor := 100 else 
                             {MM} Divisor := 1000;  
                                
  Result := 0;
  
  if PintarParteInterna then
    Result := Result + (((ComprimentoItem/Divisor) * (LarguraItem/Divisor)) * GramaturaInterna);
    
  if PintarParteExterna then
    Result := Result + (((ComprimentoItem/Divisor) * (LarguraItem/Divisor)) * GramaturaExterna);
    
  // Se a matéria prima (primer) estiver em KG, deverá converter de grama para kilograma
  Result := Result / 1000;
end;

procedure Main;
begin
  ShowMessage('Resultado do primeiro teste => ' + FormatCurr('#0.00##', CalcularConsumoPrimer(1, 0.15, 0.16, 80, 60, 'CM', False, True)));
end;
