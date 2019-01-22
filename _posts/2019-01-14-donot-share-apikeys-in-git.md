---
layout: post
title: How to safely share Secrets in Git hub repos.
description: Most of the time we are working on projects which are open-source, for so many reasons you want your secrets(i.e, API keys, Prod passwords, etc) to the trusted contributors. After several research I found this, let me know if you think there is even simpler than this.
author: author1
comments: true
cover: false
---

* this unordered seed list will be replaced by toc as unordered list
{:toc}

# Problem
Qucik solution to the problem - 
1. [https://qz.com/674520/companies-are-sharing-their-secret-access-codes-on-github-and-they-may-not-even-know-it/](Developers keep leaving secret keys to corporate data out in the open for anyone to take)
2. [https://labs.detectify.com/2016/04/28/slack-bot-token-leakage-exposing-business-critical-information/](Slack bot token leakage exposing business critical information)


# Workshop 
Let's consider a scenario to work with, say we have API keys to newsapi.org, and your Mobile app uses those keys to fetch the data from NewsAPI org. Now you have finished it, code is committed to Github repo with a secret key. 

Some other developers want to extend your app to develop the iOS app. All those are your friends, and you decided to remove the secret key and commit it. That is the right decision, but all your friends again need to get the newspaper registration process to get the API key. That process is a productivity killer.  

So far I found these three solutions, first use Github private repository(not free), seconds to use Bitbucket - it offers some free private repos. 

The third option is to use git secrets to share the encrypted file. 

## One-time steps: 
1. Install git secrets. [https://git-secret.io/installation](Follow this document). 
2. Create a GPG key using below commands.
~~~sh
gpg
gpg --list-keys
~~~
3. Export the public key to some known location. 
~~~sh
gpg --armor --export alice@cyb.org >> alice-public-key.txt
~~~

## On-Every repository:

1. Initilize the repo.
~~~sh
mkdir donotshare && cd donotshare
git init
echo "newsapi=secret-key" >> app.properties
~~~
2. Initialize the git secret configurations, it will create a .gitsecret folder in your repo. 
~~~sh
git secret init
ls -al
~~~
2. Add all secret files into a .gitignore file.
~~~sh
echo "app.properties" >> .gitignore
~~~
3. Now tell the person who can know the secret using below command.
~~~sh
git secret tell alice@cyb.org
~~~
4. Add the file to encrypt it. It will through an error if that file is not present in **.gitignore** file
~~~
git secret add app.properties
~~~
5. Now issue the command to hide. It will encrypt all. Note: You should do this before your commit it. 
~~~sh
git secret hide
~~~
6. Now its safe to commite and push to github. 
~~~
git  add .
git commit -m "app properties encrypted"
~~~

7. Cross check in your github account, it will not have `app.properties` file, but it will have encrypted `app.properties.secret`

## Adding trusted contributor use the existing secret key

### Say your friend Alice to required to know all the api key. 

1. Ask his public key via some secure channel. I share the public key via Gmail with encryption and expiry date on. 
Import the public key using 
~~~sh
gpg --import alice-public-key.txt
~~~
2. After you recieved his public key, add it to the key ring, so that Alice can decrypt using his private key. 
~~~sh
git secret tell alice@cyb.org
git commit -m "adding alice public key"
git push 
~~~

### Steps from Alice side

~~~sh
git secret reveal
ls -al
~~~

Knows mistakes or shortcuts: 
You can share your private key with Alice so that he can see secrets without his public key. This is HIGHLY DISCOURAGED.


Alice steps to reveal the secret key :
1. git pull
2. git secret reveal
    it might ask his private passpharse. 
3. done.
