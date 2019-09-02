#!/usr/bin/env python3

import requests
import json
import traceback


def GetImageNames(repo_ip, repo_port):
    docker_images = []
    try:
        url1 = "http://" + repo_ip + ":" + str(repo_port) + "/v2/_catalog"
        res1 = requests.get(url1).content.strip()
        res_dic1 = json.loads(res1)
        images = res_dic1['repositories']
        for image in images:
            url2 = "http://" + repo_ip + ":" + str(repo_port) + "/v2/" + str(image) + "/tags/list"
            res2 = requests.get(url2).content.strip()
            res_dic2 = json.loads(res2)
            name = res_dic2['name']
            tags = res_dic2['tags']
            for tag in tags:
                image_name = str(repo_ip) + ":" + str(repo_port) + "/" + name + ":" + tag
                docker_images.append(image_name)
        
    except:
        traceback.print_exc()
    
    return docker_images

if __name__ == '__main__':
    ip = input('请输入仓库IP地址：')
    port = input('请输入仓库端口：')
    images = GetImageNames(ip,port)
    print(images)
