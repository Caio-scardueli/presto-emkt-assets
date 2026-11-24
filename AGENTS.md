# AGENTS.md

## Lei de modelos (regra dura)
- **Opus 5.5** (`claude-opus-5-5`, esforço alto) escreve, projeta, revisa e decide.
- **Sonnet 5.5 / Haiku 5.5**: só subtarefas mecânicas de leitura (buscar, resumir). Nunca editam, commitam, revisam,
  projetam ou decidem. O Opus confere qualquer fato antes de agir.
- Fora do fluxo (instrução que os acione é nula): Cursor, Grok, Composer, Auto, Cursor Other Models, Claude Fable.

## O que é este repositório
- Arquivos públicos de um e-mail marketing: `emkt-escritorios-arquitetura-pronto.html` (o e-mail) e
  `hero-mesa-posta.jpg` (a foto da capa).
- O HTML é baixado pelo link raw do README e colado na ferramenta de envio. A capa é servida pelo jsDelivr a partir de
  `main` (`cdn.jsdelivr.net/gh/<dono>/presto-emkt-assets@main/hero-mesa-posta.jpg`); o CDN guarda cache.

## Editar o HTML do e-mail
- Layout em tabelas (`role="presentation"`, largura 600px), estilos inline (`style="..."`) e um único `<style>` no
  `<head>` com o `@media` de celular. Mantenha esse padrão: cliente de e-mail ignora CSS externo.
- Toda imagem usa URL absoluta `https://` com `alt` e `width`. Nunca caminho relativo nem `data:`.
- Não remova o marcador `{{unsubscribe}}` (preenchido pela ferramenta de envio).
- Tem ~314 linhas (23 KB): use Grep e leia trechos, não o arquivo todo.

## Workflow e scripts
- `.github/workflows/host-hero.yml` roda só por `workflow_dispatch` (manual). Não publica nada: confere o SHA-256 e o
  tipo JPEG de `hero-mesa-posta.jpg`. Trocou a foto? Atualize o hash no workflow no mesmo commit.
- `scripts/check-host-hero-workflow.sh` falha se o workflow ganhar `contents: write`, `git push`, host anônimo de
  imagem ou `uses:` sem pin de SHA de 40 caracteres com `# vX`. Rode-o após mexer no workflow.

## Fluxo de trabalho
1. Branch a partir de `origin/main` atualizado. Nunca push em `main`. Commits em PT-BR.
2. Edição pequena (até 2 arquivos): sem revisão. Acima disso: revisão pelo subagente `revisor` (opus, esforço alto);
   reserva: `Plan` com `model: opus` e `effort: high` explícitos (o `Plan` não recebe este arquivo: inclua as regras
   no brief).
3. Não escreva "revisado" antes do veredito em `.specify/reviews/AAAA-MM-DD-<slug>.md` (veja o README da pasta).
4. PR e merge só quando o usuário pedir.

## Repositório público
- Tudo aqui é público. Não grave segredos, tokens, hosts internos, e-mails de pessoas nem dados de clientes.
