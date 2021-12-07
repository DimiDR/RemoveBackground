import requests
from PIL import Image
import io
import os
import json
import time

start_time = time.time()

#resp = requests.post("http://localhost:5000", files={'file': open('ServicePic/NarutoHokage.png', 'rb')})
ref_size = 500

key = '*HY!cE!AY8EY@W16*RtfG21y34'

url = "http://127.0.0.1:8080/"
data = {'ref-size': ref_size,
        'greyscale': 'Ye', # noly "Yes" will give the geyscale picture
        'key': key}
filename = './PicInput/Naruto.png'
file_output_name = "Naruto{0}.png".format(ref_size)

files = [
    ('file', open(filename, 'rb')),
    ('data', ('data', json.dumps(data), 'application/json')),
]

resp = requests.post(url, files=files)
print(resp.status_code)
#print(resp.content)
#print(resp.json())
try:
    Image.open(io.BytesIO(resp.content)).save(os.path.join('./PicOutput', file_output_name))
    print('success')
except Exception as e:
    print('Error: {}'.format(resp.content))

print( time.time() - start_time )