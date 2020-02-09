#!/bin/bash

apt-rdepends --state-follow=NotInstalled "$1" 2>/dev/null | grep -v 'Depends:';

