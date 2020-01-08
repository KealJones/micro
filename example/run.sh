(cd docs_experience && pub get && pub run build_runner watch -o ../cdn/docs-experience/latest/ -r) &
(cd ss_experience && pub get && pub run build_runner watch -o ../cdn/ss-experience/latest/ -r) &
(cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/cdn" && python -m SimpleHTTPServer 9000) &
(cd shell && pub get && webdev serve -r -- --delete-conflicting-outputs) &
