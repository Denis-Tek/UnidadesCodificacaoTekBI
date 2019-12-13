procedure Main;
var taxa: Float;
begin
  taxa := StrToFloat(InputBox('Informe a taxa anual', 'taxa', '3,15'));
  ShowMessage('A taxa mensal deve ser ' + FloatToStr(ConverteTaxaAnualSimplesEmMensalComposta(taxa)));
end;

function ConverteTaxaAnualSimplesEmMensalComposta(TaxaAnual: Float): Float;
begin
  Result := (Power(1 + (TaxaAnual / 100), (1/12)) - 1) * 100;
end;

{
Convertendo Taxa de Juros Simples em Taxa de Juros Composto:

Juros Simples: Ms = C (1 + is * ns)
  Ms => Montante com juros simples
  is  => taxa de juros simples
  ns => tempo em juros simples

Juros Compostos: Mc = C (1 + ic) ^ nc
  Mc => Montante com juros compostos
  ic   => taxa de juros compostos
  nc  => tempo em juros compostos

Quero ter o mesmo resultado, portando igualo dois resultados: Mc = Ms

C (1 + ic) ^ nc = C (1 + is * ns)
   (1 + ic) ^ nc =    (1 + is * ns)
   (1 + ic)         =    (1 + is * ns) ^ (1/nc)
        ic          =    (1 + is * ns) ^ (1/nc) - 1          <<<< Esta é a fórmula encontrada

ex: Poupança anual é 3,15% quanto será a taxa mensal?

ic = (1 + 3,15% * 1) ^ (1 / 12) - 1
ic = (1 + 3,15%) ^ (1 / 12) - 1
ic = 1,0315 ^ (1/12) - 1
ic = 0,25878471715479531044772001853449 %

Tirando a prova: Aplicar R$ 100,00 na poupança à taxa de 3,15% a.a por um ano.
Ms = 100 * (1 + 3,15% * 1)
Ms = 103,15

Deve dar o mesmo resultado utilizando a fórmula de juros compostos com a taxa mensal encontrada. Lembrando que o tempo agora será 12 meses.
Mc = 100 * (1 + 0,2587%) ^ 12
Mc = 100 * (1,002587) ^ 12
Mc = 103,15

c.q.d. Denis Pereira Raymundo 
}

{Pode-se utilizar também o site:
 https://fazaconta.com/taxa-mensal-vs-anual.htm  
 Conversão de Taxa Anual para Mensal => = POTÊNCIA(1 + i%; 1/12) - 1
}
