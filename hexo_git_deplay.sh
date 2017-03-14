
#!/bin/bash

hexo clean
hexo generate 
hexo deploy
   
( cd /usr/local/hexo_static ; git pull origin; git push live master)




