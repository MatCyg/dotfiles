#!/bin/bash

l="auth       sufficient     pam_tid.so"
f="/etc/pam.d/sudo"
t="/tmp/sudo"
## Add the following as the first line
#auth sufficient pam_tid.so
grep -q pam_tid.so $f || (  echo "$l" > $t && cat "$f" >> $t && sudo mv $t $f  )