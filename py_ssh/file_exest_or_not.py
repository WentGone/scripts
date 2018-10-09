#!/usr/bin/env python
import subprocess
import pipes

def file_exist_or_not(filelist):
    ssh_host = 'root@192.168.4.5'
    #file_name = '/etc/abc'
    with open(filelist) as fobj:
        for filename in fobj:
            filename = filename.strip('\n')
            resp = subprocess.call(
                   ['ssh', ssh_host, 'test -e ' + pipes.quote(filename)])

            if resp == 0:
                print '%s exists' % filename
            else:
                print '%s not exists' % filename


if '__main__' == __name__:
    file_exist_or_not('1.txt')
