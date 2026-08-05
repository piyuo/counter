# release/release_windows.sh
# This script builds the Flutter windows application and prepares it for release.
#!/bin/bash
msstore submission get 9NZ6VCXRJJZD | sed -n '/{/,$p' > meta.origin.json

python fix_meta_json.py