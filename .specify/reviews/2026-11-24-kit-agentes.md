Status: APPROVED

# Revisão: kit de agentes (AGENTS.md, CLAUDE.md, revisor, .specify/reviews)

- Mudança: commit `c431e3b` no branch `claude/kit-agentes`.
- Revisor: subagente `Plan` (sem ferramentas de edição), `model: opus`, `effort: high`, separado do agente que
  escreveu. Conferiu o diff, `host-hero.yml` (só `workflow_dispatch`, `contents: read`, SHA-256 e JPEG), o script
  (rodou, saída 0), o README e o HTML (314 linhas, tabelas `role="presentation"`, imagens com URL https, `alt` e
  `width`, `{{unsubscribe}}`). Nada privado exposto.

## Achados (todos nit)

1. `revisor.md`: citava banco de teste que este repositório não tem. Corrigido no modelo do revisor.
2. `revisor.md`: mandava seguir "o guia citado" no AGENTS.md, que não cita guia. Corrigido ("se ele citar um guia").
3. `AGENTS.md`: não dizia quem grava o veredito nem se ele conta no limite de 2 arquivos. Corrigido.
4. `AGENTS.md`: a descrição do script de checagem é correta, mas incompleta (também falha sem `uses:` e com o host em
   qualquer lugar do repositório). Aceito como está.
