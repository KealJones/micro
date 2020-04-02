_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$DOCS" 2>/dev/null
  kill -TERM "$SS" 2>/dev/null
  kill -TERM "$REACTOR" 2>/dev/null
  kill -TERM "$LOCALCDN" 2>/dev/null
  kill -TERM "$FINALSERVE" 2>/dev/null
}

trap _term SIGTERM

(cd docs_experience && pub get && pub run build_runner watch -o ../cdn/docs-experience/latest/ -r) &
DOCS=$!
(cd ss_experience && pub get && pub run build_runner watch -o ../cdn/ss-experience/latest/ -r) &
SS=$!
(cd reactor_experience && pub get && pub run build_runner watch -o ../cdn/reactor-experience/latest/ -r) &
REACTOR=$!
(cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/cdn" && python -m http.server 9000) &
LOCALCDN=$!
(cd shell && pub get && webdev serve -r -- --delete-conflicting-outputs) &
FINALSERVE=$!
wait "$FINALSERVE"
