import datetime

dt = datetime.datetime.now()
theDate = dt.strftime('%A, %B %d, %Y')
theTime = dt.strftime('%I:%M %p %Z')
theDay = dt.strftime('%j')
theWeek = dt.strftime('%U')

# OPENBOX PIPEMENU

print ('<?xml version=\"1.0\" encoding=\"UTF-8\"?>')
print ('<openbox_pipe_menu>')
print ('<separator />')
print ('<item label="DATE AND TIME" />')
print ('<separator />')
print ('<item label="'+theTime+'"/>')
print ('<item label="'+theDate+'"/>')
print ('<item label="'+'Day '+theDay+'"/>')
print ('<item label="'+'Week '+theWeek+'"/>')
print ('</openbox_pipe_menu>')
