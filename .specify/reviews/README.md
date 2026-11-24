# Vereditos de revisão

Mudança acima de 2 arquivos grava aqui o veredito do revisor separado (subagente `revisor`, ou `Plan` com opus e
esforço alto) antes de qualquer "revisado" no chat, no PR ou no commit. Regra: `AGENTS.md`, "Fluxo de trabalho".

- Nome: `AAAA-MM-DD-<slug>.md` (um arquivo por mudança; rodadas seguintes no mesmo arquivo).
- Primeira linha: `Status: APPROVED | CHANGES_REQUESTED | REJECT`.
- Depois: o que foi revisado (diff, commit), quem revisou (tipo de agente, modelo, esforço), os achados
  (`arquivo:linha` e cenário de falha) e, na rodada seguinte, o que foi corrigido.
- Repositório público: nada de dados privados no veredito.
