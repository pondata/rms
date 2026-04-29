# Manual setup steps that the swarm can't perform

## Synthetic form-pipeline monitor (GitHub Actions)

The OAuth-app token used by the swarm cannot create files under `.github/workflows/`
(GitHub blocks it without the `workflow` scope). Justin needs to add this manually:

1. Go to https://github.com/pondata/rms — Actions tab → "set up a workflow yourself"
2. Name the file `form-pipeline-monitor.yml`
3. Paste the contents of `form-pipeline-monitor.yml.txt` (in this directory)
4. Commit directly to master

Once committed, the workflow runs daily at 09:00 UTC and emails Justin if the
public Apps Script form endpoint returns non-2xx. This is the bridge until the
form pipeline is moved behind a Cloudflare Worker or Formspree.
