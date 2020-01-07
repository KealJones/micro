# Getting Started
1. Pull down all these repos:
    - https://github.com/kealjones-wk/ss_experience
    - https://github.com/kealjones-wk/docs_experience
    - https://github.com/kealjones-wk/shell_events
    - https://github.com/kealjones-wk/shell

2. Within `docs_experience` and `ss_experience` run `pbr build -o ./latest -r`.

3. Symlink the build output of each into a fake `cdn` directory, something like this:
    - `ln -s $PATH_TO_EXPERIENCES/doc_experience/latest/web/index.dart.js $PATH_TO_FAKE_CDN_DIR/docs-experience/latest/index.dart.js`

4. From this repo, `shell`, run `webdev serve` and open http://127.0.0.1:8080