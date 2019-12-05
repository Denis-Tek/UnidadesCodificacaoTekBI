procedure Main;
begin  
  if (not HorarioExpediente) then
    raise Exception.Create(MensagemPersonalizada + 'Não é permitido acessar o sistema fora do expediente.'#13#13'VÁ DESCANSAR!');
end;

function HorarioExpediente: Boolean;
var 
  Ctrl: TClassCntrlDiasUteis;
  DiaUtil: Boolean;
  Horario: String;
begin
  Ctrl := TClassCntrlDiasUteis.Create(0, 0);
  try
    DiaUtil := Ctrl.DiaUtil(HOJE);
  finally
    Ctrl.Free;
  end;
    
  Horario := FormatDateTime('hh:nn:ss', Now - Today);      

  Result := (DiaUtil) and
            ( ((Horario >= '07:15:00') and (Horario <= '11:13:00')) or
              ((Horario >= '13:00:00') and (Horario <= '17:50:00')) );
end;
