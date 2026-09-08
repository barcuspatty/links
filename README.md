# links

Source for [barcuspatty.github.io/links](https://barcuspatty.github.io/links/) — a single-page link hub, built as static HTML and deployed to GitHub Pages.

## How it works

`config.yml` is the whole site. A Ruby script (`scaffold.rb`) renders it through a Liquid template in `themes/<theme>/` and writes the result to `_output/`. GitHub Actions runs the build on every push to `main` (plus a daily cron) and force-pushes `_output/` to the `gh-pages` branch.

## Editing

| What | Where |
| --- | --- |
| Name, photo, bio, location | `config.yml` (profile header) |
| Link rows and social icons | `config.yml` (`links:`, `socials:`) |
| Footer and copyright | `config.yml` (`footer:`, `copyright:`) |
| Look and layout | `themes/newsprint/{index.html,styles.css}` |
| Profile photo and favicons | `themes/newsprint/images/` |
| Build-time data fetching | `plugins/` (see `plugins/README.md`) |

Push to `main` and wait for the Actions run to finish. `config.yml` is parsed by Ruby's YAML library, so an indentation mistake fails the build rather than shipping a broken page.

## Local preview

```
bundle install     # once
./preview.sh       # builds and serves on http://localhost:8080, rebuilds on save
```

## License

MIT. See [LICENSE](./LICENSE).
