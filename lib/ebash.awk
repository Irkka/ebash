#!/usr/bin/awk -f

{
  if ($0 !~ /.*(<%=.*%>|<%.*%>).*/)
    print $0
  else {
    line = $0
    match($0, /<%=.*%>/, tags)
    tag = tags[0]
    command = strip_tags(tags[0])
    (command|getline output)
    gsub(tag, output, line)
    print line
  }
}

function strip_tags(tag) {
  gsub(/(<%(=|\s)\s*)|(%>)/, "", tag)
  return tag
}
