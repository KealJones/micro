cd docs_experience && pub get && pub run build_runner build -o ../cdn/docs-experience/latest/ -r && cd .. &&
cd ss_experience && pub get && pub run build_runner build -o ../cdn/ss-experience/latest/ -r && cd .. &&
open run-cdn.command &&
cd shell &&
pub get &&
webdev serve -r -- --delete-conflicting-outputs
