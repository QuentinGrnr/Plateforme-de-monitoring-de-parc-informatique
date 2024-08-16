import psutil

pids = psutil.pids()

process_count = len(pids)
print(process_count)