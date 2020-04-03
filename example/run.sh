_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$DOCS" 2>/dev/null
  kill -TERM "$SS" 2>/dev/null
  kill -TERM "$REACTOR" 2>/dev/null
  kill -TERM "$LOCALCDN" 2>/dev/null
  kill -TERM "$FINALSERVE" 2>/dev/null
}

trap _term SIGTERM
trap _term SIGINT

(cd docs_experience && pub get && pub run build_runner watch -o ../cdn/docs-experience/latest/ -r) &
DOCS=$!
(cd ss_experience && pub get && pub run build_runner watch -o ../cdn/ss-experience/latest/ -r) &
SS=$!
(cd reactor_experience && pub get && pub run build_runner watch -o ../cdn/reactor-experience/latest/ -r) &
REACTOR=$!

PYTHON_VERSION_STRING="$(python -c 'import sys; print(".".join(map(str, sys.version_info[:1])))')"
if [ "$PYTHON_VERSION_STRING" = "2" ]; then
  (cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/cdn" && python -m SimpleHTTPServer 9000) &
  LOCALCDN=$!
else
  (cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/cdn" && python -m http.server 9000) &
  LOCALCDN=$!
fi

(cd shell && pub get && webdev serve -r -- --delete-conflicting-outputs) &
FINALSERVE=$!

wait
