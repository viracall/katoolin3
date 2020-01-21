import requests

class Repository:
    def __init__(self, base_url, branches=["main", "contrib", "non-free"]):
        self._base = base_url
        self._branches = branches
        
        if self._base[-1] != "/":
            self._base += "/"
        
    def _first_char(self, elem):
        if elem.startswith("lib"):
            return elem[:4]
        else:
            return elem[0]
        
    def __contains__(self, elem):
        for branch in self._branches:
            r = requests.get(
                "{}{}/{}/{}".format(
                    self._base,
                    branch,
                    self._first_char(elem),
                    elem
                ),
                allow_redirects=True,
                verify=True
            )
            
            if r.status_code == 200:
                return True
            elif r.status_code != 404:
                r.raise_for_status()
        else:
            return False
