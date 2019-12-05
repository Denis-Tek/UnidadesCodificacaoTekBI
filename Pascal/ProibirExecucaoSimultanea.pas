// Solução utilizando recurso de variáveis de contexto do Firebird.
// Nota: O limite para a qtde de variáveis de contexto por conexão é 1000
//       https://firebirdsql.org/refdocs/langrefupd20-set-context.html  
 
unit ProibirExecucaoSimultanea;
 
const ChaveControleSimultaneidade = 'Processamento XYZ';
 
procedure Main;
begin
  TentarExecucaoUnica;
  try
  
    // Execução do processamento que não pode ser executado simultaneamente por mais de um usuário
    Sleep(1000 * 15);
  
  finally
    // SetVariavelContexto(ChaveControleSimultaneidade, '');
    DeleteVariavelContexto(ChaveControleSimultaneidade);
  end;
end;
 
procedure TentarExecucaoUnica;
var InfoBloqueio: String;
begin
  // Não foi utilizada a função RDB$GET_CONTEXT() descrita em https://firebirdsql.org/refdocs/langrefupd20-get-context.html porque era necessário ter acesso a variáveis de todos os usuários.
  InfoBloqueio := ExecuteScalar(
    ' select MON$VARIABLE_VALUE "Valor"' + #13 +  
    ' from MON$CONTEXT_VARIABLES ' + #13 +
    ' where MON$VARIABLE_NAME = ' + QuotedStr(ChaveControleSimultaneidade) + #13 +
    '   and MON$VARIABLE_VALUE <> ' + QuotedStr(''));    
      
  if (Trim(InfoBloqueio) <> '') then      
    raise Exception.Create(MensagemPersonalizada + ChaveControleSimultaneidade + ' já iniciado por ' + InfoBloqueio + '.' + #13 + 'Aguarde que ele(a) conclua!');
 
  SetVariavelContexto(ChaveControleSimultaneidade,
    Nome_Usuario_Atual + ' às ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraServidor));
end;
    
end.
